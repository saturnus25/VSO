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
    Write-Host '[OK] STARTUP GATE: host, parser, versioned core, and essential catalogs verified.' -ForegroundColor Green
    exit 0
}catch{
    Write-VSO7StartupGateError -Message $_.Exception.Message
    exit 1
}
