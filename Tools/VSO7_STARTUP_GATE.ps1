[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Root,
    [ValidateSet('CLI','GUI')][string]$Mode='CLI'
)
$ErrorActionPreference='Stop'

function Write-VSO7StartupGateError {
    param([Parameter(Mandatory=$true)][string]$Message)
    [Console]::Error.WriteLine(('[ERROR] STARTUP GATE: {0}'-f$Message))
}


function Show-VSO7SupportWindowBanner {
    # Presentation only. No waits, child processes or changes to validation state.
    # The original launcher still owns the lifetime and exit code of this window.
    $width=80
    try{$width=[int][Console]::WindowWidth}catch{}
    if($width-lt1){$width=80}
    $inner=[Math]::Max(1,[Math]::Min(78,$width-2))
    $padding=' '*[Math]::Max(0,[int][Math]::Floor(($width-$inner-2)/2))
    $trueColor=(-not[string]::IsNullOrWhiteSpace([string]$env:WT_SESSION))
    try{if([Console]::IsOutputRedirected){$trueColor=$false}}catch{$trueColor=$false}

    function Write-SupportLine {
        param([string]$Text,[string]$Rgb='216;164;119',[string]$Fallback='Yellow',[switch]$Border)
        if($Border){$shown=$padding+$Text}else{
            if($Text.Length-gt$inner){$Text=$Text.Substring(0,$inner)}
            $left=[int][Math]::Floor(($inner-$Text.Length)/2)
            $shown=$padding+'│'+(' '*$left)+$Text+(' '*($inner-$left-$Text.Length))+'│'
        }
        if($trueColor){
            $esc=[char]27
            Write-Host ($esc+'[38;2;'+$Rgb+'m'+$shown+$esc+'[0m')
        }else{
            Write-Host $shown -ForegroundColor $Fallback
        }
    }

    $logo=@(
        '                             ████                  █████',
        '████        ████         ████████████           ███████████',
        '█████      ████         ████     ███          █████     █████',
        ' ████     ████          █████                ████         ████',
        '  ████    ███            ██████████          ███           ███',
        '   ████  ████                ████████        ███           ███',
        '    ████████                      ████       ████        █████',
        '     ██████             ██████  █████         ██████   █████',
        '      ████               ███████████            ██████████'
    )
    if($inner-lt61){
        $logo=@('██╗   ██╗ ███████╗  ██████╗',
                '██║   ██║ ██╔════╝ ██╔═══██╗',
                '██║   ██║ ███████╗ ██║   ██║',
                '╚██╗ ██╔╝ ╚════██║ ██║   ██║',
                ' ╚████╔╝  ███████║ ╚██████╔╝',
                '  ╚═══╝   ╚══════╝  ╚═════╝')
    }
    if($inner-lt27){$logo=@('VSO')}

    Write-Host ''
    Write-SupportLine -Text ('┌'+('─'*$inner)+'┐') -Border -Rgb '156;118;89' -Fallback DarkYellow
    Write-SupportLine ''
    foreach($row in $logo){Write-SupportLine -Text $row -Rgb '185;110;62' -Fallback DarkYellow}
    Write-SupportLine ''
    Write-SupportLine 'VICO SAFE OPTIMIZER · 1.2.0' -Rgb '216;164;119' -Fallback Yellow
    Write-SupportLine ''
    Write-SupportLine "DON'T CLOSE THIS WINDOW" -Rgb '235;206;174' -Fallback Yellow
    Write-SupportLine ''
    Write-SupportLine 'This support window stays open while VSO7 is running.' -Rgb '190;183;173' -Fallback Gray
    Write-SupportLine 'Use the main VSO7 window to continue.' -Rgb '190;183;173' -Fallback Gray
    Write-SupportLine 'This window closes automatically after a successful run.' -Rgb '190;183;173' -Fallback Gray
    Write-SupportLine ''
    Write-SupportLine 'Startup checks passed.' -Rgb '216;164;119' -Fallback Yellow
    Write-SupportLine ''
    Write-SupportLine -Text ('└'+('─'*$inner)+'┘') -Border -Rgb '156;118;89' -Fallback DarkYellow
    Write-Host ''
}

try{
    if([Environment]::OSVersion.Platform-ne[PlatformID]::Win32NT){ throw 'VSO7 only works on Windows.' }
    if($PSVersionTable.PSEdition-ne'Desktop'-or[version]$PSVersionTable.PSVersion-lt[version]'5.1'){
        throw 'Windows PowerShell Desktop 5.1 or later is required.'
    }
    if([Environment]::Is64BitOperatingSystem-and-not[Environment]::Is64BitProcess){
        throw 'The launcher must use native 64-bit Windows PowerShell.'
    }
    $rootInput=([string]$Root).Trim().Trim('"')
    if([string]::IsNullOrWhiteSpace($rootInput)){ throw 'The package root is invalid.' }
    $fullRoot=[IO.Path]::GetFullPath($rootInput)
    $core=Join-Path $fullRoot 'VSO7.ps1'
    $versioned=Join-Path $fullRoot 'VSO7_7.0.0_RC_R80.ps1'
    foreach($required in @($core,$versioned,(Join-Path $fullRoot 'Resources\VSO7_FEATURE_CATALOG.json'),(Join-Path $fullRoot 'Resources\VSO7_NATIVE_TWEAKS.json'),(Join-Path $fullRoot 'Resources\VSO7_APP_CATALOG.json'))){
        if(-not(Test-Path -LiteralPath $required -PathType Leaf)){ throw ('A required file is missing: {0}'-f$required) }
        $item=Get-Item -LiteralPath $required -Force -ErrorAction Stop
        if(($item.Attributes-band[IO.FileAttributes]::ReparsePoint)-ne0){ throw ('A required file is a reparse point: {0}'-f$required) }
    }
    if($Mode-eq'GUI'-and-not(Test-Path -LiteralPath (Join-Path $fullRoot 'Tools\VSO7_GUI_LAUNCH.ps1') -PathType Leaf)){
        throw 'Tools\VSO7_GUI_LAUNCH.ps1 is missing.'
    }
    $bytes=[IO.File]::ReadAllBytes($core)
    if($bytes.Length-lt3-or$bytes[0]-ne0xEF-or$bytes[1]-ne0xBB-or$bytes[2]-ne0xBF){ throw 'VSO7.ps1 is not UTF-8 with BOM.' }
    $tokens=$null;$errors=$null
    [void][System.Management.Automation.Language.Parser]::ParseFile($core,[ref]$tokens,[ref]$errors)
    if(@($errors).Count-ne0){ throw ('VSO7.ps1 parser: {0} error(s).'-f@($errors).Count) }
    $coreHash=(Get-FileHash -LiteralPath $core -Algorithm SHA256 -ErrorAction Stop).Hash.ToUpperInvariant()
    $versionedHash=(Get-FileHash -LiteralPath $versioned -Algorithm SHA256 -ErrorAction Stop).Hash.ToUpperInvariant()
    if($coreHash-cne$versionedHash){ throw 'VSO7.ps1 and the versioned copy are not byte-identical.' }
    $expectedCatalogs=@{
        'Resources\VSO7_FEATURE_CATALOG.json'='86C265A2902F0523721586D5E280C6740A080ABC5EE4122328AD7E7CE5033FC7'
        'Resources\VSO7_NATIVE_TWEAKS.json'='EECE7A13ED1EDF83BEE20FF59D29A7DEC2095EF7DCF0106F2B663565298F51F3'
        'Resources\VSO7_APP_CATALOG.json'='FEC26E1809258B83BAAC35689D1FEB82832369B97625FB93318BA7B5551592EC'
    }
    foreach($relative in $expectedCatalogs.Keys){
        $actual=(Get-FileHash -LiteralPath (Join-Path $fullRoot $relative) -Algorithm SHA256 -ErrorAction Stop).Hash.ToUpperInvariant()
        if($actual-cne[string]$expectedCatalogs[$relative]){ throw ('A locked catalog does not match its expected hash: {0}'-f$relative) }
    }
    if($Mode-eq'CLI'){
        # A presentation failure must not turn successful hard gates into a failure.
        try{Show-VSO7SupportWindowBanner}catch{
            Write-Host '[OK] Startup checks passed. Do not close this window while VSO7 is running.' -ForegroundColor Yellow
        }
    }else{
    Write-Host '[OK] STARTUP GATE: host, parser, versioned core, and essential catalogs verified.' -ForegroundColor Green
    }
    exit 0
}catch{
    Write-VSO7StartupGateError -Message $_.Exception.Message
    exit 1
}
