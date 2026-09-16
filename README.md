<img width="1918" height="1027" alt="image" src="https://github.com/user-attachments/assets/2c4aa5b7-23c0-44a3-9470-7bd7a27532ae" />


# VSO7 — Vico Safe Optimizer

VSO7 is a Windows 11 optimization tool focused on performance, responsiveness, and giving users more control over their systems.

It brings Windows tweaks, diagnostics, cleanup tools, app management, and recovery options together in one place while keeping potentially risky changes clearly separated from safer ones.

The idea behind VSO7 is simple: improve Windows without blindly disabling everything.

## AI Development Notice

VSO has been developed in large part with the assistance of AI.

AI tools have been used for code generation, debugging, testing, documentation, and development support throughout the project. The final decisions, testing, integration, and maintenance of VSO are handled by the project owner.

## Current version

**VSO7 1.2.0**

## Current interface

The current public version uses the console interface.

The large console header uses a shorter logo frame, with the version beside the logo. Menus choose their header before drawing: compact when it helps the page fit a small viewport, and full when there is enough room. Resizing recalculates the layout.

Control menus retain their frames when arranged in columns. The manual application selector also supports animated backgrounds, including its combined option/search prompt and search-result picker.

The donut, rotating shapes and galaxy keep their native viewport size while their lateral position, inset and height vary between screens. Upper and lower positions take priority over the middle, and placement considers how much the UI would hide. A large box may still mask part of a figure; the figure is not reduced to fit a gap. Placement stays stable within the current screen and is recalculated on resize. Fireworks and bouncing balls retain their original distributed motion.

**Flame Fire** adds a richer fire background using the glyphs and warm flame colors of the supplied AsciiForge animation export. It plays through VSO's existing renderer at 30 frames per second, loops the 900-frame sequence and adapts to the viewport. The original **Fire** background remains available. Both use VSO's UI protection and edge fade.

The graphical interface is still under development. It is not included as a supported launcher in this release and will probably not work correctly if invoked from the source code. Use `START VSO7.bat` to start the supported console version.

## Install with PowerShell

VSO7 can also be downloaded and extracted directly with PowerShell:

```powershell
$zip="$env:TEMP\VSO7-1.2.0.zip"; Invoke-WebRequest "https://github.com/saturnus25/VSO/releases/latest/download/VSO7-1.2.0.zip" -OutFile $zip -ErrorAction Stop; Expand-Archive $zip -DestinationPath ".\VSO7" -Force; Remove-Item $zip
```

This downloads the release package and extracts it into a VSO7 folder in the current directory.

## Console automation

VSO7 improves automation in the console interface, especially for users who do not want to choose every Windows tweak manually.

Windows tweak categories can now generate recommendations for the current section using VSO7's existing recommendation system. The proposed selection remains fully editable before anything is applied.

The optimization objective can be changed before recalculating recommendations, and sections without safe automatic candidates remain available for manual selection instead of falling back to unrelated tweaks.

Application recommendations keep their own conservative policy and are not affected by the tweak optimization objective.

Console Mode includes selectable animated ASCII backgrounds in the Vicore palette, with responsive menus. Choose a background, Random, or Disabled from **Language / appearance → Animated background**. Random is the default for new preferences. Press **Ctrl+F** at a menu prompt for manual freeze/resume. Backgrounds keep animating on long Windows Terminal pages and fade smoothly toward black at both the top and bottom of the active viewport. Windows Terminal may show a static historical snapshot while you scroll up; returning fully to the bottom shows the live animation at its current time.

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

Nothing is applied merely by opening automatic mode. You can review the proposed selection, add or remove individual items, clear it, recalculate it, or change the optimization objective before confirming.

Windows tweak recommendations can also be generated directly inside supported tweak categories, limited to the current section. VSO7 still leaves options manual when it cannot safely decide that they are appropriate for every user.

VSO7 recognizes Game Mode when the same target is already applied and protected by native Recovery. The Extreme selector displays it as **Already applied** and excludes it from risk shortcuts; System Tools and automatic preset plans also preserve the original rollback instead of trying to create a second recovery owner. Different or ambiguous ownership remains blocked and is reported without crashing the System Tools menu.

For applications, automatic mode only proposes detected Appx packages classified as safe and selected by default in the VSO7 catalog. WinGet entries and special removal operations remain manual.

When tweaks and apps are processed together, tweaks run first. If that phase fails or is only partially completed, the app-removal phase does not start.

## Recovery

System optimization should be reversible whenever possible.

VSO7 records recovery information for supported changes and requires a restore point before relevant operations. Some changes cannot be reversed automatically, especially application removal and explicitly marked special operations.

Pending-restart detection reports the exact Windows signal that triggered it. CBS and Windows Update reboot keys, a nonzero `UpdateExeVolatile`, a pending computer rename, and populated file-rename operations are recognized. An existing but empty `PendingFileRenameOperations` value is ignored instead of producing a false positive.

Keep your own backups of important data before making major changes to Windows.

## Requirements

- Windows 11, 64-bit

- Windows PowerShell Desktop 5.1

- Administrator permissions for system changes

## Running VSO7

Extract the complete `VSO7` folder and run `START VSO7.bat`.

VSO7 checks for a registered, usable Microsoft Windows Terminal package before creating its elevated host. When that candidate exists, the interactive console opens in Windows Terminal. The support window remains open while VSO7 is running. Administrator elevation and protected source verification still take place before VSO7 starts.

If Windows Terminal is not installed, VSO7 starts its verified elevated host directly in a visible built-in Windows console; it does not first wait inside a hidden Terminal broker. If a Terminal candidate exists but later executable validation, launch, or protected handoff fails before VSO starts, the guarded broker fallback uses the built-in console without requesting elevation again. In that host, scrolling or selecting text can pause the animated background. A failure after the Terminal payload has started is reported and never launches a duplicate VSO instance.

Do not run VSO7 from inside the ZIP, from a network path, or by opening `VSO7.ps1` directly. The batch launcher performs the required startup checks and starts the protected PowerShell host.

If Windows blocks the downloaded PowerShell files, run `UNBLOCK VSO7.bat` once and then start VSO7 again.

## Verifying the download

The release includes a SHA-256 file next to the ZIP. Verify the downloaded archive with PowerShell:

```powershell
Get-FileHash -LiteralPath '.\VSO7-1.2.0.zip' -Algorithm SHA256
```

The expected SHA-256 for this release is:

```text
134643b18efcbefaaa6ad3f90f971f471d27ec479c8cd40e78fbc1ae920bfb0c
```

The extracted folder also contains `SHA256SUMS.txt` with the hash of every other packaged file.

## Source code

VSO7 is written in PowerShell. `VSO7.ps1` is both the program executed by the launcher and its source code. The downloadable ZIP also includes the source used by that release.

`VSO7_7.0.0_RC_R80.ps1` is an identical compatibility copy required by the startup integrity check. It is not a different edition of the program.

Bug reports should include the action being performed, the exact error message, and the relevant VSO7 log when available.

## Language

English is the default language for a clean installation. You can switch between English and Spanish from the language option in the console menu. The selected language is saved for future runs.

## Disclaimer

VSO7 modifies Windows settings and system configuration.

No optimization tool can guarantee the same result on every computer. Windows builds, hardware, drivers, installed software, and individual usage can all affect the result of a tweak.

Review the proposed changes before applying them. Use aggressive or experimental options only when you understand what they change.

## License

VSO7 is licensed under the [MIT License](LICENSE).

Third-party notices and licenses are documented in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [LICENSE.Win11Debloat.txt](LICENSE.Win11Debloat.txt).
