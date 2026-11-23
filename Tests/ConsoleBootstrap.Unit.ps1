param([string]$SourcePath=(Join-Path (Split-Path -Parent $PSScriptRoot) 'VSO7.ps1'))

$ErrorActionPreference='Stop'
$tokens=$null
$errors=$null
$ast=[Management.Automation.Language.Parser]::ParseFile($SourcePath,[ref]$tokens,[ref]$errors)
if($errors.Count){throw ($errors -join [Environment]::NewLine)}
$builder=$ast.Find({
    param($node)
    $node -is [Management.Automation.Language.FunctionDefinitionAst] -and
        $node.Name -eq 'New-VSO7ConsoleBootstrapCommandVSO'
},$true)
. ([ScriptBlock]::Create($builder.Extent.Text))

$exe=Join-Path ([Environment]::SystemDirectory) 'WindowsPowerShell\v1.0\powershell.exe'
$sid=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value
$testRoot=Join-Path ([IO.Path]::GetTempPath()) ('VSO7.ConsoleProbe.'+[guid]::NewGuid().ToString('N'))
[void][IO.Directory]::CreateDirectory($testRoot)
$current=[Diagnostics.Process]::GetCurrentProcess()

function Assert-Probe([bool]$Condition,[string]$Message){
    if(-not$Condition){throw $Message}
    Write-Output ('PASS '+$Message)
}

function Start-ProbeBroker {
    param([string]$Case,[Diagnostics.Process]$Owner,[switch]$PreferTerminal,[int]$PayloadExit)
    $stage=Join-Path $testRoot ($Case+'.stage')
    $result=$stage+'.json'
    [IO.File]::WriteAllText($stage,'inert test fixture')
    $payload=@"
Add-Type 'using System;using System.Runtime.InteropServices;public static class VSO7ProbeWindow{[DllImport("kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool IsWindowVisible(IntPtr h);}'
[pscustomobject]@{Pid=`$PID;WindowVisible=[VSO7ProbeWindow]::IsWindowVisible([VSO7ProbeWindow]::GetConsoleWindow());Terminal=[bool]`$env:WT_SESSION}|ConvertTo-Json|Set-Content -LiteralPath '$($result.Replace("'","''"))'
exit $PayloadExit
"@
    $wrapper=New-VSO7ConsoleBootstrapCommandVSO -Wrapper $payload -PowerShellExe $exe -ExpectedUserSid $sid -StagePath $stage -PreferTerminal:$PreferTerminal -LauncherPid $Owner.Id -LauncherStartTicks ($Owner.StartTime.ToUniversalTime().Ticks)
    if($Case-eq'fallback'){
        $wrapper=$wrapper.Replace('$appx=Join-Path',"throw 'Forced Terminal test failure'; `$appx=Join-Path")
    }
    if($Case-eq'cancel'){
        # Keep the real console child alive before it connects to the broker.
        $waitingGreeting=@'
$greeting=@"
[IO.File]::WriteAllText('$($stagePath.Replace("'","''")).waiting',[string]`$PID)
Start-Sleep -Milliseconds 3500
'@
        $wrapper=$wrapper.Replace('$greeting=@"',$waitingGreeting)
    }
    [void][ScriptBlock]::Create($wrapper)
    $encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($wrapper))
    $info=[Diagnostics.ProcessStartInfo]::new($exe,('-NoLogo -NoProfile -EncodedCommand '+$encoded))
    $info.UseShellExecute=$true
    $info.WindowStyle=[Diagnostics.ProcessWindowStyle]::Hidden
    $process=[Diagnostics.Process]::Start($info)
    [pscustomobject]@{Process=$process;Stage=$stage;Result=$result}
}

function Complete-ProbeBroker($Probe){
    try{
        if(-not$Probe.Process.WaitForExit(22000)){
            $Probe.Process.Kill()
            $Probe.Process.WaitForExit()
            throw 'Fixture broker timed out.'
        }
        $result=if([IO.File]::Exists($Probe.Result)){Get-Content -LiteralPath $Probe.Result -Raw|ConvertFrom-Json}
        [pscustomobject]@{ExitCode=$Probe.Process.ExitCode;BrokerPid=$Probe.Process.Id;Result=$result;StageExists=[IO.File]::Exists($Probe.Stage)}
    }finally{$Probe.Process.Dispose()}
}

try{
    $classic=Complete-ProbeBroker (Start-ProbeBroker -Case 'classic' -Owner $current -PayloadExit 17)
    Assert-Probe ($classic.ExitCode-eq17-and$classic.Result.Pid-ne$classic.BrokerPid-and$classic.Result.WindowVisible-and-not$classic.Result.Terminal-and-not$classic.StageExists) 'Compatibility starts a visible Console Host and preserves the PowerShell exit code.'

    $fallback=Complete-ProbeBroker (Start-ProbeBroker -Case 'fallback' -Owner $current -PreferTerminal -PayloadExit 19)
    Assert-Probe ($fallback.ExitCode-eq19-and$fallback.Result.Pid-ne$fallback.BrokerPid-and$fallback.Result.WindowVisible-and-not$fallback.Result.Terminal-and-not$fallback.StageExists) 'Terminal startup failure uses a separate, visible Console Host.'

    $package=Get-AppxPackage -Name Microsoft.WindowsTerminal -ErrorAction SilentlyContinue |
        Where-Object {$_.PackageFamilyName-ceq'Microsoft.WindowsTerminal_8wekyb3d8bbwe'} |
        Select-Object -First 1
    if($package){
        $terminal=Complete-ProbeBroker (Start-ProbeBroker -Case 'terminal' -Owner $current -PreferTerminal -PayloadExit 0)
        Assert-Probe ($terminal.ExitCode-eq0-and$terminal.Result.Terminal-and$terminal.Result.Pid-ne$terminal.BrokerPid-and-not$terminal.StageExists) 'The default handoff reaches the real Windows Terminal.'
    }else{Write-Output 'SKIP Windows Terminal is unavailable in this test account.'}

    $ownerInfo=[Diagnostics.ProcessStartInfo]::new($exe,'-NoLogo -NoProfile -Command "[void][Console]::ReadLine()"')
    $ownerInfo.UseShellExecute=$false
    $ownerInfo.CreateNoWindow=$true
    $ownerInfo.RedirectStandardInput=$true
    $owner=[Diagnostics.Process]::Start($ownerInfo)
    try{
        $probe=Start-ProbeBroker -Case 'cancel' -Owner $owner
        try{
            $deadline=[DateTime]::UtcNow.AddSeconds(10)
            while(-not[IO.File]::Exists($probe.Stage+'.waiting')-and-not$probe.Process.HasExited-and[DateTime]::UtcNow-lt$deadline){Start-Sleep -Milliseconds 50}
            Assert-Probe ([IO.File]::Exists($probe.Stage+'.waiting')) 'The test reached the pending console handoff.'
            $client=[Diagnostics.Process]::GetProcessById([int][IO.File]::ReadAllText($probe.Stage+'.waiting'))
            try{
                [void]$client.Handle
                $owner.StandardInput.Close()
                if(-not$owner.WaitForExit(5000)){throw 'Fixture launcher did not exit.'}
                if(-not$probe.Process.WaitForExit(3000)){throw 'The broker did not cancel promptly after its launcher closed.'}
                Assert-Probe ($client.WaitForExit(6000)-and$client.ExitCode-eq0) 'A late PowerShell child exits after its broker cancels startup.'
            }finally{
                if(-not$client.HasExited){$client.Kill();$client.WaitForExit()}
                $client.Dispose()
            }
            $cancelled=Complete-ProbeBroker $probe
            $probe=$null
            Assert-Probe ($cancelled.ExitCode-eq0-and$null-eq$cancelled.Result-and-not$cancelled.StageExists) 'Closing the launcher cancels a pending handoff and removes the staged script.'
        }finally{
            if($probe){
                if(-not$probe.Process.HasExited){$probe.Process.Kill();$probe.Process.WaitForExit()}
                $probe.Process.Dispose()
            }
        }
    }finally{
        if(-not$owner.HasExited){$owner.Kill();$owner.WaitForExit()}
        $owner.Dispose()
    }
}finally{
    $current.Dispose()
    foreach($file in [IO.Directory]::EnumerateFiles($testRoot)){[IO.File]::Delete($file)}
    [IO.Directory]::Delete($testRoot)
}
