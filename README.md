# VSO7 — Vico Safe Optimizer

**VSO7** is a Windows 11 optimization tool focused on performance, responsiveness, and giving users more control over their systems.

It brings Windows tweaks, diagnostics, cleanup tools, app management, and recovery options together in one place while keeping potentially risky changes clearly separated from safer ones.

The idea behind VSO7 is simple: improve Windows without blindly disabling everything.

## Current interface

The current public version uses the **console interface**.

The graphical interface is still under development. It is not included as a supported launcher in this release and will probably not work correctly if invoked from the source code. Use `START VSO7.bat` to start the supported console version.

## Install with PowerShell

VSO7 can also be downloaded and extracted directly with PowerShell:

```powershell
$zip="$env:TEMP\VSO7-1.0.0.zip"; Invoke-WebRequest "https://github.com/saturnus25/VSO/releases/download/v1.0.0/VSO7-1.0.0.zip" -OutFile $zip; Expand-Archive $zip -DestinationPath ".\VSO7" -Force; Remove-Item $zip
```
This downloads the release package and extracts it into a VSO7 folder in the current directory.

## Features

- Windows 11 performance optimization
- Gaming-focused tweaks
- Network optimizations
- Graphics-related settings
- Privacy and debloat options
- Startup and background process management
- Windows app removal
- System cleanup tools
- Hardware and system information
- Recommendations based on the current PC
- Multiple optimization levels
- Recovery options for supported changes
- Built-in checks before potentially mutable operations
- English and Spanish interface support

## Optimization levels

VSO7 separates tweaks according to their purpose, risk, and expected impact.

You can use the safer recommended options, manually choose what to apply, or review more aggressive optimizations. More aggressive does not always mean better. A tweak may help a specific workload while being unnecessary or undesirable on another PC.

## Automatic optimization

VSO7 can analyze the system and prepare a recommended selection of tweaks and removable Windows apps.

Nothing is applied merely by opening automatic mode. You can review the proposed selection, remove individual items, recalculate it, or change the optimization objective before confirming.

For applications, automatic mode only proposes detected Appx packages classified as safe and selected by default in the VSO7 catalog. WinGet entries and special removal operations remain manual.

When tweaks and apps are processed together, tweaks run first. If that phase fails or is only partially completed, the app-removal phase does not start.

## Recovery

System optimization should be reversible whenever possible.

VSO7 records recovery information for supported changes and requires a restore point before relevant operations. Some changes cannot be reversed automatically, especially application removal and explicitly marked special operations.

Keep your own backups of important data before making major changes to Windows.

## Requirements

- Windows 11, 64-bit
- Windows PowerShell Desktop 5.1
- Administrator permissions for system changes

## Installation

1. Download `VSO7-7.0.0.zip` from the Releases section.
2. Extract the complete `VSO7` folder to a normal local folder.
3. Run:

```text
START VSO7.bat
```

Do not run VSO7 from inside the ZIP, from a network path, or by opening `VSO7.ps1` directly. The batch launcher performs the required startup checks and starts the protected PowerShell host.

If Windows blocks the downloaded PowerShell files, run:

```text
UNBLOCK VSO7.bat
```

Then run `START VSO7.bat` again.

## Language

English is the default language for a clean installation. You can switch between English and Spanish from the language option in the console menu. The selected language is saved for future runs.

## Verifying the download

The release includes a SHA-256 file next to the ZIP. You can verify the downloaded archive with PowerShell:

```powershell
Get-FileHash -LiteralPath '.\VSO7-7.0.0.zip' -Algorithm SHA256
```

Compare the result with `VSO7-7.0.0.zip.sha256` or the release checksum shown on GitHub. The extracted folder also contains `SHA256SUMS.txt` with the hash of every other packaged file.

## Source code

VSO7 is written in PowerShell. `VSO7.ps1` is both the program executed by the launcher and its source code, so a separate source archive would contain substantially the same files. The source is already included in the downloadable ZIP.

`VSO7_7.0.0_RC_R80.ps1` is an identical compatibility copy required by the startup integrity check. It is not a different edition of the program.

Bug reports and suggestions should include the action being performed, the exact error message, and the relevant VSO7 log when available.

## Disclaimer

VSO7 modifies Windows settings and system configuration.

No optimization tool can guarantee the same result on every computer. Windows builds, hardware, drivers, installed software, and individual usage can all affect the result of a tweak.

Review the proposed changes before applying them. Use aggressive or experimental options only when you understand what they change.

## License

VSO7 is licensed under the [MIT License](LICENSE).

Third-party notices and licenses are documented in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [LICENSE.Win11Debloat.txt](LICENSE.Win11Debloat.txt).
