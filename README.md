<p align="center">
  <img width="640" alt="Vico Safe Optimizer" src="https://github.com/user-attachments/assets/83a53a05-755c-481e-823e-61cf38038eec">
</p>

# VSO7 · Vico Safe Optimizer

**A Windows 11 toolkit for performance, diagnostics, cleanup, and system control.** Review recommended changes for your PC, choose what to apply, and track supported changes in Recovery.

[![Latest release](https://img.shields.io/github/v/release/saturnus25/VSO?style=for-the-badge&logo=github&label=Latest%20release&color=287a99)](https://github.com/saturnus25/VSO/releases/latest)
[![Windows 11 x64](https://img.shields.io/badge/Windows%2011-x64-0078d4?style=for-the-badge)](#requirements)
[![PowerShell Gallery](https://img.shields.io/badge/PowerShell-Gallery-394989?style=for-the-badge)](https://www.powershellgallery.com/packages/VSO)
[![MIT license](https://img.shields.io/badge/License-MIT-38845a?style=for-the-badge)](LICENSE)

[Download](https://github.com/saturnus25/VSO/releases/latest) · [Quick start](#quick-start) · [Recovery](#applying-changes-and-using-recovery) · [English guide](VSO7_TECHNICAL_USER_GUIDE_EN.md) · [Manual en español](VSO7_MANUAL_TECNICO_ES.md) · [Ideas](https://github.com/saturnus25/VSO/discussions/categories/ideas) · [Issues](https://github.com/saturnus25/VSO/issues)

## Tools at a glance

| Tune Windows | Review recommendations |
| :--- | :--- |
| Explore gaming, network, graphics, privacy, startup, and background-process settings grouped by purpose and risk. | Generate a proposal for your PC or a supported tweak category. Change the optimization goal and edit the selection before confirming. |
| **Manage apps and storage** | **Diagnose and recover** |
| Review installed Windows apps, remove selected packages, and use the cleanup tools. | View hardware and system information, check for pending restarts, and roll back supported changes from Recovery. |

## Quick start

### Requirements

- Windows 11 x64
- Windows PowerShell 5.1 (Desktop edition)
- Administrator permissions to apply system changes

### Install with PowerShell

The [official VSO module](https://github.com/saturnus25/VSO-PowerShell-Module) installs and manages releases. Run these commands if you have PSResourceGet.

```powershell
Install-PSResource VSO
Install-VSO
```

With PowerShellGet on Windows PowerShell 5.1, use `Install-Module VSO` followed by `Install-VSO`. The installer supports custom paths and per-user or all-user installs. Installation and Windows optimization are separate steps.

<details>
<summary><strong>PowerShell lifecycle commands</strong></summary>

```powershell
Install-VSO -Path "D:\VSO"
Start-VSO
Stop-VSO
Update-VSO
Get-VSOStatus
Get-VSOInstallation
Help-VSO
Reset-VSO -WhatIf
```

`Stop-VSO` inspects running instances and requires `-Force` to terminate one. `Reset-VSO` removes attributable application files. Use VSO7 Recovery to restore supported Windows settings. The module has its own source-available license and versioning. See the [module documentation](https://github.com/saturnus25/VSO-PowerShell-Module) for its removal options.

</details>

### Run from the ZIP

1. Download the complete ZIP from [the latest release](https://github.com/saturnus25/VSO/releases/latest).
2. Extract the entire `VSO7` folder to a local drive.
3. Run **`START VSO7.bat`** for the supported console interface. If Windows blocks the downloaded scripts, run **`UNBLOCK VSO7.bat`** once and then start VSO7.

Use the batch launcher from the extracted folder so it can check the source files and start the elevated PowerShell host. Windows Terminal is used when available, with the built-in console as a fallback. The graphical interface is still in development.

<details>
<summary><strong>Verify the downloaded archive</strong></summary>

Download the matching `.sha256` file next to the ZIP under [release assets](https://github.com/saturnus25/VSO/releases/latest). Compare its value with the result of `Get-FileHash`, using the name of the archive you downloaded.

```powershell
Get-FileHash -LiteralPath '.\VSO7-1.2.2.zip' -Algorithm SHA256
```

The extracted release also includes `SHA256SUMS.txt` for the packaged files.

</details>

## Console and appearance

<img width="960" alt="VSO7 interface preview" src="https://github.com/user-attachments/assets/2c4aa5b7-23c0-44a3-9470-7bd7a27532ae">

The console supports **English and Spanish** and remembers your selection. Under **Language / appearance → Animated background**, choose a theme, Random, or Disabled. At a menu prompt, **Ctrl+F** freezes or resumes the animation. The built-in Windows console can also pause it while you scroll or select text.

<details>
<summary><strong>Console layout and animation details</strong></summary>

Menus choose a compact or full header based on the space available. Resizing recalculates the layout. Control menus keep their frames in column layouts, and the app selector supports animated backgrounds in both its search prompt and results picker.

The donut, rotating shapes, and galaxy keep their native viewport size. Placement favors the upper and lower parts of the screen and adjusts for the space occupied by menus. Fireworks and bouncing balls retain their distributed motion. **Flame Fire** loops a 900-frame AsciiForge sequence at 30 fps using VSO7's UI protection and edge fade. The original **Fire** theme remains available.

</details>

## Applying changes and using Recovery

Automatic mode builds an editable proposal. Only detected Appx packages marked safe and selected by default are suggested for automatic app removal. WinGet entries and special removal operations stay in manual mode. When a plan combines tweaks with app removal, the tweaks run first and must finish successfully before app removal begins.

> [!IMPORTANT]
> VSO7 changes Windows settings. Review the proposed changes before confirming and check the risk level of advanced options. Recovery records supported changes and requires a restore point for relevant operations. Some operations, including app removal and explicitly marked special changes, may require manual recovery.

<details>
<summary><strong>Recovery checks</strong></summary>

If a Game Mode change is already owned by native Recovery, VSO7 preserves the existing rollback record. Conflicting or ambiguous ownership blocks the operation.

Pending-restart checks identify the Windows signal that triggered them. An empty file-rename queue does not count as a pending restart.

</details>

## Documentation and support

| Resource | What it covers |
| :--- | :--- |
| [Technical user guide · English](VSO7_TECHNICAL_USER_GUIDE_EN.md) | Setup, tweak categories, automation, and Recovery |
| [Manual técnico · Español](VSO7_MANUAL_TECNICO_ES.md) | Instalación, opciones y referencia técnica |
| [Releases and changelogs](https://github.com/saturnus25/VSO/releases) | Changes, downloads, and checksums for each version |
| [GitHub Issues](https://github.com/saturnus25/VSO/issues) | Bugs and requests. For a bug, include the VSO7 version, Windows build, steps to reproduce, and any relevant error or log. |

## Source, credits, and license

[`VSO7.ps1`](VSO7.ps1) is the PowerShell source executed by the launcher. [`VSO7_7.0.0_RC_R80.ps1`](VSO7_7.0.0_RC_R80.ps1) is the compatibility copy used for the startup integrity check. Each release ZIP includes its corresponding source.

> [!NOTE]
> **AI-assisted development.** AI tools have helped with code, debugging, tests, and documentation. The project owner makes the final decisions and handles integration and maintenance. [OpenAI Codex](https://github.com/codex) assisted with this README refresh.

VSO7 uses the [MIT License](LICENSE). Third-party credits and licenses are listed in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [LICENSE.Win11Debloat.txt](LICENSE.Win11Debloat.txt).
