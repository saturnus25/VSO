param([string]$SourcePath=(Join-Path (Split-Path -Parent $PSScriptRoot) 'VSO7.ps1'))

$ErrorActionPreference='Stop'
$source=[IO.File]::ReadAllText([IO.Path]::GetFullPath($SourcePath))
$tokens=$null
$errors=$null
$ast=[Management.Automation.Language.Parser]::ParseInput($source,[ref]$tokens,[ref]$errors)
if(@($errors).Count){throw ('VSO7 parser errors: '+@($errors).Count)}

function Assert-Test([bool]$Condition,[string]$Message){
    if(-not$Condition){throw $Message}
    Write-Output ('PASS '+$Message)
}

function Get-FunctionText([string]$Name){
    $nodes=@($ast.FindAll({param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq $Name},$true))
    if($nodes.Count-ne1){throw ('Expected one function named '+$Name)}
    return $nodes[0].Extent.Text
}

# Exercise the actual inventory function with fake services, never the live service manager.
Invoke-Expression (Get-FunctionText 'Get-VSO7ServiceDependencyInventoryVSO')
function Get-Service { return $script:FakeServices }
$script:FakeServices=@()
Assert-Test (@(Get-VSO7ServiceDependencyInventoryVSO).Count-eq0) 'Service inventory: zero services'
$script:FakeServices=@([pscustomobject]@{Name='missing';DisplayName='Missing';Status='Stopped';DependentServices=@();ServicesDependedOn=@()})
Assert-Test (@(Get-VSO7ServiceDependencyInventoryVSO).Count-eq0) 'Service inventory: empty dependencies excluded'
$script:FakeServices=@([pscustomobject]@{Name='one';DisplayName='One';Status='Running';DependentServices=@();ServicesDependedOn=@([pscustomobject]@{Name='base'})})
$one=@(Get-VSO7ServiceDependencyInventoryVSO)
Assert-Test ($one.Count-eq1 -and $one[0].ServicesDependedOn[0]-eq'base') 'Service inventory: one dependent service'
$script:FakeServices+=,[pscustomobject]@{Name='two';DisplayName='Two';Status='Stopped';DependentServices=@([pscustomobject]@{Name='one'});ServicesDependedOn=@()}
Assert-Test (@(Get-VSO7ServiceDependencyInventoryVSO).Count-eq2) 'Service inventory: multiple services'

$fingerprint=Get-FunctionText 'Get-VSO7NativeRegistryKeyFingerprintVSO'
Assert-Test ($fingerprint.Contains('[AllowEmptyString()][string]$RelativePath') -and $fingerprint.Contains("& `$appendValue `$root ''")) 'Registry fingerprint: empty relative path is accepted for root'
Assert-Test ($fingerprint.Contains('if([string]::IsNullOrEmpty($RelativePath))') -and $fingerprint.Contains('$RelativePath+')) 'Registry fingerprint: child paths are constructed from the root'
function Test-RelativeRoot([Parameter(Mandatory=$true)][AllowEmptyString()][string]$RelativePath){return ('root='+$RelativePath)}
Assert-Test ((Test-RelativeRoot '')-eq'root=') 'Windows PowerShell binds an empty root path'
$registryOperation=Get-FunctionText 'Invoke-VSO7NativeRegistryOperationVSO'
Assert-Test ($registryOperation.Contains("'DeleteKey' {") -and $registryOperation.Contains('if(-not(Test-VSO7NativeRegistryKeyExistsVSO -Path $path))') -and $registryOperation.Contains('Add-VSO7NativeKeyBackupVSO') -and $registryOperation.Contains('Remove-VSO7NativeRegistryKeyRawVSO')) 'DeleteKey: absent key is a no-op; present key is backed up before deletion'
Invoke-Expression $registryOperation
function Test-VSO7NativeRegistryKeyExistsVSO {return $script:FakeKeyExists}
function Add-VSO7NativeKeyBackupVSO {$script:BackupCalls++;return $script:FakeKeyEntry}
function Test-VSO7NativeRegistryKeyBaselineMatchVSO {return $true}
function Remove-VSO7NativeRegistryKeyRawVSO {$script:RemoveCalls++;$script:FakeKeyExists=$false}
function Save-VSO7NativeBackupSessionVSO {$script:SaveCalls++}
$script:FakeKeyEntry=[pscustomobject]@{Status='Pending';AppliedExists=$null}
$script:FakeKeyExists=$false;$script:BackupCalls=0;$script:RemoveCalls=0;$script:SaveCalls=0
$fakeOperation=[pscustomobject]@{Action='DeleteKey';Path='HKEY_CURRENT_USER\Software\VSO7TestOnly'}
Invoke-VSO7NativeRegistryOperationVSO -Session ([pscustomobject]@{}) -Operation $fakeOperation
Assert-Test ($script:BackupCalls-eq0 -and $script:RemoveCalls-eq0) 'DeleteKey: missing key causes no backup or mutation'
$script:FakeKeyExists=$true
Invoke-VSO7NativeRegistryOperationVSO -Session ([pscustomobject]@{}) -Operation $fakeOperation
Assert-Test ($script:BackupCalls-eq1 -and $script:RemoveCalls-eq1 -and $script:SaveCalls-eq1 -and $script:FakeKeyEntry.Status-eq'Applied' -and -not$script:FakeKeyEntry.AppliedExists) 'DeleteKey: existing key is backed up, removed, verified, and recorded'
$keyBackup=Get-FunctionText 'Add-VSO7NativeKeyBackupVSO'
$keyRestore=Get-FunctionText 'Restore-VSO7NativeBackupSessionVSO'
Assert-Test ($keyBackup.Contains('Get-VSO7NativeRegistryKeyFingerprintVSO') -and $keyBackup.Contains('Assert-VSO7NativeRegistryExportFileVSO') -and $keyRestore.Contains('Test-VSO7NativeRegistryKeyBaselineMatchVSO') -and $keyRestore.Contains('reg import')) 'DeleteKey: fingerprint, export, and restore paths remain connected'
$engine=Get-FunctionText 'Invoke-VSO7NativeTweaksVSO'
Assert-Test ($engine.Contains("$"+'featureResult.Status='+"'Failed'") -and $engine.Contains("$"+'session.Status='+"'Partial'") -and $engine.Contains('Save-VSO7NativeBackupSessionVSO -Session $session')) 'Native batch: subsequent failure persists Failed and Partial state'

# Compile the exact C# declaration from the source in this isolated test process.
$init=Get-FunctionText 'Initialize-VSO7PowerReadApiVSO'
Assert-Test ($init.Contains('public static class PowerReadNative') -and $init.Contains('public static extern UInt32 PowerReadACValueIndex') -and $init.Contains('public static extern UInt32 PowerReadDCValueIndex')) 'PowerReadNative: type and both methods are public'
Invoke-Expression $init
Initialize-VSO7PowerReadApiVSO
$nativeType='VSO7.PowerReadNative' -as [type]
Assert-Test ($null-ne$nativeType -and $null-ne$nativeType.GetMethod('PowerReadACValueIndex') -and $null-ne$nativeType.GetMethod('PowerReadDCValueIndex')) 'PowerReadNative: type and read methods resolve in Windows PowerShell'
$powerSnapshot=Get-FunctionText 'Get-VSO7PowerSettingProviderSnapshotVSO'
Assert-Test ($powerSnapshot.IndexOf('Initialize-VSO7PowerReadApiVSO')-lt$powerSnapshot.IndexOf('[VSO7.PowerReadNative]::PowerReadACValueIndex') -and $powerSnapshot.Contains('if($acRc-ne0-or$dcRc-ne0)')) 'Power snapshot: type initializes before both reads and rejects unavailable values'
$applicability=Get-FunctionText 'Get-VSO7FeatureApplicabilityVSO'
Assert-Test ($applicability.Contains('Get-VSO7NativePowerSettingSnapshotVSO') -and $applicability.Contains('RequireDifferentFrom')) 'Applicability: power values are read and compared, not assumed'
Invoke-Expression (Get-FunctionText 'Complete-VSO7ApplicabilityResultVSO')
Invoke-Expression $applicability
function Get-VSO7ApplicabilityContextVSO {return [pscustomobject]@{}}
function Get-VSO7NativePowerSettingSnapshotVSO {if($null-eq$script:FakePowerSnapshot){throw 'Power API no pudo leer el ajuste.'};return $script:FakePowerSnapshot}
$usbFeature=[pscustomobject]@{Applicability=[pscustomobject]@{PowerSetting=[pscustomobject]@{SubGroupAlias='SUB_USB';SettingAlias='USBSELECTIVE';RequireDifferentFrom=1}}}
$script:FakePowerSnapshot=[pscustomobject]@{SchemeGuid='381b4222-f694-41f0-9685-ff5bb260df2e';AC=1;DC=1}
$usb=Get-VSO7FeatureApplicabilityVSO -Feature $usbFeature
Assert-Test ($usb.Status-eq'ALREADY_OPTIMAL' -and -not$usb.Applicable) 'USB selective suspend: enabled on AC and DC is already optimal'
$script:FakePowerSnapshot=[pscustomobject]@{SchemeGuid='381b4222-f694-41f0-9685-ff5bb260df2e';AC=0;DC=1}
$usb=Get-VSO7FeatureApplicabilityVSO -Feature $usbFeature
Assert-Test ($usb.Status-eq'AVAILABLE' -and $usb.Applicable) 'USB selective suspend: disabled on one side is available for correction'
$script:FakePowerSnapshot=[pscustomobject]@{SchemeGuid='11111111-2222-3333-4444-555555555555';AC=0;DC=0}
$usb=Get-VSO7FeatureApplicabilityVSO -Feature $usbFeature
Assert-Test ($usb.Status-eq'AVAILABLE' -and $usb.Applicable) 'USB selective suspend: custom plan uses its own read values'
$script:FakePowerSnapshot=$null
$usb=Get-VSO7FeatureApplicabilityVSO -Feature $usbFeature
Assert-Test ($usb.Status-eq'UNKNOWN' -and -not$usb.Applicable) 'USB selective suspend: unreadable value remains unknown'

# Run the exact three count expressions with fake Get-MpPreference values.
$sanity=Get-FunctionText 'Get-VSO7TuningSanityFindingsVSO'
$countBlock=[regex]::Match($sanity,'(?s)\$exPath=@\(\$mp\.ExclusionPath\|Where-Object.*?\$exExt=@\(\$mp\.ExclusionExtension\|Where-Object.*?\.Count')
if(-not$countBlock.Success){throw 'Defender counter block not found'}
$cases=@(
    @{Name='all empty';Path=@();Process=@();Extension=@();Expected='0,0,0'},
    @{Name='nine paths';Path=@('a','b','c','d','e','f','g','h','i');Process=@();Extension=@();Expected='9,0,0'},
    @{Name='one process';Path=@();Process=@('app.exe');Extension=@();Expected='0,1,0'},
    @{Name='one extension';Path=@();Process=@();Extension=@('.tmp');Expected='0,0,1'},
    @{Name='null and blanks';Path=@($null,'',' ');Process=@($null,'');Extension=@(' ', $null);Expected='0,0,0'},
    @{Name='mixed';Path=@($null,'one',' ','two');Process=@('app.exe','');Extension=@($null,'.tmp');Expected='2,1,1'}
)
foreach($case in $cases){
    $mp=[pscustomobject]@{ExclusionPath=$case.Path;ExclusionProcess=$case.Process;ExclusionExtension=$case.Extension}
    Invoke-Expression $countBlock.Value
    Assert-Test (('{0},{1},{2}'-f$exPath,$exProc,$exExt)-eq$case.Expected) ('Defender counts: '+$case.Name)
}
Assert-Test ($sanity.Contains("'paths={0}; processes={1}; extensions={2}'-f$"+'exPath,$exProc,$exExt')) 'Defender display uses the filtered counts'

$storage=Get-FunctionText 'Get-VSO7StorageHealthVSO'
Assert-Test ($storage.Contains('return $out') -and -not$storage.Contains('$out.ToArray()')) 'Storage inventory: ordinary PowerShell arrays do not call ToArray'
Invoke-Expression $storage
function Get-PhysicalDisk {return $script:FakeDisks}
function Get-StorageReliabilityCounter {return $null}
$script:FakeDisks=@()
Assert-Test (@(Get-VSO7StorageHealthVSO).Count-eq0) 'Storage inventory: zero disks'
$script:FakeDisks=@([pscustomobject]@{FriendlyName='Mock disk';SerialNumber='test';MediaType='SSD';BusType='NVMe';HealthStatus='Healthy';OperationalStatus=@('OK');Size=1024})
Assert-Test (@(Get-VSO7StorageHealthVSO).Count-eq1) 'Storage inventory: one disk'
Write-Output 'PASS all isolated regression checks; VSO7.ps1 was parsed, not launched.'
