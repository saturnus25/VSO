# VSO7 1.2.1 — Technical User Guide and Functional Reference

**Supported interface:** console  
**Documented source:** `VSO7-current/VSO7.ps1`  
**Catalogs:** `VSO7_FEATURE_CATALOG.json`, `VSO7_NATIVE_TWEAKS.json`, and `VSO7_APP_CATALOG.json`  
**Date:** September 19, 2026

This guide explains how to use VSO7, how to reach each group of settings, what every workflow can change, and its risks, consequences, restart requirements, and recovery limits. It is also written so another AI can reconstruct VSO7's behavior in human language without inferring it only from function names.

The source and catalogs take precedence if a later version contradicts this guide. Menu numbers apply to VSO7 1.2.1.

## 1. Safe use

1. Extract the complete ZIP to a normal local folder.
2. Run `START VSO7.bat`. Do not open `VSO7.ps1` directly, from inside the ZIP, or from a network path.
3. Accept UAC only when you started the launcher yourself.
4. Opening a menu applies nothing. Mutation begins only after choosing Apply and passing confirmation.
5. `[X]` and `[A]` are pending selections. `[OK]` means already satisfied/applied; it is not an action that will run again.
6. Do not delete `C:\ProgramData\VicoreDevelopment\VSO7\Secrets`, `recovery-auth.key`, or Recovery to bypass an error. The key authenticates existing backups.
7. App removal and cleanup do not offer the same reversibility as a backed-up Registry value.
8. Restart or sign out when VSO says so. High-risk operations may be blocked by a real pending restart or ambiguous state.
9. More aggressive does not mean faster. Risk 3 and 4 actions are only appropriate for a specific need.

## 2. Startup, console host, and storage

The launcher verifies architecture and integrity, requests elevation once, and prefers Windows Terminal. If Terminal is unavailable, it opens the elevated host in the built-in classic console. In classic ConsoleHost, selecting text or scrolling its buffer may visually pause animation; this is host behavior, not a blocked tweak engine.

VSO stores `Logs` and `Reports` next to the application when the local directory is demonstrably safe and writable. Configuration, state, profiles, Recovery, managed PresentMon, and secrets live under `C:\ProgramData\VicoreDevelopment\VSO7`.

`Secrets\recovery-auth.key` is a random 32-byte key used to authenticate Recovery material. VSO fails closed and preserves state if an external identity can write there, or if backups depend on a missing key.

## 3. Reading a selector

| Mark | Exact meaning |
|---|---|
| `[ ]` | Available and not selected. |
| `[X]` | Manually selected, not yet applied. |
| `[A]` | Automatically selected, not yet applied. |
| `[OK]` | Already optimal/satisfied; excluded from pending changes. |
| `[ADMIN]` | Requires a valid administrator context. |
| `[N/A]` | Not applicable to this PC. |
| `[UNSUPPORTED]` | Unsupported build, edition, hardware, or provider. |
| `[?]` | State could not be proven; automation excludes it. |

Risk levels are **1 low**, **2 medium**, **3 high**, and **4 very high**. `Evidence` expresses technical support; automation accepts only E1/E2. `Maturity` is Stable, Conditional, Experimental, Diagnostic, or Deprecated. `AutoSelection=Eligible` allows consideration; `Manual` requires a person; `Never` prohibits automatic inclusion.

Automatic selection also requires a selectable mutation, no subjective preference, no security reduction, risk no higher than 2, matching objective, Stable/Conditional maturity, Recommended or explicitly requested Optional policy, and proven applicability.

## 4. Quick navigation

| Goal | Path from main menu |
|---|---|
| Global GPU, HAGS, windowed games | `13 → 13 → 1` |
| GPU/graphics preference per executable | `13 → 13 → 2` |
| GPU/HAGS/MPO/HDR/topology diagnostics | `13 → 13 → 3` |
| Quick GPU and driver view | `14 → 1 → 11` |
| Context-aware CPU and power | `13 → 12` |
| USB and power | `13 → 9` |
| CPU/P-E/SMT topology | `14 → 10 → 1` |
| Power plans | `14 → 1 → 6` |
| Network tweaks | `13 → 10` |
| NIC/Wi-Fi diagnostics | `14 → 10 → 7` |
| Gateway, jitter, local loss | `14 → 10 → 8` |
| Privacy, suggestions, AI | `13 → 1` |
| System, gaming, Windows Update | `13 → 2` |
| Start, Search, taskbar, multitasking | `13 → 3` and `13 → 6` |
| File Explorer and appearance | `13 → 4` and `13 → 6` |
| Detected safe apps | `13 → 7 → 1` |
| Manual 140-app catalog | `13 → 7 → 2` |
| Xbox/HP OEM/forced Edge removal | `13 → 8` |
| Startup applications | `14 → 5` or `14 → 1 → 7` |
| Guided cleanup | `14 → 7` or `14 → 1 → 16` |
| Extreme tweaks by risk | `10` |
| Tuning sanity scan | `17` or `14 → 8` |
| Combined automatic plan | `19` |
| Recovery | `12` |

## 5. Main menu

| No. | Option | On entry | Behavior and consequences |
|---:|---|---|---|
| 1 | VSO Score | Read-only | Summarizes state and score; may save local history. It is not an FPS benchmark. |
| 2 | A/B benchmark | No mutation on entry | Baseline/post for CPU, DPC, interrupts, context switches, disk, RAM, and processes; optional PresentMon. Writes reports. |
| 3 | Quick analysis | Read-only | Windows, CPU, RAM, GPU, disk, battery, power, Game Mode, capture, appearance, and startup. |
| 4 | Recommended optimization | None | Objective/applicability plan, preview, eligible optionals, explanations, apply, and restore latest session. |
| 5 | Safe optimization | None | Selector for Game Mode, background capture, and old temporary files; all three start checked. |
| 6 | Temporary Gaming Mode | None | Game to High, selected background processes to BelowNormal, optional High performance; restores when game closes. |
| 7 | Permanent gaming | None | Game Mode, capture, reversible power plan, and cleanup. Persistent changes/cleanup only on Apply. |
| 8 | Balanced | None | Fixed low/medium preset; shows all and requires `EQUILIBRADO`. It can be partial if a later step fails. |
| 9 | Controlled aggressive | None | Adds transparency/animation changes and requires `AGRESIVO`. Does not touch Defender, Firewall, VBS, BCD/HPET, pagefile, HAGS, existing BitLocker, or Update. |
| 10 | Extreme | None | 31 risk-grouped tweaks, details, Dry Run, Apply, and restore. Includes irreversible and security changes. |
| 11 | Restore point | Prompts first | Checks/creates a checkpoint only after confirmation. |
| 12 | Revert/Recovery | Until chosen | Restores recorded changes while respecting ownership and external drift. |
| 13 | Windows/Debloat | None | Native catalog for privacy, Windows, CPU, network, GPU, apps, and special operations. |
| 14 | Tools | None | Hardware, TRIM, storage, startup, overlays, cleanup, profiles, and laboratory. |
| 15 | Open folder | Opens Explorer | No system-setting mutation. |
| 16 | Language/appearance | VSO config only | Saves language and animation; Random is the new default, saved preference wins. |
| 17 | Sanity scan | Read-only | BCD, MMCSS, network, memory, scheduler, interrupts, USB, and power; no auto-fix. |
| 18 | Explained diagnostics | Read-only | Context and recommendations. OK rows are not pending changes. |
| 19 | Automatic tweaks+apps | None | Editable plan; tweaks first. Failed/partial tweak phase prevents app removal. |
| 0 | Exit | None | Closes with no additional changes. |

## 6. Automation and objectives

Objectives are Balanced, Performance, Gaming, Responsiveness, and PowerEfficiency. Privacy exists as a metadata domain but remains manual. No objective inherits another, and Balanced is not a universal fallback.

The engine sorts by FeatureId; excludes diagnostics, experimental items, preferences, security-reducing actions, and Manual/Never policy; requires an exact objective and applicability match; separates AlreadyOptimal; resolves conflicts and dependencies; and preserves reviewed IDs between confirmation and execution.

“No automatic recommendations pending” can mean everything eligible is already `[OK]`, the objective does not match, the entries are preferences/manual, or the hardware/state does not apply. It does not mean the catalog is empty.

Option 4 handles features only. Option 19 combines features and detected apps. Selecting, recalculating, and Dry Run do not apply anything.

## 7. Option 13 — Windows/Debloat

| Submenu | Content | Main consequence |
|---:|---|---|
| 1 | Privacy, suggestions, AI | Telemetry, ads, location, Copilot, Recall, Click to Do, app AI; privacy is manual. |
| 2 | System, gaming, Update | Capture, Fast Startup, Storage Sense, Update policies; can alter maintenance/convenience. |
| 3 | Start, taskbar, multitasking | Mostly workflow/visual preferences, not objective performance. |
| 4 | Explorer and appearance | Extensions, hidden items, start page, pane, transparency, animations. |
| 5 | Optional features and other | Sandbox, WSL, third-party settings; may need reboot/virtualization. |
| 6 | Nine exclusive selectors | Prevents incompatible variants being applied together. |
| 7 | Apps | Detected automatic mode or 140-entry manual catalog; reinstall not guaranteed. |
| 8 | Special/OEM | Xbox/Game Bar, HP OEM, forced Edge removal; high/very high risk. |
| 9 | Power & USB | Reviewed USB selective suspend. |
| 10 | Network | RSS/RSC/offloads/autotuning/NIC power; some restart the adapter. |
| 11 | Diagnostics/remediation | Reviewed remediation for a specific MMCSS override. |
| 12 | CPU & Power | Boost, EPP, CPU maximum, cooling, throttling, ASPM by hardware/AC/DC. |
| 13 | Graphics & GPU | Global, per-app, and diagnostics. |

In a category selector, `R` replaces checks with recommendations for that section; `O` changes the next calculation's objective while preserving checks; `X` clears. Apply rechecks applicability, shows exact IDs, confirms high risk, and requires Recovery.

### Exclusive choices (`13 → 6`)

1. Spotlight: on, on without info icon, or off.
2. Alt+Tab: 0, 3, 5, or 20 tabs.
3. Taskbar Search: hidden, icon, icon+label, or box.
4. Main taskbar grouping: always, when full, or never.
5. Secondary taskbar grouping: always, when full, or never.
6. Multi-monitor: all, main+active monitor, or its monitor only.
7. Explorer: Home, This PC, Downloads, or OneDrive.
8. Drive letters: before, after, network first, or hidden.
9. All apps: category, grid, or list when supported.

### Apps (`13 → 7`)

`13 → 7 → 1` inventories all-users installed and provisioned Appx once. It proposes only detected entries with `safe`, `SelectedByDefault=true`, and Appx method. WinGet and special removers remain manual.

`13 → 7 → 2` shows 140 entries, 12 per page. `B` performs fuzzy search, free text also searches, and `P3` jumps to page 3. “Select recommended removals” checks the **84** safe/default catalog entries **without first filtering installed state**. Before removal it shows everything, warns about unsafe entries, requires `ELIMINAR APPS`, and requires a restore point. Recovery does not guarantee reinstall.

## 8. GPU

`13 → 13 → 1` exposes global windowed optimizations and HAGS only when build/support permits consideration. HAGS may require reboot. VSO separates configured from effective state and does not promise FPS from a Registry value.

`13 → 13 → 2` selects an EXE: Let Windows decide removes `GpuPreference`; power saving uses 1; high performance uses 2; windowed ON uses `SwapEffectUpgradeEnable=1`; OFF is blocked by an incompatible Auto HDR token; reset removes only its target token. Other tokens are preserved. Configuration verifies immediately; effective state is `PendingAppRestart`.

`13 → 13 → 3` reads PnP/PCI, DXCore, DXGI, hybrid topology, tearing, HAGS, DisplayConfig, refresh rate, DRR, HDR/WCG, and MPO. PnP/PCI/path/EDID are persistent identity; LUID/source/target are session identity. HDR/WCG/VRR/Auto HDR/Auto SR/MPO remain diagnostic; VSO does not apply Disable MPO.

## 9. CPU, power, USB, and network

`13 → 12` avoids universal 100% minimum-CPU presets. It distinguishes desktop/laptop and AC/battery for CPU maximum, Power Throttling, EPP, boost, cooling, and PCIe. Performance can increase power, heat, and noise; efficiency can reduce response/boost.

`13 → 9` restores USB selective suspend when appropriate. Disabling it should only be tested for a problematic peripheral and exists as risk-3 Extreme.

`14 → 1 → 6` manages plans without replacing OEM/custom plans. High performance requires saving and restoring the original GUID.

`13 → 10` uses physical adapters and driver-advertised capabilities. Restoring RSS/offloads/autotuning repairs indiscriminate tweak packs. Disabling RSC/interrupt moderation is a manual latency test and can increase CPU or reduce throughput. NIC restart causes a short disconnect. Wake-on-LAN is a preference. `14 → 10 → 7/8` diagnoses NIC/Wi-Fi and local network, without confusing LAN with ISP quality.

## 10. Gaming

Game Mode appears in several flows. If already applied under compatible Recovery, VSO treats it as AlreadyApplied and preserves the original rollback. Different/ambiguous ownership blocks mutation.

Disabling capture limits Game DVR/AppCapture, but not necessarily external capture tools.

Temporary mode does not launch games from an elevated process. The user opens the game; VSO revalidates PID, path, start time, and priority; sets game to High, selected backgrounds to BelowNormal, and optionally High performance. On exit it restores only what it still owns. Incomplete restoration leaves state for retry.

Permanent mode applies Game Mode, capture, reversible power, and cleanup without monitoring game exit.

## 11. Tools and laboratory

`14`: (1) specific tools; (2) read-only hardware/TRIM/drivers; (3) storage; (4) history; (5) startup with rollback; (6) close overlays without changing startup; (7) guided cleanup; (8) Sanity; (9) JSON profiles; (10) laboratory.

`14 → 1`: Game Mode; capture; transparency; animations; temporary files >7 days; power plans; startup; per-process CPU/RAM; Windows health; RAM; GPU/driver; Windows graphics page; storage; Extreme; overlays; guided cleanup.

`14 → 10`: CPU topology; DPC/ISR; MSI/MSI-X and affinity; USB; disk health; drivers; NIC/Wi-Fi; local network quality; audio/input; firmware/dependencies; QoS/DSCP. All are diagnostic. DPC/ISR without ETW cannot attribute a driver, and DSCP cannot lower ping when the network ignores it.

## 12. Benchmark

Option 2: (1) 10-second baseline; (2) post and HTML; (3) isolated measurement; (4) latest comparison; (5) 60-second FPS baseline; (6) FPS post and lows; (7) PresentMon manager. PresentMon downloads only after explicit action and verification. A/B conditions must match; lower background CPU alone does not prove more FPS or lower input lag.

## 13. Recovery and pending restart

Before a reversible mutation VSO records baseline and intent, writes, and reads back. Restore verifies current state still matches what VSO applied; drift prevents overwriting external changes. A batch may stop on its first error after earlier steps applied: inspect Applied, Failed, RollbackStatus, bundle, and log.

Pending-restart detection recognizes CBS, Windows Update, nonzero UpdateExeVolatile, computer rename, and populated file rename operations. Empty PendingFileRenameOperations is ignored. Unreadable/ambiguous evidence blocks high-risk operations.

## 14. Extreme

The 31 items are toggles. Following controls select risk 1, up to 2, up to 3, or all; clear; show details; simulate; apply; or revert. A risk shortcut is not a recommendation.

| No. | ID | Tweak | Risk | Restart | Recovery | Effect/consequence |
|---:|---|---|---|---|---|---|
| 1 | `gaming.gamemode` | Enable Game Mode | 1 · Low | No | Reversible | Enables Windows Game Mode. |
| 2 | `gaming.gamedvr` | Disable Game DVR/background capture | 1 · Low | No | Reversible | Reduces background capture; Windows recording features are lost. |
| 3 | `ui.transparency` | Disable transparency | 1 · Low | No | Reversible | Reduces visual interface effects. |
| 4 | `ui.animations` | Reduce animations/visual effects | 1 · Low | Yes | Reversible | Uses the best-performance visual preset and disables window animation; changes appearance. |
| 5 | `delivery.p2p` | Delivery Optimization without P2P | 1 · Low | No | Reversible | DownloadMode=0: HTTP without peer sharing; Windows Update still works. |
| 6 | `cleanup.temp` | Clean temporary files older than 7 days | 1 · Low | No | Not reversible | Deletes old temporary files while skipping locked files. |
| 7 | `cleanup.shaders` | Clean NVIDIA/DirectX shader caches | 1 · Low | No | Not reversible | Caches regenerate and may cause initial microstutter. |
| 8 | `cleanup.dev` | Clean npm/pip caches | 1 · Low | No | Not reversible | Only downloadable development caches. |
| 9 | `cleanup.vscode` | Clean VS Code/Insiders caches | 1 · Low | No | Not reversible | Removes Cache, GPUCache, CachedData and VSIX cache; does not touch User. |
| 10 | `cleanup.spotify` | Clear Spotify Store LocalCache | 1 · Low | No | Not reversible | Does not delete LocalState. |
| 11 | `cleanup.lghub` | Clear Logitech G HUB cache | 1 · Low | No | Not reversible | Does not touch depots/current.json/next.json. |
| 12 | `cleanup.winsxs` | DISM StartComponentCleanup (without ResetBase) | 1 · Low | No | Not reversible | Microsoft-supported cleanup for superseded components. |
| 13 | `power.hibernate` | Disable hibernation | 2 · Medium | No | Reversible | Frees hiberfil.sys; disables hibernation and associated Fast Startup. |
| 14 | `search.indexing` | Disable Windows Search/indexing | 2 · Medium | No | Reversible | Reduces indexing I/O; searches may become slower. |
| 15 | `xbox.services` | Disable classic Xbox services | 2 · Medium | No | Reversible | May affect Xbox app, Game Pass and Xbox features. |
| 16 | `telemetry.diagtrack` | Disable Connected User Experiences/DiagTrack | 2 · Medium | No | Reversible | Reduces background telemetry/diagnostics; may limit diagnostic data. |
| 17 | `power.usbSuspend` | Disable USB selective suspend (experimental) | 3 · High | No | Reversible | May help problematic peripherals, but Microsoft recommends keeping it for general use; power use rises. |
| 18 | `power.pcieAspm` | PCIe Link State Power Management OFF (experimental) | 3 · High | No | Reversible | Reduces PCIe power saving; performance benefit is unproven and power use rises. |
| 19 | `cleanup.fortnite` | Delete Fortnite PersistentDownloadDir | 2 · Medium | No | Not reversible | Fortnite downloads required content again. |
| 20 | `cleanup.bobby` | Delete .minecraft/.bobby cache | 2 · Medium | No | Not reversible | Does not touch logs, crash reports, saves, Xaero or JourneyMap. |
| 21 | `cleanup.dumps` | Clean old crash dumps | 2 · Medium | No | Not reversible | Deletes old .dmp files and their diagnostic evidence. |
| 22 | `services.spooler` | Disable Print Spooler | 3 · High | No | Reversible | Printing stops while disabled. |
| 23 | `services.location` | Disable Location Service | 3 · High | No | Reversible | Apps using location may stop working correctly. |
| 24 | `services.bluetooth` | Disable Bluetooth service | 3 · High | No | Reversible | Bluetooth peripherals stop working while disabled. |
| 25 | `virtualization.hyperv` | Disable Hyper-V hypervisor | 3 · High | Yes | Reversible | May break Hyper-V, Docker, emulators and dependent virtualization. |
| 26 | `virtualization.wsl` | Disable WSL + Virtual Machine Platform | 3 · High | Yes | Reversible | Breaks WSL2 and usually Docker Desktop with the WSL backend. |
| 27 | `virtualization.sandbox` | Disable Windows Sandbox | 3 · High | Yes | Reversible | Removes the Windows Sandbox feature. |
| 28 | `security.memoryIntegrity` | Disable Memory Integrity / HVCI | 4 · Very high | Yes | Reversible | REDUCES KERNEL SECURITY. Manual and informed selection only. |
| 29 | `security.credentialGuard` | Disable Credential Guard (without UEFI lock) | 4 · Very high | Yes | Reversible | REDUCES CREDENTIAL PROTECTION. VSO refuses when a UEFI lock exists. |
| 30 | `security.vbs` | Disable base VBS | 4 · Very high | Yes | Reversible | REDUCES VIRTUALIZATION-BASED ISOLATION. |
| 31 | `virtualization.hypervisorLaunchOff` | BCD hypervisorlaunchtype OFF | 4 · Very high | Yes | Reversible | Prevents the Windows hypervisor from starting; breaks dependent VBS/Hyper-V/WSL2. |

The four risk-4 items reduce isolation/security or prevent the hypervisor. Hyper-V/WSL/Sandbox affect Docker, emulators, and WSL2. Spooler, location, and Bluetooth directly break those functions while disabled.

## 15. Complete feature catalog

The appendices below are generated statically from this build's JSON. `Selectable=true` does not guarantee a dedicated manual screen. Some Storage features are reached through recommendation, profiles, or specialized flows.

**VSO7.ps1 SHA-256:** `D88F46386C73A5694DFA457DB0744987FE3C64CC4F1236223A03CAF042A116FA`

| Category | Path | Total | Selectable | Mutations | Eligible | Manual | Never |
|---|---|---:|---:|---:|---:|---:|---:|
| AI | 13 → 1 | 7 | 7 | 7 | 0 | 7 | 0 |
| Appearance | 13 → 4 | 6 | 3 | 0 | 0 | 0 | 6 |
| Audio | 14 → 10 → 9 | 1 | 0 | 0 | 0 | 0 | 1 |
| Benchmark & Diagnostics | 2; 14 → 10 | 2 | 0 | 0 | 0 | 0 | 2 |
| CPU & Power | 13 → 12 | 12 | 12 | 12 | 6 | 6 | 0 |
| Diagnostics | 13 → 11 | 2 | 1 | 1 | 0 | 1 | 1 |
| Drivers | 14 → 2 or 14 → 10 → 6 | 1 | 0 | 0 | 0 | 0 | 1 |
| File Explorer | 13 → 4 | 20 | 12 | 0 | 0 | 0 | 20 |
| Firmware | 14 → 10 → 10 | 1 | 0 | 0 | 0 | 0 | 1 |
| Gaming | 13 → 2 | 8 | 7 | 7 | 1 | 5 | 2 |
| Graphics & GPU | 13 → 13 → 1 | 7 | 4 | 4 | 0 | 2 | 5 |
| Input | 14 → 10 → 9 | 1 | 0 | 0 | 0 | 0 | 1 |
| Latency & Interrupts | 14 → 10 → 2/3; 17 | 5 | 0 | 0 | 0 | 0 | 5 |
| Multi-tasking | 13 → 3 | 7 | 3 | 0 | 0 | 0 | 7 |
| Network | 13 → 10 | 26 | 23 | 23 | 6 | 11 | 9 |
| Optional Windows Features | 13 → 5 | 2 | 2 | 2 | 0 | 2 | 0 |
| Other | 13 → 5 | 2 | 2 | 2 | 0 | 2 | 0 |
| Power & USB | 13 → 9 | 1 | 1 | 1 | 1 | 0 | 0 |
| Privacy & Suggested Content | 13 → 1 | 8 | 8 | 8 | 0 | 8 | 0 |
| Services | 14 → 10 → 10; mutations in 10 | 1 | 0 | 0 | 0 | 0 | 1 |
| Special | 13 → 8 | 8 | 3 | 3 | 0 | 3 | 5 |
| Start Menu & Search | 13 → 3 | 12 | 6 | 0 | 0 | 0 | 12 |
| Storage | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | 9 | 8 | 8 | 2 | 6 | 1 |
| System | 13 → 2 | 8 | 8 | 8 | 0 | 7 | 1 |
| Taskbar | 13 → 3 | 19 | 6 | 0 | 0 | 0 | 19 |
| USB & HID | 14 → 10 → 4; 17 | 2 | 0 | 0 | 0 | 0 | 2 |
| Wi-Fi | 14 → 10 → 7 | 1 | 0 | 0 | 0 | 0 | 1 |
| Windows Update | 13 → 2 | 4 | 4 | 4 | 0 | 4 | 0 |

### Detailed reference for all 183 features

#### AI (7)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7AI001` | Disable Copilot / Desactivar Microsoft Copilot | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables Copilot integration in Windows. It does not uninstall third-party applications. | No declared condition | None declared | Registry; declarative rollback (3 operation(s)) |
| `V7AI002` | Disable Recall / Desactivar Windows Recall | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables Recall so Windows does not use that AI-assisted history/snapshot feature. | No declared condition | None declared | Registry; declarative rollback (5 operation(s)) |
| `V7AI003` | Disable Click To Do / Desactivar Click to Do | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables Click to Do contextual analysis of text and images. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7AI004` | Disable AI Service Auto Start / Evitar inicio automatico del servicio de IA | 13 → 1 | Mutation | 2 · Medium | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Prevents the AI service configured by Windows from starting automatically; some AI features may stop working. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7AI005` | Disable Edge AI / Desactivar funciones de IA de Edge | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables several AI features integrated into Microsoft Edge. | No declared condition | None declared | Registry; declarative rollback (8 operation(s)) |
| `V7AI006` | Disable Paint AI / Desactivar funciones de IA de Paint | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables Paint AI features when Windows exposes them through these policies. | No declared condition | None declared | Registry; declarative rollback (5 operation(s)) |
| `V7AI007` | Disable Notepad AI / Desactivar funciones de IA del Bloc de notas | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables Notepad AI features when they are available. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### Appearance (6)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7UI001` | Enable Desktop Spotlight / Activar Windows Spotlight en el escritorio | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Enables rotating Spotlight wallpapers and the related information shortcut on the desktop. | No declared condition | None declared | Registry; diagnostic only |
| `V7UI002` | Disable Desktop Spotlight / Desactivar Windows Spotlight del escritorio | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Prevents Windows from automatically changing the desktop background through Spotlight. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7UI003` | Hide Desktop Spotlight Icon / Ocultar el icono de Spotlight | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Keeps Spotlight enabled but hides the “Learn more about this picture” desktop shortcut. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7UI004` | Enable Dark Mode / Activar modo oscuro | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Enables the dark theme for Windows and compatible applications. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7UI005` | Disable Transparency / Desactivar transparencias | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reduces Windows transparency effects. This is a reversible visual change. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7UI006` | Disable Animations / Reducir animaciones y efectos visuales | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Disables several animations so the interface feels more immediate. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### Audio (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7AU001` | Audio device/driver latency context / Contexto de latencia de audio | 14 → 10 → 9 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Inventories audio devices and signed drivers and shows DPC/ISR totals only as system context; driver attribution requires an ETW trace. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: audio PnP, driver version, signature, DPC/ISR context | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Benchmark & Diagnostics (2)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7BM001` | Extended PresentMon frame metrics / Metricas de frame PresentMon ampliadas | 2; 14 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Adds P95 frametime alongside average FPS, 1%/0.1% lows, P99 and P99.9 using the existing verified PresentMon workflow. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: P95 frametime, P99 frametime, 1% low, 0.1% low | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7BM002` | Noise-gated A/B verdict / Veredicto A/B con margen de ruido | 2; 14 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E2 · Auto=Never | Diagnostics | None | Classifies a PresentMon A/B comparison as Improved, Regressed or Inconclusive only when multiple frame metrics cross conservative gates. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: AvgFPS gate, 1% low gate, P99 frame-time gate | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### CPU & Power (12)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableActiveCoolingOnAcLaptop` | Prefer active cooling on AC laptop / Priorizar refrigeracion activa en AC/laptop | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E2 · Auto=Eligible | Performance, Gaming | None | Sets System Cooling Policy=Active only on laptop AC when the setting exists, preserving DC. Can increase fan noise to manage thermals before reducing performance. Interactions: Not every OEM exposes or honors this setting; if absent, VSO7 marks it Not Applicable. Measurement: fan behavior, CPU temperature, sustained clocks | Administrator=yes; Device type=Laptop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"SYSCOOLPOL","RequireACDifferentFrom":1} | None declared | PowerSetting; no declarative Undo; inspect engine |
| `EnableProcessorBoostModeOnAcDesktop` | Enable CPU boost on AC when it was disabled / Habilitar boost de CPU en AC si estaba desactivado | 13 → 12 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | On a desktop PC, changes PERFBOOSTMODE from Disabled to Enabled only for AC on the active plan. DC is preserved and Aggressive is not used. Interactions: Can increase power, temperature, and noise. It appears only when the setting exists and AC is explicitly Disabled. Measurement: CPU frequency/boost residency under the target workload, temperature and package power, frametime/FPS A/B | Administrator=yes; Commands=["powercfg.exe"]; Device type=["Desktop"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFBOOSTMODE","RequireACEquals":0} | None declared | PowerSetting; no declarative Undo; inspect engine |
| `RestoreMaxProcessorStateOnAcDesktop` | Restore 100% CPU maximum on AC desktop / Restaurar maximo CPU al 100 % en AC/desktop | 13 → 12 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, Gaming, Responsiveness | None | Restores PROCTHROTTLEMAX to 100% only on AC and only on desktops when a plan caps it below 100. DC is preserved exactly. Interactions: Can raise thermals/power versus an intentional cap. Does not change minimum CPU or force aggressive boost. Measurement: sustained clocks, CPU package power, temperature | Administrator=yes; Device type=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PROCTHROTTLEMAX","RequireACBelow":100} | None declared | PowerSetting; no declarative Undo; inspect engine |
| `RestorePowerThrottlingToUserControl` | Restore normal Power Throttling control / Restaurar Power Throttling a control normal | 13 → 12 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, PowerEfficiency | None | Removes PowerThrottlingOff=1 when a policy/tweak disabled Power Throttling globally. Returns normal control to Windows/the user; it does not promise more FPS. Interactions: Documented ADMX policy. It may reduce background-process power use. Measurement: background CPU/power use | Administrator=yes; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling","Name":"PowerThrottlingOff","NumericMin":1,"NumericMax":1} | None declared | Registry; no declarative Undo; inspect engine |
| `SetProcessorEppBalancedOnAcDesktop` | Balanced EPP on AC desktop / EPP equilibrado en AC/desktop | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Sets PERFEPP=50 on AC desktops as an explicit balanced point. This is a trade-off preference, not a universal FPS boost. Interactions: Preserves DC. Measurement: CPU package power, responsiveness | Administrator=yes; Device type=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":50} | Exclusive group: ProcessorEppAc | PowerSetting; no declarative Undo; inspect engine |
| `SetProcessorEppEfficiencyOnBatteryLaptop` | Efficiency-oriented EPP on laptop battery / EPP eficiente en bateria/laptop | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Sets PERFEPP=80 only on laptop DC when the setting exists, preserving AC. Favors battery life/thermals over peak performance. Interactions: Not applicable to desktops. Measurement: battery drain, temperature, responsiveness | Administrator=yes; Device type=Laptop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireDCDifferentFrom":80} | Exclusive group: ProcessorEppDc | PowerSetting; no declarative Undo; inspect engine |
| `SetProcessorEppPerformanceOnAcDesktop` | Performance-oriented EPP on AC desktop / EPP orientado a rendimiento en AC/desktop | 13 → 12 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Sets PERFEPP=0 only on AC desktops when the setting exists. Favors performance over energy savings; not auto-recommended and should be measured for thermals/power. Interactions: EPP is primarily effective with CPPC v2 autonomous mode. Hardware/firmware can modulate the outcome. Measurement: frametime A/B, CPU package power, temperature, boost residency | Administrator=yes; Device type=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":0} | Exclusive group: ProcessorEppAc | PowerSetting; no declarative Undo; inspect engine |
| `V7PW101` | Balanced EPP on AC laptop / EPP equilibrado en AC para portatil | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Sets EPP=50 on AC only for a laptop. Windows documents 0 as performance and 100 as power saving; 50 is a balance, not a gaming promise. Measurement: CPU package power, temperature, frametimes | Administrator=yes; Device type=["Laptop"]; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":50} | Exclusive group: V7LaptopAcEpp | PowerSetting; no declarative Undo; inspect engine |
| `V7PW102` | Performance-oriented EPP on AC laptop / EPP rendimiento en AC para portatil | 13 → 12 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Sets EPP=20 on AC only to favor performance without forcing 0. It can increase power, temperature and fan noise; measure before/after. Measurement: CPU package power, temperature, frametimes | Administrator=yes; Device type=["Laptop"]; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":20} | Exclusive group: V7LaptopAcEpp | PowerSetting; no declarative Undo; inspect engine |
| `V7PW103` | Disable CPU boost on battery / Desactivar boost de CPU en bateria | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Disables Processor Performance Boost Mode on DC only to reduce laptop power/temperature. AC is preserved exactly. Measurement: battery discharge rate, temperature, battery workload latency | Administrator=yes; Device type=["Laptop"]; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFBOOSTMODE","RequireDCDifferentFrom":0} | Exclusive group: V7LaptopDcBoost | PowerSetting; no declarative Undo; inspect engine |
| `V7PW104` | Moderate PCIe ASPM on battery / PCIe ASPM moderado en bateria | 13 → 12 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Sets ASPM=1 on DC only for a laptop. This is a power/latency trade-off and does not change AC. Measurement: battery discharge rate, device latency/stability | Administrator=yes; Device type=["Laptop"]; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PCIEXPRESS","SettingAlias":"ASPM","RequireDCDifferentFrom":1} | Exclusive group: V7LaptopDcAspm | PowerSetting; no declarative Undo; inspect engine |
| `V7PW105` | Maximum PCIe ASPM on battery / PCIe ASPM maximo en bateria | 13 → 12 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Sets ASPM=2 on DC only for maximum PCIe link power savings. It can increase exit latency from low-power states; test per hardware. Measurement: battery discharge rate, device latency/stability | Administrator=yes; Device type=["Laptop"]; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PCIEXPRESS","SettingAlias":"ASPM","RequireDCDifferentFrom":2} | Exclusive group: V7LaptopDcAspm | PowerSetting; no declarative Undo; inspect engine |

#### Diagnostics (2)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `NormalizeClampedSystemResponsivenessOverride` | Normalize clamped MMCSS override below 10 to 20 / Normalizar override MMCSS <10 a 20 | 13 → 11 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Diagnostics | None | When SystemResponsiveness exists with a value from 0 through 9, explicitly normalizes it to 20. Windows documents that 0-9 is already clamped to 20, so this remediation aligns configured and effective state without promising more performance. Rollback restores the exact previous DWORD. Interactions: This is not a performance tweak: the documented effective value is 20 both before and after. Measurement: compare configured value with documented effective MMCSS value before and after | Administrator=yes; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile","Name":"SystemResponsiveness","NumericMin":0,"NumericMax":9} | Exclusive group: SystemResponsivenessOverride | Registry; no declarative Undo; inspect engine |
| `V7DI201` | Multi-target Partial state model / Modelo Partial para multiples targets | 13 → 11 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Aggregates per-target states without confusing a Baseline/Applied mixture with Drift. Explicit Error, Ambiguous and Drift states retain precedence. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: Baseline, Applied, Partial, Drift, PendingRestart | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Drivers (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7DR001` | Driver advisor inventory / Inventario asesor de controladores | 14 → 2 or 14 → 10 → 6 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Inventories signed GPU, network, audio, storage, USB and system drivers with version/date/provider; it does not claim a newer driver exists. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: driver version, driver date, provider, signature | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### File Explorer (20)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7FE001` | Explorer To Home / Abrir Explorador en Inicio | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes new File Explorer windows open the Home page. | No declared condition | None declared | Registry; diagnostic only |
| `V7FE002` | Explorer To This PC / Abrir Explorador en Este equipo | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes new File Explorer windows show drives and folders from This PC. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE003` | Explorer To Downloads / Abrir Explorador en Descargas | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes File Explorer open the Downloads folder directly. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE004` | Explorer To One Drive / Abrir Explorador en OneDrive | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes File Explorer open OneDrive by default; OneDrive must be configured. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE005` | Show Known File Extensions / Mostrar extensiones de archivo | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows .exe, .txt, .jpg, and other known file extensions to make files easier to identify. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE006` | Show Hidden Folders / Mostrar archivos y carpetas ocultos | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes items marked as hidden visible in File Explorer. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE007` | Hide Dupli Drive / Ocultar unidades extraibles duplicadas | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Prevents some USB drives from appearing twice in the File Explorer navigation pane. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE008` | Hide Home / Ocultar Inicio del Explorador | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes Home from the File Explorer navigation pane. | No declared condition | None declared | Registry; declarative rollback (11 operation(s)) |
| `V7FE009` | Hide Gallery / Ocultar Galeria del Explorador | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes Gallery from the File Explorer navigation pane. | No declared condition | None declared | Registry; declarative rollback (10 operation(s)) |
| `V7FE010` | Hide OneDrive / Ocultar OneDrive del Explorador | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides OneDrive from the File Explorer navigation pane; it does not uninstall the client or delete files. | No declared condition | None declared | Registry; declarative rollback (10 operation(s)) |
| `V7FE011` | Hide3d Objects / Ocultar carpeta Objetos 3D | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes the 3D Objects folder from This PC. | No declared condition | None declared | Registry; no declarative Undo; inspect engine |
| `V7FE012` | Hide Music / Ocultar carpeta Musica | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes Music from This PC/the navigation pane, depending on the Windows version. | No declared condition | Exclusive group: V7ExplorerMusicNamespace | Registry; no declarative Undo; inspect engine |
| `V7FE013` | Add Folders To This PC / Añadir carpetas comunes a Este equipo | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows common folders such as Documents and Downloads in This PC again. | No declared condition | Exclusive group: V7ExplorerMusicNamespace | Registry; declarative rollback (13 operation(s)) |
| `V7FE014` | Hide Include In Library / Ocultar Incluir en biblioteca | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes the “Include in library” entry from the File Explorer context menu. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7FE015` | Hide Give Access To / Ocultar Dar acceso a | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes the “Give access to” sharing entry from the File Explorer context menu. | No declared condition | None declared | Registry; declarative rollback (8 operation(s)) |
| `V7FE016` | Hide Share / Ocultar Compartir | 13 → 4 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes the Share entry from the modern context menu. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE017` | Show Drive Letters First / Mostrar letra de unidad antes del nombre | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | In File Explorer, shows C:, D:, and other drive letters before the drive label. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE018` | Show Drive Letters Last / Mostrar letra de unidad despues del nombre | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Keeps the drive letter visible, but shows it after the drive label. | No declared condition | None declared | Registry; diagnostic only |
| `V7FE019` | Show Network Drive Letters First / Mostrar primero letras de unidades de red | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows the drive letter before the name for network drives. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7FE020` | Hide Drive Letters / Ocultar letras de unidad | 13 → 4 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides C:, D:, and other drive letters in the File Explorer interface; the drives and paths still exist. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### Firmware (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7FW001` | BIOS/UEFI inventory / Inventario BIOS/UEFI | 14 → 10 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Reports firmware/system identity and Secure Boot state when queryable. Firmware mutation remains outside R9. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: BIOS version, release date, Secure Boot | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Gaming (8)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisableBackgroundGameCapturePerUser` | Disable per-user background game capture / Desactivar capturas de juego por usuario | 13 → 2 | Mutation | 1 · Low | Optional · Conditional · E2 · Auto=Manual | Gaming | AppRestart | Disables AppCapture/GameDVR for the current user without creating a device policy or modifying ms-gamebar protocols. It is a reversible preference, not an FPS promise. Interactions: Does not uninstall Game Bar. Some apps/games must restart to observe the change. Measurement: capture/background recording behavior | RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\System\\GameConfigStore","Name":"GameDVR_Enabled","Value":0,"Kind":"DWord"},{"Path":"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\GameDVR","Name":"AppCaptureEnabled","Value":0,"Kind":"DWord"}] | None declared | Registry; no declarative Undo; inspect engine |
| `RestoreGameRecordingPolicyToUserControl` | Restore game recording policy to user control / Restaurar control de grabacion al usuario | 13 → 2 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Gaming, Performance | AppRestart | Removes an AllowGameDVR=0 policy override to return control to Windows/the user. It does not enable capture by itself and rollback restores the exact prior value. Interactions: The policy is documented by Microsoft. Only applies when the DWORD exists and equals 0. Measurement: Game Bar recording availability after app restart | Administrator=yes; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\GameDVR","Name":"AllowGameDVR","NumericMin":0,"NumericMax":0} | Conflicts: V7GM001 | Registry; no declarative Undo; inspect engine |
| `V7GM001` | Disable game capture/recording (legacy) / Desactivar captura/grabacion de juegos (legacy) | 13 → 2 | Mutation | 1 · Low | Advanced · Conditional · E1 · Auto=Manual | Gaming, Performance | AppRestart | Disables game capture/recording. VSO7 retains this advanced variant for functional compatibility, but recommends the per-user variant because this one also writes a machine policy. Interactions: AllowGameDVR policy can prevent the user from re-enabling capture in Settings. Prefer DisableBackgroundGameCapturePerUser unless a policy is intended. Measurement: Game Bar capture availability before/after | Administrator=yes | Conflicts: RestoreGameRecordingPolicyToUserControl | Registry; declarative rollback (3 operation(s)) |
| `V7GM002` | Disable Game Bar Integration / Desactivar integracion de Barra de juegos | 13 → 2 | Diagnostic | 2 · Medium | NotRecommended · Deprecated · E5 · Auto=Never | Gaming, Performance | None | Legacy VSO7 compatibility path that redirects ms-gamebar protocols through HKCR. It is not offered for new applications because it is too invasive and unnecessary for disabling captures. Interactions: Retained only to recognize/restore VSO7 prerelease states; no longer offered as a new tweak. | No declared condition | None declared | Registry; declarative rollback (9 operation(s)) |
| `V7GM101` | Enable Game Mode / Activar Game Mode | 13 → 2 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Gaming | AppRestart | Enables the official Game Mode preference. It does not promise higher FPS; Windows decides effective behavior based on the game, hardware and scheduler. Measurement: A/B game frametimes, 1% lows, background CPU activity | Minimum build=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"AutoGameModeEnabled","Value":1,"Kind":"DWord"}] | Exclusive group: V7GameMode | Registry; no declarative Undo; inspect engine |
| `V7GM102` | Disable Game Mode for A/B testing / Desactivar Game Mode para prueba A/B | 13 → 2 | Mutation | 1 · Low | Experimental · Experimental · E1 · Auto=Never | Gaming, Performance | AppRestart | Disables Game Mode reversibly for a specific A/B comparison. It is not a universal recommendation. Measurement: A/B game frametimes, 1% lows, background CPU activity | Minimum build=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"AutoGameModeEnabled","Value":0,"Kind":"DWord"}] | Exclusive group: V7GameMode | Registry; no declarative Undo; inspect engine |
| `V7GM103` | Allow controller to open Game Bar / Permitir abrir Game Bar con mando | 13 → 2 | Mutation | 1 · Low | Optional · Stable · E1 · Auto=Manual | Preferences | None | Enables the official preference that lets a controller button open Game Bar. This is a UX preference, not a performance tweak. | Minimum build=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"UseNexusForGameBarEnabled","Value":1,"Kind":"DWord"}] | Exclusive group: V7ControllerGameBar | Registry; no declarative Undo; inspect engine |
| `V7GM104` | Block controller from opening Game Bar / Bloquear apertura de Game Bar con mando | 13 → 2 | Mutation | 1 · Low | Optional · Stable · E1 · Auto=Manual | Preferences | None | Reversibly disables opening Game Bar through the controller button. It only changes input/UX behavior. | Minimum build=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"UseNexusForGameBarEnabled","Value":0,"Kind":"DWord"}] | Exclusive group: V7ControllerGameBar | Registry; no declarative Undo; inspect engine |

#### Graphics & GPU (7)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7GP001` | Enable optimizations for windowed games / Activar optimizaciones para juegos en ventana | 13 → 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Performance | AppRestart | Reversibly configures the Windows preference for optimizations for windowed games. Read-back proves ConfigurationVerification; effective state remains PendingAppRestart. Settings storage is treated as conditional until native smoke testing. Interactions: Auto HDR can force these optimizations. Restart the app/game before evaluating effective state; VSO7 preserves unowned tokens. Measurement: DX10/DX11 windowed/borderless frame latency, Present mode, app restart | Minimum build=22621; GraphicsGlobalWindowedDesired=yes | Exclusive group: V7WindowedGamesGlobal | Special; specialized or non-guaranteed recovery |
| `V7GP002` | Disable optimizations for windowed games (A/B) / Desactivar optimizaciones para juegos en ventana (A/B) | 13 → 13 → 1 | Mutation | 2 · Medium | Experimental · Conditional · E3 · Auto=Never | Performance | AppRestart | Configures the reversible global A/B override. Read-back verifies configuration only; EffectiveVerification remains PendingAppRestart. Blocked when Auto HDR is present and storage semantics remain conditional until native smoke testing. Interactions: Auto HDR can force these optimizations. Restart the app/game before evaluating effective state; VSO7 preserves unowned tokens. Measurement: A/B frame latency, Present mode, compatibility regressions | Minimum build=22621; GraphicsGlobalWindowedDesired=no | Exclusive group: V7WindowedGamesGlobal | Special; specialized or non-guaranteed recovery |
| `V7GP003` | Enable HAGS when support is verified / Activar HAGS si el soporte esta verificado | 13 → 13 → 1 | Mutation | 2 · Medium | Optional · Conditional · E2 · Auto=Manual | Performance, Gaming | SystemRestart | HAGS is mutated only when dxdiag yields an unambiguous per-adapter Stable aggregate. Write/read-back proves configuration; EffectiveVerification remains PendingReboot until a post-reboot check. Interactions: Mixed Stable Enabled/Disabled, Experimental, or Unknown states block mutation. AlwaysOff alongside a coherent Stable adapter does not by itself invalidate the system. Measurement: post-reboot HAGS effective state, frame-time consistency, GPU scheduling regressions | Minimum build=19041; Administrator=yes; Commands=["dxdiag.exe"]; HagsSupported=yes; HagsDesiredEnabled=yes | Exclusive group: V7HagsMode | Special; specialized or non-guaranteed recovery |
| `V7GP004` | Disable HAGS (A/B) when support is verified / Desactivar HAGS (A/B) si el soporte esta verificado | 13 → 13 → 1 | Mutation | 2 · Medium | Experimental · Experimental · E2 · Auto=Never | Performance | SystemRestart | HAGS is mutated only when dxdiag yields an unambiguous per-adapter Stable aggregate. Write/read-back proves configuration; EffectiveVerification remains PendingReboot until a post-reboot check. Interactions: Mixed Stable Enabled/Disabled, Experimental, or Unknown states block mutation. AlwaysOff alongside a coherent Stable adapter does not by itself invalidate the system. Measurement: post-reboot HAGS effective state, VR/frame-time comparison, regression testing | Minimum build=19041; Administrator=yes; Commands=["dxdiag.exe"]; HagsSupported=yes; HagsDesiredEnabled=no | Exclusive group: V7HagsMode | Special; specialized or non-guaranteed recovery |
| `V7GP101` | Native GPU topology diagnostic / Diagnostico nativo de topologia GPU | 13 → 13 → 1 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Combines DXCore, DXGI, PnP and runtime LUID correlation while preserving persistent identity separately from session identity. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: DXCore, DXGI, PnP, LUID correlation | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7GP102` | Per-display HDR/WCG/DRR diagnostic / Diagnostico HDR/WCG/DRR por pantalla | 13 → 13 → 1 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Reports active display targets with separate HDR support/user-enabled/active, WCG support/user-enabled/active and Dynamic Refresh Rate state. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: HDR support/user/active, WCG support/user/active, ActiveColorMode, DRR | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7GP103` | Graphics persistent/runtime identity diagnostic / Diagnostico de identidad grafica persistente/runtime | 13 → 13 → 1 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Shows the persistent and runtime identity evidence used to correlate GPUs and displays, failing closed on ambiguous matches. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: PnP, VEN/DEV/SUBSYS, monitor device path, EDID validity, runtime LUID | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Input (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7IN001` | Mouse and keyboard preference diagnostic / Diagnostico de preferencias de raton y teclado | 14 → 10 → 9 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Reads Windows mouse acceleration/sensitivity and keyboard repeat preferences and classifies them as user preferences, not measured latency. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: mouse thresholds, sensitivity, keyboard delay, keyboard speed | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Latency & Interrupts (5)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7LT001` | DPC/ISR system overview / Resumen DPC/ISR del sistema | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Samples Windows performance counters for DPC and ISR activity without claiming direct input latency or driver attribution. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: DPC average/max, ISR average/max, interrupt rate, ETW readiness | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7LT002` | CPU topology and heterogeneous classes / Topologia CPU y clases heterogeneas | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Enumerates Windows CPU Sets, processor groups, cores, SMT and EfficiencyClass/SchedulingClass when exposed by the OS. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: processor groups, EfficiencyClass, SchedulingClass, parked CPU sets | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7LT003` | Interrupt policy inventory / Inventario de politica de interrupciones | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Reads explicit device interrupt policy overrides and distinguishes absent/inherited state from an explicit setting. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: MSI override, MessageNumberLimit, affinity policy, assignment mask | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7LT004` | NIC MSI/MSI-X capability inventory / Inventario MSI/MSI-X de NIC | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Uses the Windows NetAdapter hardware provider to report MSI/MSI-X support, enabled state, message counts and NUMA data for network adapters. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: MsiSupported, MsiEnabled, MsiXSupported, MsiXEnabled, NUMA | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7LT005` | ETW DPC/ISR trace readiness / Preparacion ETW DPC/ISR | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Reports whether Windows tracing components needed for a detailed DPC/ISR investigation are present; it does not fabricate per-driver attribution. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: WPR availability, xperf availability, trace-required attribution | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Multi-tasking (7)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7MT001` | Disable Window Snapping / Desactivar ajuste de ventanas | 13 → 3 | Preference | 2 · Medium | Optional · Conditional · E3 · Auto=Never | Preferences | None | Disables snapping windows to screen edges and snap zones. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7MT002` | Disable Snap Assist / Desactivar sugerencias al acoplar ventanas | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Keeps other window features but prevents Windows from suggesting apps to complete a snap layout. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7MT003` | Disable Snap Layouts / Ocultar diseños de acoplamiento | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the snap-layout panel shown when hovering over Maximize or dragging to the top of the screen. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7MT004` | Hide Tabs In Alt Tab / No mostrar pestanas en Alt+Tab | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes Alt+Tab show windows instead of recent tabs from compatible applications. | No declared condition | None declared | Registry; diagnostic only |
| `V7MT005` | Show3 Tabs In Alt Tab / Mostrar 3 pestanas en Alt+Tab | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configures Alt+Tab to include up to three recent tabs from compatible applications. | No declared condition | None declared | Registry; diagnostic only |
| `V7MT006` | Show5 Tabs In Alt Tab / Mostrar 5 pestanas en Alt+Tab | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configures Alt+Tab to include up to five recent tabs from compatible applications. | No declared condition | None declared | Registry; diagnostic only |
| `V7MT007` | Show20 Tabs In Alt Tab / Mostrar 20 pestanas en Alt+Tab | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configures Alt+Tab to include many recent tabs; this can make the switcher more crowded. | No declared condition | None declared | Registry; diagnostic only |

#### Network (26)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisablePhysicalNicInterruptModerationForLowLatency` | Disable interrupt moderation for a low-latency test / Desactivar moderación para prueba de baja latencia | 13 → 10 | Mutation | 2 · Medium | Advanced · Conditional · E2 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Disables interrupt moderation only where the driver exposes the standardized keyword, for A/B testing of latency-sensitive workloads. Interactions: Microsoft documents that moderation can increase perceived RTT. Disabling it increases interrupts and can hurt CPU efficiency/throughput. Measurement: application RTT/frametime A/B, interrupt/DPC rate, CPU utilization | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*InterruptModeration","RegistryValue":"0"}]} | Conflicts: EnablePhysicalNicInterruptModeration; Exclusive group: InterruptModerationPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `DisablePhysicalNicRscForLowLatency` | Disable RSC for a measured low-latency test / Desactivar RSC para prueba de baja latencia | 13 → 10 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Disables IPv4/IPv6 RSC only on supported physical NICs for a low-latency A/B test. This is not a universal recommendation. Interactions: Only makes sense when a low-latency, low-throughput workload demonstrates a benefit. It can increase CPU use and reduce throughput. Measurement: application RTT/frametime A/B, receive throughput, CPU utilization | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*RscIPv4","RegistryValue":"0"},{"RegistryKeyword":"*RscIPv6","RegistryValue":"0"}]} | Conflicts: RestorePhysicalNicRsc; Exclusive group: PhysicalRscPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `EnablePhysicalNicInterruptModeration` | Enable interrupt moderation / Activar moderación de interrupciones | 13 → 10 | Mutation | 2 · Medium | Optional · Conditional · E1 · Auto=Manual | Performance | AdapterRestart | Enables the standardized NDIS interrupt-moderation keyword only when the driver exposes it. It reduces interrupts and CPU overhead at the cost of possible added latency. Interactions: This is the efficiency/throughput-oriented option; it is not automatically better for strict latency workloads. Measurement: interrupt/DPC rate, CPU utilization, application latency A/B | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*InterruptModeration","RegistryValue":"1"}]} | Conflicts: DisablePhysicalNicInterruptModerationForLowLatency; Exclusive group: InterruptModerationPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `EnablePhysicalNicRss` | Enable RSS on a supported physical NIC / Activar RSS en NIC física compatible | 13 → 10 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Enables RSS only on active supported physical NICs, identified by InterfaceGuid/PnP and verified after the change. RSS distributes receive processing across CPUs; it does not promise lower ping. If stack-wide RSS is disabled, restore that first. Interactions: Can briefly restart the NIC. R3 stores InterfaceGuid and PnPDeviceID; R2 backups retain a fail-closed legacy description path. Measurement: throughput under receive load, CPU utilization during receive load, game/network latency A/B if that is the target workload | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterRss","Enable-NetAdapterRss","Disable-NetAdapterRss"]; PhysicalRssDisabledRequired=yes | None declared | NetAdapterRss; no declarative Undo; inspect engine |
| `EnableTcpEcnForTesting` | Enable TCP ECN for A/B testing / Activar ECN para prueba A/B | 13 → 10 | Mutation | 2 · Medium | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Enables ECN on configurable TCP profiles as an advanced test on networks that actually support ECN. Never included in automatic recommendations. Interactions: Benefit depends on path support and congestion. Measure A/B. Measurement: loss under congestion, latency under congestion, throughput | Administrator=yes; Commands=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"EcnCapability","Value":"Enabled","AllowedSourceValues":["Disabled"]} | Exclusive group: TcpEcn | NetTcpSetting; no declarative Undo; inspect engine |
| `EnableWakeOnMagicPacketPhysicalNics` | Enable supported Wake-on-Magic-Packet / Activar Wake-on-Magic-Packet compatible | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | AdapterRestart | Enables WakeOnMagicPacket only on physical NICs Windows reports as supported. Stores InterfaceGuid/PnP identity and per-adapter baseline. Interactions: VSO7 writes with -NoRestart and marks Effective=PendingRestart to avoid automatically disrupting connectivity. Measurement: Wake-on-LAN test after adapter/system restart | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"WakeOnMagicPacket","Value":"Enabled","OnlyUp":false} | None declared | NetAdapterPower; no declarative Undo; inspect engine |
| `EnableWakeOnPatternPhysicalNics` | Enable supported Wake-on-Pattern / Activar Wake-on-Pattern compatible | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | AdapterRestart | Enables WakeOnPattern only on physical NICs Windows reports as supported. It can wake the PC for patterns other than Magic Packet, so this is a wake preference, not performance. Interactions: Configured with -NoRestart and remains PendingRestart. Measurement: sleep/wake behavior | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"WakeOnPattern","Value":"Enabled","OnlyUp":false} | None declared | NetAdapterPower; no declarative Undo; inspect engine |
| `RestoreGlobalReceiveSegmentCoalescing` | Restore global TCP/IP RSC / Restaurar RSC global del stack TCP/IP | 13 → 10 | Mutation | 1 · Low | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Enables global Receive Segment Coalescing when disabled. It favors efficiency/throughput and does not guarantee lower latency. Interactions: The global state does not replace per-NIC RSC capability. Measurement: receive throughput, CPU utilization, latency A/B | Administrator=yes; Commands=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"ReceiveSegmentCoalescing","Value":"Enabled"} | None declared | NetOffloadGlobal; no declarative Undo; inspect engine |
| `RestoreGlobalReceiveSideScaling` | Restore global TCP/IP RSS / Restaurar RSS global del stack TCP/IP | 13 → 10 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, Gaming | None | Enables Receive Side Scaling globally in the network stack when it was disabled. This is separate from per-NIC RSS state. Interactions: Global RSS and NIC RSS are separate layers; after restoring the global state, review the physical-NIC feature if needed. Measurement: receive throughput, per-core CPU distribution under receive load | Administrator=yes; Commands=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"ReceiveSideScaling","Value":"Enabled"} | None declared | NetOffloadGlobal; no declarative Undo; inspect engine |
| `RestoreGlobalTaskOffload` | Restore global task offload / Restaurar task offload global | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E2 · Auto=Eligible | Performance, Responsiveness | AdapterRestart | Re-enables global TCP/IP task offload if it was disabled. A post-read confirms the configured value, but Microsoft documents that TaskOffload becomes effective after an adapter or system restart. Interactions: Configured can be Enabled while Effective remains PendingRestart. VSO7 does not automatically restart all NICs to avoid disrupting connectivity. Measurement: CPU utilization under network load, throughput | Administrator=yes; Commands=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"TaskOffload","Value":"Enabled"} | None declared | NetOffloadGlobal; no declarative Undo; inspect engine |
| `RestoreNicSelectiveSuspendOnLaptops` | Restore NIC selective suspend on laptops / Restaurar selective suspend de NIC en laptop | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | AdapterRestart | Enables selective suspend only on laptop physical NICs that support it and currently have it disabled. This is capability-based power saving, not a ping optimization. Interactions: Configured with -NoRestart and remains PendingRestart. Measurement: idle battery drain, network resume behavior | Administrator=yes; Device type=Laptop; Commands=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"SelectiveSuspend","Value":"Enabled","OnlyUp":false} | None declared | NetAdapterPower; no declarative Undo; inspect engine |
| `RestorePhysicalNicChecksumOffloads` | Restore physical NIC checksum offloads / Restaurar checksum offloads de NIC física | 13 → 10 | Mutation | 2 · Medium | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | AdapterRestart | Restores Rx+Tx on IPv4/TCP/UDP checksum offloads that the physical NIC exposes through standardized NDIS keywords. Missing keys are never created. Interactions: Microsoft recommends keeping checksum offload enabled; VSO7 only changes properties exposed by the driver with an allowed value. The NIC may briefly restart. Measurement: throughput and CPU utilization under network load, driver error counters before/after | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*IPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*TCPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*UDPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*TCPChecksumOffloadIPv6","RegistryValue":"3"},{"RegistryKeyword":"*UDPChecksumOffloadIPv6","RegistryValue":"3"}]} | None declared | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `RestorePhysicalNicEee` | Restore Energy Efficient Ethernet / Restaurar Energy Efficient Ethernet | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | AdapterRestart | Enables only the standardized NDIS *EEE keyword where the driver exposes it and supports Enabled. Vendor-specific Green Ethernet variants are untouched. Interactions: This is a power-saving feature, not an FPS boost. VSO7 does not assume disabling it lowers ping. Measurement: idle power consumption, network stability/latency A/B if troubleshooting | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*EEE","RegistryValue":"1"}]} | Conflicts: V7NW204; Exclusive group: V7EeePolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `RestorePhysicalNicLso` | Restore Large Send Offload (LSO) / Restaurar Large Send Offload (LSO) | 13 → 10 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Enables LSO v2 IPv4/IPv6 only where the driver exposes it and supports Enabled. It reduces host segmentation work; it is not presented as a ping tweak. Interactions: LSO improves efficiency/throughput in many workloads, but a latency-sensitive workload should be measured A/B. Measurement: throughput, CPU utilization under transmit-heavy load, latency A/B if latency is the target workload | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*LsoV2IPv4","RegistryValue":"1"},{"RegistryKeyword":"*LsoV2IPv6","RegistryValue":"1"}]} | None declared | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `RestorePhysicalNicRsc` | Restore RSC on physical NICs / Restaurar RSC en NIC física | 13 → 10 | Mutation | 2 · Medium | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Enables IPv4/IPv6 RSC only on physical NICs that expose it. RSC reduces header processing and favors receive throughput. Interactions: Microsoft notes that RSC can affect latency and low-latency/low-throughput workloads can benefit from disabling it. Measurement: receive throughput, CPU utilization, latency A/B for low-latency workloads | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*RscIPv4","RegistryValue":"1"},{"RegistryKeyword":"*RscIPv6","RegistryValue":"1"}]} | Conflicts: DisablePhysicalNicRscForLowLatency; Exclusive group: PhysicalRscPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `RestoreTcpAutoTuningNormal` | Restore TCP receive autotuning to Normal / Restaurar TCP receive autotuning Normal | 13 → 10 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | None | Normalizes AutoTuningLevelLocal to Normal only on TCP profiles with restrictive overrides: Disabled, HighlyRestricted, or Restricted. Experimental is left untouched and reported separately. Interactions: Does not modify Experimental. Normal is the documented general state; aggressive profiles require separate review. Measurement: TCP throughput over high-bandwidth/high-latency paths, Get-NetTCPSetting before/after | Administrator=yes; Commands=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"AutoTuningLevelLocal","Value":"Normal","AllowedSourceValues":["Disabled","HighlyRestricted","Restricted"]} | None declared | NetTcpSetting; no declarative Undo; inspect engine |
| `RestoreTcpEcnDefaultDisabled` | Restore TCP ECN to Disabled / Restaurar ECN a Disabled | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Restores EcnCapability=Disabled on TCP profiles where it was explicitly enabled. Disabled is the general documented/observed state; an ECN-aware network can justify the opposite experimental feature. Interactions: Does not promise lower ping. Measurement: packet loss/congestion behavior, throughput | Administrator=yes; Commands=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"EcnCapability","Value":"Disabled","AllowedSourceValues":["Enabled"]} | Exclusive group: TcpEcn | NetTcpSetting; no declarative Undo; inspect engine |
| `RestoreTcpTimestampsAllowed` | Restore TCP timestamps to Allowed / Restaurar TCP timestamps a Allowed | 13 → 10 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Normalizes Timestamps to Allowed on profiles with Enabled/Disabled overrides. Windows documents Allowed as the default behavior: accept inbound timestamps when the peer supports them without universally forcing them. Interactions: Uses MSFT_NetTCPSetting because Set-NetTCPSetting on PS5.1 only accepts Enabled/Disabled; Allowed=2 is validated through CIM. It affects new TCP connections and does not rewrite established connections. Measurement: MSFT_NetTCPSetting.Timestamps before/after, new TCP connections | Administrator=yes; Commands=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Allowed","AllowedSourceValues":["Enabled","Disabled"]} | Exclusive group: V7TcpTimestampMode | NetTcpCimSetting; no declarative Undo; inspect engine |
| `V7NW101` | Force TCP timestamps for A/B testing / Forzar TCP timestamps para prueba A/B | 13 → 10 | Mutation | 2 · Medium | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Changes Timestamps through MSFT_NetTCPSetting, not through a value rejected by PS5.1 Set-NetTCPSetting. This is experimental and must be measured with new connections. Measurement: new-connection throughput, packet traces, CPU/network latency | Administrator=yes; Commands=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Enabled","AllowedSourceValues":["Allowed","Disabled"]} | Exclusive group: V7TcpTimestampMode | NetTcpCimSetting; no declarative Undo; inspect engine |
| `V7NW102` | Disable TCP timestamps for A/B testing / Desactivar TCP timestamps para prueba A/B | 13 → 10 | Mutation | 2 · Medium | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Changes Timestamps through MSFT_NetTCPSetting, not through a value rejected by PS5.1 Set-NetTCPSetting. This is experimental and must be measured with new connections. Measurement: new-connection throughput, packet traces, CPU/network latency | Administrator=yes; Commands=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Disabled","AllowedSourceValues":["Allowed","Enabled"]} | Exclusive group: V7TcpTimestampMode | NetTcpCimSetting; no declarative Undo; inspect engine |
| `V7NW201` | Local network quality diagnostic / Diagnostico de calidad de red local | 13 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Measures default-gateway ping, loss and jitter plus active link speed to help separate local/LAN problems from Internet or game-server problems. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: gateway latency, jitter, packet loss, link speed | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7NW202` | QoS/DSCP active policy inventory / Inventario de politicas QoS/DSCP | 13 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Reads active Windows QoS policies, including per-application matching and DSCP actions, without claiming that DSCP lowers ping. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: AppPathNameMatchCondition, DSCPAction, ActiveStore | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7NW203` | NIC driver capability inventory / Inventario de capacidades de driver NIC | 13 → 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Enumerates driver-exposed advanced properties by standardized RegistryKeyword and the valid values announced by the driver. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: RegistryKeyword, ValidRegistryValues, current value | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7NW204` | Disable Energy Efficient Ethernet for A/B testing / Desactivar Energy Efficient Ethernet para prueba A/B | 13 → 10 | Mutation | 2 · Medium | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Disables only the standardized NDIS *EEE keyword where the driver exposes and accepts Disabled. Vendor-specific variants are untouched and lower ping is not promised. Interactions: May increase power use. Measure stability/latency and restore when no benefit is demonstrated. Measurement: latency/jitter A/B, idle power, link stability | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*EEE","RegistryValue":"0"}]} | Conflicts: RestorePhysicalNicEee; Exclusive group: V7EeePolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `V7NW205` | Disable Large Send Offload for A/B testing / Desactivar Large Send Offload para prueba A/B | 13 → 10 | Mutation | 2 · Medium | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Disables LSO v2 IPv4/IPv6 only where the driver exposes the standardized keywords. CPU use may increase; this is not a universal recommendation. Interactions: LSO usually improves efficiency/throughput. Use only as a measured A/B for a specific workload. Measurement: CPU utilization, throughput, latency/jitter A/B | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*LsoV2IPv4","RegistryValue":"0"},{"RegistryKeyword":"*LsoV2IPv6","RegistryValue":"0"}]} | Conflicts: RestorePhysicalNicLso; Exclusive group: V7LsoPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |
| `V7NW206` | Disable checksum offloads for A/B testing / Desactivar checksum offloads para prueba A/B | 13 → 10 | Mutation | 3 · High | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Disables Rx/Tx checksum offload through standardized NDIS keywords only where the driver accepts Disabled. Microsoft generally recommends keeping offloads; this is experimental. Interactions: May hurt CPU/throughput and is not recommended by default. VSO7 preserves per-NIC baseline and restarts only affected adapters. Measurement: CPU utilization, throughput, packet errors, latency A/B | Administrator=yes; Commands=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*IPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*TCPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*UDPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*TCPChecksumOffloadIPv6","RegistryValue":"0"},{"RegistryKeyword":"*UDPChecksumOffloadIPv6","RegistryValue":"0"}]} | Conflicts: RestorePhysicalNicChecksumOffloads; Exclusive group: V7ChecksumOffloadPolicy | NetAdapterAdvanced; no declarative Undo; inspect engine |

#### Optional Windows Features (2)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7OF001` | Enable Windows Sandbox / Activar Windows Sandbox | 13 → 5 | Mutation | 3 · High | Advanced · Conditional · E3 · Auto=Manual | System | SystemRestart | Enables the optional Windows Sandbox feature. A restart and compatible virtualization may be required. | Administrator=yes; Modules=["Dism"]; Optional features=["Containers-DisposableClientVM"] | None declared | Special; specialized or non-guaranteed recovery |
| `V7OF002` | Enable Windows Subsystem For Linux / Activar WSL | 13 → 5 | Mutation | 3 · High | Advanced · Conditional · E3 · Auto=Manual | System | SystemRestart | Enables WSL and Virtual Machine Platform. A restart may be required and the installed optional-feature set is changed. | Administrator=yes; Modules=["Dism"]; Optional features=["VirtualMachinePlatform","Microsoft-Windows-Subsystem-Linux"] | None declared | Special; specialized or non-guaranteed recovery |

#### Other (2)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7OT001` | Disable Settings Home / Ocultar Inicio de Configuracion | 13 → 5 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | General | None | Prevents Settings from using the promotional Home page as its main entry page. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7OT002` | Disable Brave Bloat / Desactivar extras de Brave | 13 → 5 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | General | None | Disables several promotional Brave features, such as AI/crypto components, depending on the installed version. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### Power & USB (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableUsbSelectiveSuspend` | Restore USB selective suspend / Restaurar suspensión selectiva USB | 13 → 9 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, PowerEfficiency | None | Enables USB selective suspend for AC and DC on the active power plan when it was disabled. Microsoft strongly recommends not disabling it globally; VSO7 preserves the real previous values and does not present it as an FPS tweak. Interactions: Effective behavior also depends on the USB device and driver. Measurement: powercfg /query for the active scheme, USB ETW/power diagnostics only when troubleshooting device behavior | Administrator=yes; Commands=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_USB","SettingAlias":"USBSELECTIVE","RequireDifferentFrom":1} | Exclusive group: UsbSelectiveSuspendPolicy | PowerSetting; no declarative Undo; inspect engine |

#### Privacy & Suggested Content (8)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7PV001` | Disable Telemetry / Reducir telemetria y anuncios dirigidos | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables several Windows diagnostics, tracking, and advertising-personalization settings without disabling Windows Update. | No declared condition | None declared | Registry; declarative rollback (17 operation(s)) |
| `V7PV002` | Disable Suggestions / Desactivar consejos y contenido sugerido | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Removes recommendations, tips, and promotional suggestions that Windows shows in different parts of the interface. | No declared condition | None declared | Registry; declarative rollback (19 operation(s)) |
| `V7PV003` | Disable Notifications / Desactivar notificaciones de aplicaciones | 13 → 1 | Mutation | 2 · Medium | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables notifications from apps and other senders. You may miss useful alerts. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7PV004` | Disable Location Services / Desactivar servicios de ubicacion | 13 → 1 | Mutation | 2 · Medium | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Prevents Windows and applications from using the device location until you enable it again. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7PV005` | Disable Find My Device / Desactivar Buscar mi dispositivo | 13 → 1 | Mutation | 2 · Medium | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Disables the tracking used by Find My Device, so that anti-theft/location feature will no longer be available. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7PV006` | Disable Lockscreen Tips / Quitar consejos de la pantalla de bloqueo | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Removes suggestions and promotional content from the lock screen. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7PV007` | Disable Edge Ads / Quitar anuncios y sugerencias de Edge | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Reduces news, recommendations, and promotional content inside Microsoft Edge. | No declared condition | None declared | Registry; declarative rollback (13 operation(s)) |
| `V7PV008` | Disable Settings365 Ads / Ocultar promociones de Microsoft 365 en Configuracion | 13 → 1 | Mutation | 1 · Low | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Removes Microsoft 365/Copilot banners and promotions from the Settings home page. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### Services (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SV001` | Service dependency diagnostic / Diagnostico de dependencias de servicios | 14 → 10 → 10; mutations in 10 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Shows service dependencies before any future service recommendation; VSO7 does not bulk-disable services. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: ServicesDependedOn, DependentServices, status | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Special (8)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SP001` | Remove Apps / Eliminar aplicaciones seleccionadas | 13 → 8 | Diagnostic | 4 · Very high | Advanced · Conditional · E3 · Auto=Never | System | None | Removes only the applications you choose in the selector. Some system apps can be difficult to restore, so review each one before confirming. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP002` | Apps / Lista de aplicaciones | 13 → 8 | Diagnostic | 1 · Low | Advanced · Conditional · E3 · Auto=Never | System | None | Defines which applications would be removed. It is used by the app selector and is not an independent toggle. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP003` | Remove Gaming Apps / Eliminar apps de Xbox y Barra de juegos | 13 → 8 | Mutation | 3 · High | Advanced · Conditional · E3 · Auto=Manual | System | None | Uninstalls the Xbox app and Game Bar components. Not recommended if you use Game Pass, Xbox captures, or Xbox social features. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP004` | Remove HP Apps / Eliminar software OEM de HP | 13 → 8 | Mutation | 3 · High | Advanced · Conditional · E3 · Auto=Manual | System | None | Uninstalls several preinstalled HP applications. This may remove support utilities or manufacturer-specific features. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP005` | Create Restore Point / Crear punto de restauracion | 13 → 8 | Diagnostic | 1 · Low | Advanced · Conditional · E3 · Auto=Never | System | None | Creates a Windows restore point before applying changes. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP006` | Replace Start / Reemplazar diseño de Inicio | 13 → 8 | Diagnostic | 3 · High | Advanced · Conditional · E3 · Auto=Never | System | None | Replaces the current user’s pinned Start items with a template that you must provide. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP007` | Replace Start All Users / Reemplazar Inicio para todos los usuarios | 13 → 8 | Diagnostic | 4 · Very high | Advanced · Conditional · E3 · Auto=Never | System | None | Applies a Start template to existing and new users; the template should be reviewed carefully first. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7SP008` | Force Remove Edge / Forzar desinstalacion de Microsoft Edge | 13 → 8 | Mutation | 4 · Very high | Advanced · Conditional · E3 · Auto=Manual | System | None | Attempts to remove Edge even when Windows treats it as a component. This may break links, widgets, or features that depend on WebView/Edge. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |

#### Start Menu & Search (12)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisableSearchHighlights` | Disable Search Highlights / Desactivar contenido destacado de Busqueda | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Removes dynamic or promotional content from the Windows search box without disabling search. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `DisableSearchHistory` | Disable Search History / Desactivar historial de busqueda de Windows | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Prevents Windows Search from keeping the device search history. It does not disable Windows Search or delete your files. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7ST001` | Clear Start / Vaciar aplicaciones ancladas de Inicio | 13 → 3 | Diagnostic | 3 · High | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reserved for a future native implementation; this RC does not replace Start menu binary files. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7ST002` | Clear Start All Users / Vaciar Inicio para todos los usuarios | 13 → 3 | Diagnostic | 4 · Very high | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reserved for a future native implementation; this RC does not replace Start menu binary files. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7ST003` | Disable Start Recommended / Ocultar Recomendados en Inicio | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the recommended files and applications section of the Start menu. | No declared condition | None declared | Registry; declarative rollback (5 operation(s)) |
| `V7ST004` | Disable Start All Apps / Ocultar Todas las aplicaciones en Inicio | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the All apps section/list of the Start menu. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7ST005` | Disable Start Phone Link / Quitar Enlace Movil de Inicio | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Disables Phone Link integration in the Start menu. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7ST006` | Disable Bing / Desactivar resultados web de Bing en Busqueda | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Makes Start search focus on local results instead of querying Bing/Copilot. | No declared condition | None declared | Registry; declarative rollback (3 operation(s)) |
| `V7ST007` | Disable Store Search Suggestions / Quitar sugerencias de Microsoft Store en Busqueda | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reserved in this RC: not exposed until a native method with sufficiently robust permission rollback is available. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7ST008` | Start All Apps Category / Mostrar Todas las aplicaciones por categorias | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Uses the category view for All apps when that Windows version supports it. | No declared condition | None declared | Registry; diagnostic only |
| `V7ST009` | Start All Apps Grid / Mostrar Todas las aplicaciones en cuadricula | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Changes All apps to a grid view. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7ST010` | Start All Apps List / Mostrar Todas las aplicaciones en lista | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Uses the classic list view for All apps. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |

#### Storage (9)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableNtfsTrimWhenDisabledNoReFs` | Restore NTFS TRIM on SSD/NVMe / Restaurar TRIM NTFS en SSD/NVMe | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | None | Enables delete notifications (TRIM/unmap) only when NTFS has them disabled, SSD/NVMe storage exists, and no ReFS volume is detected. VSO7 avoids mixing the change with ReFS to keep ownership clear. Interactions: Microsoft documents NTFS TRIM as enabled by default and effective on the next unmap; no restart is required. Measurement: fsutil behavior query DisableDeleteNotify | Administrator=yes; Commands=["fsutil.exe","Get-PhysicalDisk","Get-Volume"]; StorageMediaAnyOf=["SSD"]; FsutilNtfsTrimDisabledNoReFs=yes | None declared | FsutilTrim; no declarative Undo; inspect engine |
| `EnableScheduledDriveOptimization` | Restore scheduled drive optimization / Restaurar optimizacion programada de unidades | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Recommended · Stable · E1 · Auto=Eligible | Balanced, Performance | None | Re-enables the built-in ScheduledDefrag task if it was disabled. Windows chooses defrag/retrim/tier optimization by drive type; VSO7 does not force SSD defragmentation. Interactions: The maintenance task uses Windows native per-media logic. Measurement: ScheduledDefrag enabled state, Optimize Drives last-run history | Administrator=yes; Commands=["Get-ScheduledTask","Enable-ScheduledTask","Disable-ScheduledTask","Export-ScheduledTask"]; ScheduledTaskDisabled={"TaskPath":"\\Microsoft\\Windows\\Defrag\\","TaskName":"ScheduledDefrag"} | None declared | ScheduledTaskState; no declarative Undo; inspect engine |
| `RestoreStorageSensePolicyToUserControl` | Restore Storage Sense policy to user control / Restaurar control de Storage Sense al usuario | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Removes an AllowStorageSenseGlobal=0 policy that blocks Storage Sense, returning control to Settings. It does not force Storage Sense on. Interactions: Microsoft-documented ADMX policy; removed only when explicitly set to 0. Measurement: Storage Sense Settings availability | Administrator=yes; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","NumericMin":0,"NumericMax":0} | Exclusive group: V7StorageSenseGlobal | Registry; no declarative Undo; inspect engine |
| `RestoreStorageSenseTempCleanupPolicyToUserControl` | Restore Storage Sense temp-cleanup policy to user control / Restaurar control de temporales de Storage Sense | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Removes a policy that forces or blocks Storage Sense temporary-file cleanup so the user controls that choice again. Interactions: Does not delete any files during application. Measurement: Storage Sense temporary-files option availability | Administrator=yes; RegistryValueExists=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup"}] | Exclusive group: V7StorageSenseTemp | Registry; no declarative Undo; inspect engine |
| `V7SR101` | Allow Storage Sense by policy / Permitir Storage Sense por politica | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Forces the official policy that allows Storage Sense. This is Windows administration, not a performance boost. Measurement: Storage Sense Settings | Minimum build=18362; Edition=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrator=yes; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","Value":1,"Kind":"DWord"}] | Exclusive group: V7StorageSenseGlobal | Registry; no declarative Undo; inspect engine |
| `V7SR102` | Block Storage Sense by policy / Bloquear Storage Sense por politica | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Advanced · Conditional · E1 · Auto=Manual | Performance | None | Blocks Storage Sense through policy. It can prevent automatic cleanup and is not recommended as an optimization. Measurement: Storage Sense Settings | Minimum build=18362; Edition=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrator=yes; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","Value":0,"Kind":"DWord"}] | Exclusive group: V7StorageSenseGlobal | Registry; no declarative Undo; inspect engine |
| `V7SR103` | Allow Storage Sense temporary-file cleanup / Permitir limpieza de temporales de Storage Sense | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Allows the documented policy for unused temporary-file cleanup when Storage Sense runs. Measurement: Storage Sense Settings | Minimum build=18362; Edition=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrator=yes; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup","Value":1,"Kind":"DWord"}] | Exclusive group: V7StorageSenseTemp | Registry; no declarative Undo; inspect engine |
| `V7SR104` | Block Storage Sense temporary-file cleanup / Bloquear limpieza de temporales de Storage Sense | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Mutation | 1 · Low | Advanced · Conditional · E1 · Auto=Manual | Performance | None | Prevents Storage Sense temporary-file cleanup by policy. This is an administrative preference, not an optimization. Measurement: Storage Sense Settings | Minimum build=18362; Edition=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrator=yes; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup","Value":0,"Kind":"DWord"}] | Exclusive group: V7StorageSenseTemp | Registry; no declarative Undo; inspect engine |
| `V7ST201` | Physical disk health and reliability / Salud y fiabilidad de discos fisicos | 4/19; diagnostics 14 → 3 or 14 → 10 → 5 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Reads Storage reliability counters such as temperature, wear, power-on hours and errors when the device/driver exposes them. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: health status, temperature, wear, uncorrected errors | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### System (8)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SY001` | Disable Drag Tray / Desactivar bandeja al arrastrar archivos | 13 → 2 | Mutation | 1 · Low | Advanced · Conditional · E3 · Auto=Manual | System | None | Disables the tray that appears when dragging files to share or move them. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY002` | Revert Context Menu / Usar menu contextual clasico | 13 → 2 | Mutation | 1 · Low | Advanced · Conditional · E3 · Auto=Manual | System | None | Uses the classic context-menu style similar to Windows 10. This is mainly an interface change. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY003` | Disable Mouse Acceleration / Desactivar Mejorar precision del puntero | 13 → 2 | Mutation | 1 · Low | Optional · Conditional · E1 · Auto=Manual | System | Logoff | Disables Windows pointer acceleration for the traditional pointer path. This is a control preference; games using raw input may ignore it. Measurement: pointer feel/consistency; not FPS | No declared condition | None declared | Registry; declarative rollback (3 operation(s)) |
| `V7SY004` | Disable Sticky Keys / Desactivar atajo de Teclas especiales | 13 → 2 | Mutation | 1 · Low | Advanced · Conditional · E3 · Auto=Manual | System | None | Prevents pressing Shift five times from opening the Sticky Keys dialog; it does not disable the keyboard. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY005` | Disable Storage Sense / Desactivar Sensor de almacenamiento | 13 → 2 | Mutation | 2 · Medium | Optional · Conditional · E1 · Auto=Manual | System | None | Disables Storage Sense for the current user. This is a cleanup/storage preference, not an FPS optimization. Measurement: free-space behavior over time | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY006` | Disable Fast Startup / Desactivar Inicio rapido | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Makes Shut down perform a more complete shutdown instead of using partial hibernation. Startup may take slightly longer. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY007` | Disable Bitlocker Auto Encryption / Evitar cifrado automatico futuro de BitLocker | 13 → 2 | Mutation | 3 · High | Advanced · Conditional · E3 · Auto=Never | System | None | Prevents Windows from automatically enabling device encryption on some PCs. It does not decrypt drives that are already encrypted. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7SY008` | Disable Modern Standby Networking / Desactivar red durante Modern Standby | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Reduces network activity while the PC is in Modern Standby; background synchronization may be delayed while sleeping. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |

#### Taskbar (19)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7TB001` | Taskbar Align Left / Alinear barra de tareas a la izquierda | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Moves the main taskbar icons to the left. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB002` | Hide Search Taskbar / Ocultar Busqueda de la barra de tareas | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the Search button/box from the taskbar; Start search remains available. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB003` | Show Search Icon Taskbar / Mostrar icono de Busqueda | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows only the Search icon on the taskbar. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB004` | Show Search Label Taskbar / Mostrar icono y texto de Busqueda | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows the Search icon together with its label on the taskbar. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB005` | Show Search Box Taskbar / Mostrar cuadro de Busqueda | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows the full search box on the taskbar. | No declared condition | None declared | Registry; diagnostic only |
| `V7TB006` | Hide Taskview / Ocultar Vista de tareas | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the Task View button; Win+Tab still depends on Windows configuration. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB007` | Disable Widgets / Desactivar Widgets | 13 → 3 | Preference | 3 · High | Optional · Conditional · E3 · Auto=Never | Preferences | None | Disables taskbar and lock-screen widgets by removing their related packages. Reinstalling them may be required to restore the feature. | No declared condition | None declared | Special; specialized or non-guaranteed recovery |
| `V7TB008` | Hide Chat / Ocultar Chat/Reunirse ahora | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hides the Chat/Meet Now shortcut from the taskbar. | No declared condition | None declared | Registry; declarative rollback (2 operation(s)) |
| `V7TB009` | Enable End Task / Mostrar Finalizar tarea en la barra | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Adds an option to end an application from the context menu of its taskbar icon. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB010` | Enable Last Active Click / Activar ultimo clic activo en la barra | 13 → 3 | Preference | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Clicking a grouped taskbar button switches directly to the last active window. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB011` | Combine Taskbar Always / Combinar siempre botones de la barra principal | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Always groups windows from the same application and hides labels on the main monitor. | No declared condition | None declared | Registry; diagnostic only |
| `V7TB012` | Combine Multi-Monitor Taskbar Always / Combinar siempre en barras secundarias | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Always groups windows on taskbars shown on secondary monitors. | No declared condition | None declared | Registry; diagnostic only |
| `V7TB013` | Combine Taskbar When Full / Combinar botones cuando la barra se llene | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Keeps labels visible until the main taskbar runs out of space. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB014` | Combine Multi-Monitor Taskbar When Full / Combinar en monitores secundarios cuando se llenen | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Applies the “when taskbar is full” behavior to secondary-monitor taskbars. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB015` | Combine Taskbar Never / No combinar botones de la barra principal | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows each window separately with its label on the main monitor. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB016` | Combine Multi-Monitor Taskbar Never / No combinar en barras secundarias | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows windows separately on secondary monitors. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB017` | Multi-Monitor Taskbar Mode All / Mostrar apps en todas las barras | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | On multi-monitor systems, shows application icons on every taskbar. | No declared condition | None declared | Registry; diagnostic only |
| `V7TB018` | Multi-Monitor Taskbar Mode Main Active / Mostrar apps en barra principal y monitor activo | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | Shows each app on the main taskbar and on the taskbar of the monitor containing its window. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7TB019` | Multi-Monitor Taskbar Mode Active / Mostrar apps solo en su monitor | 13 → 3 | Diagnostic | 1 · Low | Optional · Conditional · E3 · Auto=Never | Preferences | None | On multi-monitor systems, each window appears only on the taskbar of the monitor where it is open. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

#### USB & HID (2)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7US001` | USB controller-to-device topology / Topologia controlador-dispositivo USB | 14 → 10 → 4; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Maps USB controllers to connected logical devices and classifies common HID, audio, storage and hub roles. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: controller, device, PnP class, classification | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |
| `V7US002` | USB power diagnostic / Diagnostico de energia USB | 14 → 10 → 4; 17 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Reports current USB selective suspend power-plan values and USB hub power metadata without exposing a global disable-everything action. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: USBSELECTIVE AC/DC, hub power support | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Wi-Fi (1)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7WF001` | Wi-Fi driver capability inventory / Inventario de capacidades Wi-Fi | 14 → 10 → 7 | Diagnostic | 1 · Low | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Enumerates advanced Wi-Fi properties exposed by the installed driver and keeps localized display names separate from stable RegistryKeyword identifiers. Interactions: Read-only. An Unknown/unavailable state is not presented as a system failure. Measurement: preferred band if exposed, roaming if exposed, power/MIMO values if exposed | Administrator=no; RuntimeProbeRequired=yes; FailClosedWhenUnavailable=yes | None declared | Special; specialized or non-guaranteed recovery |

#### Windows Update (4)

| ID | English / Spanish name | Path | Type | Risk | Policy | Objectives | Restart | Effect/interaction | Exact applicability | Relations | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7WU001` | Disable Update ASAP / No recibir actualizaciones en cuanto esten disponibles | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Disables the option to receive non-security updates as soon as possible; Windows Update remains enabled. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7WU002` | Prevent Update Auto Reboot / Evitar reinicios automaticos de Update con sesion iniciada | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Reduces automatic update restarts while a user is signed in. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7WU003` | Disable Delivery Optimization / Desactivar compartir actualizaciones con otros PCs | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Prevents Delivery Optimization from exchanging parts of updates with other PCs. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |
| `V7WU004` | Disable Device Auto App Download / Evitar apps compañeras automaticas de dispositivos | 13 → 2 | Mutation | 2 · Medium | Advanced · Conditional · E3 · Auto=Manual | System | None | Prevents Windows from automatically installing certain recommended applications when hardware is connected. | No declared condition | None declared | Registry; declarative rollback (1 operation(s)) |

### Practical guide to the 120 selectable tweaks

This subsection preserves the user-oriented explanations from the initial documentation and cross-checks them against the `FeatureId` and metadata in the VSO7 1.2.1 catalog. The technical matrix above remains authoritative for applicability, relationships, operations, and Recovery. This guide explains in direct language what each tweak does, when it makes sense, and what the user may lose.

#### Special

##### `V7SP003` — Remove Gaming Apps

- **What it does:** Uninstalls the Xbox app and Game Bar components. Not recommended if you use Game Pass, Xbox captures, or Xbox social features.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection. You lose Xbox/Game Bar components. This can affect Game Pass, captures, Xbox sign-in or social features.
- **Documented reversibility:** Not through VSO7’s normal Recovery path. If you apply it, assume manual repair or reinstall may be needed.
- **Current metadata:** risk 3/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SP004` — Remove HP Apps

- **What it does:** Uninstalls several preinstalled HP applications. This may remove support utilities or manufacturer-specific features.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection. You may lose HP battery, support, diagnostics, printer or other OEM-specific features.
- **Documented reversibility:** Not through VSO7’s normal Recovery path. If you apply it, assume manual repair or reinstall may be needed.
- **Current metadata:** risk 3/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SP008` — Force Remove Edge

- **What it does:** Attempts to remove Edge even when Windows treats it as a component. This may break links, widgets, or features that depend on WebView/Edge.
- **When it is worth considering:** It can remove Edge, but VSO7 treats this as an aggressive operation because other Windows features may depend on Edge components.
- **Practical consequence or risk:** **Very high (4/4)** — Very high: it can remove an important component and be difficult to recover. It can break links, Widgets or features that rely on Microsoft web components. Recovery may require a manual reinstall.
- **Documented reversibility:** Not through VSO7’s normal Recovery path. If you apply it, assume manual repair or reinstall may be needed.
- **Current metadata:** risk 4/4 · `Advanced` · reboot `None` · auto `Manual`.

#### Privacy & Suggested Content

##### `V7PV001` — Disable Telemetry

- **What it does:** Disables several Windows diagnostics, tracking, and advertising-personalization settings without disabling Windows Update.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV002` — Disable Suggestions

- **What it does:** Removes recommendations, tips, and promotional suggestions that Windows shows in different parts of the interface.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV003` — Disable Notifications

- **What it does:** Disables notifications from apps and other senders. You may miss useful alerts.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV004` — Disable Location Services

- **What it does:** Prevents Windows and applications from using the device location until you enable it again.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness. Apps will not be able to use device location until you restore it.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV005` — Disable Find My Device

- **What it does:** Disables the tracking used by Find My Device, so that anti-theft/location feature will no longer be available.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness. You lose Find my device.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV006` — Disable Lockscreen Tips

- **What it does:** Removes suggestions and promotional content from the lock screen.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV007` — Disable Edge Ads

- **What it does:** Reduces news, recommendations, and promotional content inside Microsoft Edge.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PV008` — Disable Settings365 Ads

- **What it does:** Removes Microsoft 365/Copilot banners and promotions from the Settings home page.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

#### AI

##### `V7AI001` — Disable Copilot

- **What it does:** Disables Copilot integration in Windows. It does not uninstall third-party applications.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI002` — Disable Recall

- **What it does:** Disables Recall so Windows does not use that AI-assisted history/snapshot feature.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI003` — Disable Click To Do

- **What it does:** Disables Click to Do contextual analysis of text and images.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI004` — Disable AI Service Auto Start

- **What it does:** Prevents the AI service configured by Windows from starting automatically; some AI features may stop working.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI005` — Disable Edge AI

- **What it does:** Disables several AI features integrated into Microsoft Edge.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI006` — Disable Paint AI

- **What it does:** Disables Paint AI features when Windows exposes them through these policies.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7AI007` — Disable Notepad AI

- **What it does:** Disables Notepad AI features when they are available.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

#### Gaming

##### `V7GM001` — Disable game capture/recording (legacy)

- **What it does:** Disables game capture/recording. VSO7 retains this advanced variant for functional compatibility, but recommends the per-user variant because this one also writes a machine policy.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem. You lose Xbox Game Bar capture/recording while it is applied.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `AppRestart` · auto `Manual`.

##### `RestoreGameRecordingPolicyToUserControl` — Restore game recording policy to user control

- **What it does:** Removes a forced block on game recording and gives control back to the user. It does not enable captures by itself.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AppRestart` · auto `Manual`.

##### `DisableBackgroundGameCapturePerUser` — Disable per-user background game capture

- **What it does:** Disables background game recording for your user. This reduces capture activity, but you lose Xbox Game Bar’s “record what just happened” feature.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem. You lose Xbox Game Bar background capture.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AppRestart` · auto `Manual`.

##### `V7GM101` — Enable Game Mode

- **What it does:** Enables the official Game Mode preference. It does not promise higher FPS; Windows decides effective behavior based on the game, hardware and scheduler.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `AppRestart` · auto `Eligible`.

##### `V7GM102` — Disable Game Mode for A/B testing

- **What it does:** Disables Game Mode reversibly for a specific A/B comparison. It is not a universal recommendation.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Experimental` · reboot `AppRestart` · auto `Never`.

##### `V7GM103` — Allow controller to open Game Bar

- **What it does:** Enables the official preference that lets a controller button open Game Bar. This is a UX preference, not a performance tweak.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7GM104` — Block controller from opening Game Bar

- **What it does:** Reversibly disables opening Game Bar through the controller button. It only changes input/UX behavior.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

#### Start Menu & Search

##### `V7ST003` — Disable Start Recommended

- **What it does:** Hides the recommended files and applications section of the Start menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7ST004` — Disable Start All Apps

- **What it does:** Hides the All apps section/list of the Start menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7ST005` — Disable Start Phone Link

- **What it does:** Disables Phone Link integration in the Start menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7ST006` — Disable Bing

- **What it does:** Makes Start search focus on local results instead of querying Bing/Copilot.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `DisableSearchHistory` — Disable Search History

- **What it does:** Prevents Windows Search from keeping the device search history. It does not disable Windows Search or delete your files.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `DisableSearchHighlights` — Disable Search Highlights

- **What it does:** Removes dynamic or promotional content from the Windows search box without disabling search.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

#### Other

##### `V7OT001` — Disable Settings Home

- **What it does:** Prevents Settings from using the promotional Home page as its main entry page.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7OT002` — Disable Brave Bloat

- **What it does:** Disables several promotional Brave features, such as AI/crypto components, depending on the installed version.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

#### Appearance

##### `V7UI004` — Enable Dark Mode

- **What it does:** Enables the dark theme for Windows and compatible applications.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7UI005` — Disable Transparency

- **What it does:** Reduces Windows transparency effects. This is a reversible visual change.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7UI006` — Disable Animations

- **What it does:** Disables several animations so the interface feels more immediate.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem. The interface will look less animated and visually simpler.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

#### System

##### `V7SY001` — Disable Drag Tray

- **What it does:** Disables the tray that appears when dragging files to share or move them.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SY002` — Revert Context Menu

- **What it does:** Uses the classic context-menu style similar to Windows 10. This is mainly an interface change.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SY003` — Disable Mouse Acceleration

- **What it does:** Disables Windows pointer acceleration for the traditional pointer path. This is a control preference; games using raw input may ignore it.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `Logoff` · auto `Manual`.

##### `V7SY004` — Disable Sticky Keys

- **What it does:** Prevents pressing Shift five times from opening the Sticky Keys dialog; it does not disable the keyboard.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SY005` — Disable Storage Sense

- **What it does:** Disables Storage Sense for the current user. This is a cleanup/storage preference, not an FPS optimization.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7SY006` — Disable Fast Startup

- **What it does:** Makes Shut down perform a more complete shutdown instead of using partial hibernation. Startup may take slightly longer.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SY007` — Disable Bitlocker Auto Encryption

- **What it does:** Prevents Windows from automatically enabling device encryption on some PCs. It does not decrypt drives that are already encrypted.
- **When it is worth considering:** It works, but it is not a performance optimization. It prevents future automatic device encryption and therefore reduces protection if the PC is lost or stolen.
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection. It reduces protection against loss or theft by preventing automatic encryption on some PCs. It reduces a Windows security protection.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 3/4 · `Advanced` · reboot `None` · auto `Never`.

##### `V7SY008` — Disable Modern Standby Networking

- **What it does:** Reduces network activity while the PC is in Modern Standby; background synchronization may be delayed while sleeping.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness. With networking disabled during Modern Standby, some sync and notifications may wait until the PC wakes.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

#### Multi-tasking

##### `V7MT001` — Disable Window Snapping

- **What it does:** Disables snapping windows to screen edges and snap zones.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7MT002` — Disable Snap Assist

- **What it does:** Keeps other window features but prevents Windows from suggesting apps to complete a snap layout.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7MT003` — Disable Snap Layouts

- **What it does:** Hides the snap-layout panel shown when hovering over Maximize or dragging to the top of the screen.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

#### Taskbar

##### `V7TB001` — Taskbar Align Left

- **What it does:** Moves the main taskbar icons to the left.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7TB006` — Hide Taskview

- **What it does:** Hides the Task View button; Win+Tab still depends on Windows configuration.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7TB007` — Disable Widgets

- **What it does:** Disables taskbar and lock-screen widgets by removing their related packages. Reinstalling them may be required to restore the feature.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection.
- **Documented reversibility:** Not through VSO7’s normal Recovery path. If you apply it, assume manual repair or reinstall may be needed.
- **Current metadata:** risk 3/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7TB008` — Hide Chat

- **What it does:** Hides the Chat/Meet Now shortcut from the taskbar.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7TB009` — Enable End Task

- **What it does:** Adds an option to end an application from the context menu of its taskbar icon.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7TB010` — Enable Last Active Click

- **What it does:** Clicking a grouped taskbar button switches directly to the last active window.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

#### File Explorer

##### `V7FE005` — Show Known File Extensions

- **What it does:** Shows .exe, .txt, .jpg, and other known file extensions to make files easier to identify.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE006` — Show Hidden Folders

- **What it does:** Makes items marked as hidden visible in File Explorer.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE007` — Hide Dupli Drive

- **What it does:** Prevents some USB drives from appearing twice in the File Explorer navigation pane.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE008` — Hide Home

- **What it does:** Removes Home from the File Explorer navigation pane.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE009` — Hide Gallery

- **What it does:** Removes Gallery from the File Explorer navigation pane.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE010` — Hide OneDrive

- **What it does:** Hides OneDrive from the File Explorer navigation pane; it does not uninstall the client or delete files.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE011` — Hide3d Objects

- **What it does:** Removes the 3D Objects folder from This PC.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE012` — Hide Music

- **What it does:** Removes Music from This PC/the navigation pane, depending on the Windows version.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE013` — Add Folders To This PC

- **What it does:** Shows common folders such as Documents and Downloads in This PC again.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE014` — Hide Include In Library

- **What it does:** Removes the “Include in library” entry from the File Explorer context menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE015` — Hide Give Access To

- **What it does:** Removes the “Give access to” sharing entry from the File Explorer context menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

##### `V7FE016` — Hide Share

- **What it does:** Removes the Share entry from the modern context menu.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Never`.

#### Windows Update

##### `V7WU001` — Disable Update ASAP

- **What it does:** Disables the option to receive non-security updates as soon as possible; Windows Update remains enabled.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7WU002` — Prevent Update Auto Reboot

- **What it does:** Reduces automatic update restarts while a user is signed in.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness. It may postpone reboots Windows Update wanted to perform automatically.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7WU003` — Disable Delivery Optimization

- **What it does:** Prevents Delivery Optimization from exchanging parts of updates with other PCs.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7WU004` — Disable Device Auto App Download

- **What it does:** Prevents Windows from automatically installing certain recommended applications when hardware is connected.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

#### Optional Windows Features

##### `V7OF001` — Enable Windows Sandbox

- **What it does:** Enables the optional Windows Sandbox feature. A restart and compatible virtualization may be required.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection. It adds a Windows virtualization feature and may require a reboot.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 3/4 · `Advanced` · reboot `SystemRestart` · auto `Manual`.

##### `V7OF002` — Enable Windows Subsystem For Linux

- **What it does:** Enables WSL and Virtual Machine Platform. A restart may be required and the installed optional-feature set is changed.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection. It adds WSL and virtualization components. It may require a reboot and changes installed Windows features.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 3/4 · `Advanced` · reboot `SystemRestart` · auto `Manual`.

#### Power & USB

##### `EnableUsbSelectiveSuspend` — Restore USB selective suspend

- **What it does:** Lets Windows put idle USB devices into a low-power state again. It saves power; it is not an FPS tweak.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

#### Network

##### `EnablePhysicalNicRss` — Enable RSS on a supported physical NIC

- **What it does:** Lets incoming network work be spread across several CPU cores. It can help under heavy traffic; it does not promise lower ping.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicChecksumOffloads` — Restore physical NIC checksum offloads

- **What it does:** Lets the network adapter do part of the work of checking incoming and outgoing data instead of leaving all of it to the CPU.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Recommended` · reboot `AdapterRestart` · auto `Eligible`.

##### `RestorePhysicalNicLso` — Restore Large Send Offload (LSO)

- **What it does:** Lets the network adapter prepare large sends with less CPU work. It is mainly an efficiency feature, not a ping tweak.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicRsc` — Restore RSC on physical NICs

- **What it does:** Lets Windows group some received network traffic to reduce CPU work. It favors efficiency and throughput, not necessarily latency.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `AdapterRestart` · auto `Manual`.

##### `DisablePhysicalNicRscForLowLatency` — Disable RSC for a measured low-latency test

- **What it does:** Stops grouping some received traffic so you can test whether your workload gets lower latency. It can increase CPU use and is meant for before/after testing.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `AdapterRestart` · auto `Manual`.

##### `RestoreGlobalReceiveSideScaling` — Restore global TCP/IP RSS

- **What it does:** Lets Windows spread incoming network work across multiple CPU cores again. It is a sensible restore when another tweak disabled it.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `RestoreGlobalReceiveSegmentCoalescing` — Restore global TCP/IP RSC

- **What it does:** Lets Windows group received traffic again to reduce CPU work. It is not a universal ping improvement.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `RestoreGlobalTaskOffload` — Restore global task offload

- **What it does:** Lets Windows use supported network-adapter assistance again instead of doing everything on the CPU.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AdapterRestart` · auto `Eligible`.

##### `RestoreTcpAutoTuningNormal` — Restore TCP receive autotuning to Normal

- **What it does:** Returns network receive sizing to Windows automatic control. It removes manual limits that can reduce download or transfer speed.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `EnablePhysicalNicInterruptModeration` — Enable interrupt moderation

- **What it does:** Lets the network adapter group notifications to the CPU. This reduces CPU load but can add a small amount of latency.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `AdapterRestart` · auto `Manual`.

##### `DisablePhysicalNicInterruptModerationForLowLatency` — Disable interrupt moderation for a low-latency test

- **What it does:** Makes the network adapter notify the CPU with less grouping to test for lower latency. It can increase CPU load significantly.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicEee` — Restore Energy Efficient Ethernet

- **What it does:** Restores Ethernet power saving when the adapter supports it. It saves power; it is not a gaming improvement.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AdapterRestart` · auto `Eligible`.

##### `EnableWakeOnMagicPacketPhysicalNics` — Enable supported Wake-on-Magic-Packet

- **What it does:** Allows the PC to wake from the network using a special wake signal when supported. It does not improve performance.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AdapterRestart` · auto `Manual`.

##### `RestoreNicSelectiveSuspendOnLaptops` — Restore NIC selective suspend on laptops

- **What it does:** Lets a laptop put an idle network adapter into a low-power state again. It does not improve ping.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AdapterRestart` · auto `Eligible`.

##### `RestoreTcpEcnDefaultDisabled` — Restore TCP ECN to Disabled

- **What it does:** Returns an advanced network-congestion feature to its normal disabled state. This is normalization, not a speed tweak.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `EnableTcpEcnForTesting` — Enable TCP ECN for A/B testing

- **What it does:** Enables an advanced network-congestion feature for testing on a compatible network. It is not recommended as a general optimization.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `None` · auto `Never`.

##### `RestoreTcpTimestampsAllowed` — Restore TCP timestamps to Allowed

- **What it does:** Returns TCP timing markers to normal Windows behavior. It does not promise lower ping.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `EnableWakeOnPatternPhysicalNics` — Enable supported Wake-on-Pattern

- **What it does:** Allows certain network traffic patterns to wake the PC. This is convenience/power behavior, not performance.
- **When it is worth considering:** Yes, it makes that exact change, but it is a usability/appearance preference; **it is not a promise of more performance**.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AdapterRestart` · auto `Manual`.

##### `V7NW101` — Force TCP timestamps for A/B testing

- **What it does:** Forces TCP timing markers only for before/after testing. It is not a general optimization.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `None` · auto `Never`.

##### `V7NW102` — Disable TCP timestamps for A/B testing

- **What it does:** Disables TCP timing markers only for before/after testing. It is not a general optimization.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `None` · auto `Never`.

##### `V7NW204` — Disable Energy Efficient Ethernet for A/B testing

- **What it does:** Disables Ethernet power saving to test whether latency or stability changes. It can increase power use and does not guarantee lower ping.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `AdapterRestart` · auto `Never`.

##### `V7NW205` — Disable Large Send Offload for A/B testing

- **What it does:** Makes the CPU do more network-send work for comparison. It can increase CPU use and does not guarantee lower latency.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `AdapterRestart` · auto `Never`.

##### `V7NW206` — Disable checksum offloads for A/B testing

- **What it does:** Makes the CPU also handle network packet checking for comparison. It can significantly increase CPU use and is normally not recommended.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **High (3/4)** — High: it can disable an important feature or reduce a protection.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 3/4 · `Experimental` · reboot `AdapterRestart` · auto `Never`.

#### Diagnostics

##### `NormalizeClampedSystemResponsivenessOverride` — Normalize clamped MMCSS override below 10 to 20

- **What it does:** Cleans up an unusual multimedia-priority value when it is between 0 and 9. Windows already treats those values as 20, so this makes the configuration clearer but should not add performance.
- **When it is worth considering:** The change works, but **do not expect a performance gain**: Windows already treats those values equivalently.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

#### CPU & Power

##### `EnableProcessorBoostModeOnAcDesktop` — Enable CPU boost on AC when it was disabled

- **What it does:** Lets a plugged-in desktop CPU use turbo/boost again when it had been disabled.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `RestorePowerThrottlingToUserControl` — Restore normal Power Throttling control

- **What it does:** Returns normal background-process power-saving control to Windows and the user.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `RestoreMaxProcessorStateOnAcDesktop` — Restore 100% CPU maximum on AC desktop

- **What it does:** Removes an artificial CPU cap and restores 100% maximum state on a plugged-in desktop.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `SetProcessorEppPerformanceOnAcDesktop` — Performance-oriented EPP on AC desktop

- **What it does:** Makes a plugged-in desktop CPU favor performance over power saving. It can increase power use and temperature.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `SetProcessorEppBalancedOnAcDesktop` — Balanced EPP on AC desktop

- **What it does:** Uses a middle ground between CPU responsiveness and power use on a plugged-in desktop.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `SetProcessorEppEfficiencyOnBatteryLaptop` — Efficiency-oriented EPP on laptop battery

- **What it does:** Makes a laptop on battery favor battery life and temperature over maximum CPU performance.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Eligible`.

##### `EnableActiveCoolingOnAcLaptop` — Prefer active cooling on AC laptop

- **What it does:** On a plugged-in laptop, prefers using the fans more before reducing CPU performance. It may be noisier.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Eligible`.

##### `V7PW101` — Balanced EPP on AC laptop

- **What it does:** On a plugged-in laptop, keeps the CPU at a balance between performance and power use.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7PW102` — Performance-oriented EPP on AC laptop

- **What it does:** On a plugged-in laptop, makes the CPU favor performance more strongly. It can increase temperature, power use and fan noise.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7PW103` — Disable CPU boost on battery

- **What it does:** On battery, disables CPU turbo/boost to reduce power use and temperature. Peak performance also drops.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem. Peak CPU performance is lower on battery.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Eligible`.

##### `V7PW104` — Moderate PCIe ASPM on battery

- **What it does:** On battery, uses moderate PCIe power saving. It can add a little wake-up latency.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Eligible`.

##### `V7PW105` — Maximum PCIe ASPM on battery

- **What it does:** On battery, uses stronger PCIe power saving. It saves more power but may take longer to return to full responsiveness.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness. Some PCIe devices may be slower to return from power saving.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Advanced` · reboot `None` · auto `Manual`.

#### Storage

##### `EnableNtfsTrimWhenDisabledNoReFs` — Restore NTFS TRIM on SSD/NVMe

- **What it does:** Restores the normal SSD notification that tells a drive which deleted space can be reused. This is normal maintenance for supported SSDs.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `EnableScheduledDriveOptimization` — Restore scheduled drive optimization

- **What it does:** Restores Windows scheduled drive maintenance. Windows chooses the appropriate maintenance for each drive type.
- **When it is worth considering:** Yes, when VSO7 detects the situation it is designed to correct. It is one of the more conservative choices.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Recommended` · reboot `None` · auto `Eligible`.

##### `RestoreStorageSensePolicyToUserControl` — Restore Storage Sense policy to user control

- **What it does:** Removes a forced Storage Sense rule and gives the choice back to the user.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `RestoreStorageSenseTempCleanupPolicyToUserControl` — Restore Storage Sense temp-cleanup policy to user control

- **What it does:** Gives the user control over whether Storage Sense cleans temporary files.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7SR101` — Allow Storage Sense by policy

- **What it does:** Forces the official policy that allows Storage Sense. This is Windows administration, not a performance boost.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7SR102` — Block Storage Sense by policy

- **What it does:** Blocks Storage Sense through policy. It can prevent automatic cleanup and is not recommended as an optimization.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

##### `V7SR103` — Allow Storage Sense temporary-file cleanup

- **What it does:** Allows the documented policy for unused temporary-file cleanup when Storage Sense runs.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `None` · auto `Manual`.

##### `V7SR104` — Block Storage Sense temporary-file cleanup

- **What it does:** Prevents Storage Sense temporary-file cleanup by policy. This is an administrative preference, not an optimization.
- **When it is worth considering:** It works as a Windows change, but only makes sense in specific cases. **Do not assume “more tweaks = more performance”.**
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Advanced` · reboot `None` · auto `Manual`.

#### Graphics & GPU

##### `V7GP001` — Enable optimizations for windowed games

- **What it does:** Enables the modern Windows optimization for games running in windowed or borderless mode. It can improve presentation behavior for some compatible games.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Low (1/4)** — Low: it is unlikely to cause a serious problem.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 1/4 · `Optional` · reboot `AppRestart` · auto `Manual`.

##### `V7GP002` — Disable optimizations for windowed games (A/B)

- **What it does:** Temporarily disables that windowed-game optimization so you can compare results. It is not presented as universally better.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `AppRestart` · auto `Never`.

##### `V7GP003` — Enable HAGS when support is verified

- **What it does:** Enables hardware-accelerated GPU scheduling only when Windows and the driver report support. Results depend on the GPU and game.
- **When it is worth considering:** Yes, it does what it says. It is worth using only if you want that behavior or have that specific problem.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Optional` · reboot `SystemRestart` · auto `Manual`.

##### `V7GP004` — Disable HAGS (A/B) when support is verified

- **What it does:** Disables hardware-accelerated GPU scheduling so you can compare before/after on a supported PC. It is not assumed to be better.
- **When it is worth considering:** The setting works, but it is **not proven to improve every PC**. It is there for before/after testing.
- **Practical consequence or risk:** **Medium (2/4)** — Medium: it can affect a feature, compatibility, power use or responsiveness.
- **Documented reversibility:** Yes. VSO7 records the previous state so it can be restored.
- **Current metadata:** risk 2/4 · `Experimental` · reboot `SystemRestart` · auto `Never`.

## 16. Complete application catalog

`safe` is a conservative candidate, but the app is still lost. `optional` depends on the user. `unsafe` may affect Windows and is never preselected. `SelectedByDefault` does not mean installed. Appx and WinGet are different engines.

| No. | Application | AppId | Method | Classification | Default | Catalog description |
|---:|---|---|---|---|---|---|
| 1 | Clipchamp | `Clipchamp.Clipchamp` | Appx | safe | Yes | Optional Windows application package: Clipchamp. |
| 2 | 3D Builder | `Microsoft.3DBuilder` | Appx | safe | Yes | Optional Windows application package: 3D Builder. |
| 3 | Cortana | `Microsoft.549981C3F5F10` | Appx | safe | Yes | Optional Windows application package: Cortana. |
| 4 | Bing Finance | `Microsoft.BingFinance` | Appx | safe | Yes | Optional Windows application package: Bing Finance. |
| 5 | Bing Food And Drink | `Microsoft.BingFoodAndDrink` | Appx | safe | Yes | Optional Windows application package: Bing Food And Drink. |
| 6 | Bing Health And Fitness | `Microsoft.BingHealthAndFitness` | Appx | safe | Yes | Optional Windows application package: Bing Health And Fitness. |
| 7 | Bing News | `Microsoft.BingNews` | Appx | safe | Yes | Optional Windows application package: Bing News. |
| 8 | Bing Sports | `Microsoft.BingSports` | Appx | safe | Yes | Optional Windows application package: Bing Sports. |
| 9 | Bing Translator | `Microsoft.BingTranslator` | Appx | safe | Yes | Optional Windows application package: Bing Translator. |
| 10 | Bing Travel | `Microsoft.BingTravel` | Appx | safe | Yes | Optional Windows application package: Bing Travel. |
| 11 | Bing Weather | `Microsoft.BingWeather` | Appx | safe | Yes | Optional Windows application package: Bing Weather. |
| 12 | Microsoft Copilot | `XP9CXNGPPJ97XX` | WinGet | safe | Yes | Optional Windows application package: Microsoft Copilot. |
| 13 | Copilot+ AI Hub | `Microsoft.Windows.AIHub` | Appx | safe | Yes | Optional Windows application package: Copilot+ AI Hub. |
| 14 | Microsoft PC Manager | `Microsoft.PCManager` | Appx | safe | Yes | Optional Windows application package: Microsoft PC Manager. |
| 15 | Get Started | `Microsoft.Getstarted` | Appx | safe | Yes | Optional Windows application package: Get Started. |
| 16 | Messaging | `Microsoft.Messaging` | Appx | safe | Yes | Optional Windows application package: Messaging. |
| 17 | 3D Viewer | `Microsoft.Microsoft3DViewer` | Appx | safe | Yes | Optional Windows application package: 3D Viewer. |
| 18 | Microsoft Journal | `Microsoft.MicrosoftJournal` | Appx | safe | Yes | Optional Windows application package: Microsoft Journal. |
| 19 | Office Hub | `Microsoft.MicrosoftOfficeHub` | Appx | safe | Yes | Optional Windows application package: Office Hub. |
| 20 | Power BI | `Microsoft.MicrosoftPowerBIForWindows` | Appx | safe | Yes | Optional Windows application package: Power BI. |
| 21 | Solitaire Collection | `Microsoft.MicrosoftSolitaireCollection` | Appx | safe | Yes | Optional Windows application package: Solitaire Collection. |
| 22 | Sticky Notes | `Microsoft.MicrosoftStickyNotes` | Appx | safe | Yes | Optional Windows application package: Sticky Notes. |
| 23 | Mixed Reality Portal | `Microsoft.MixedReality.Portal` | Appx | safe | Yes | Optional Windows application package: Mixed Reality Portal. |
| 24 | Network Speed Test | `Microsoft.NetworkSpeedTest` | Appx | safe | Yes | Optional Windows application package: Network Speed Test. |
| 25 | Microsoft News | `Microsoft.News` | Appx | safe | Yes | Optional Windows application package: Microsoft News. |
| 26 | OneNote | `Microsoft.Office.OneNote` | Appx | safe | Yes | Optional Windows application package: OneNote. |
| 27 | Sway | `Microsoft.Office.Sway` | Appx | safe | Yes | Optional Windows application package: Sway. |
| 28 | One Connect | `Microsoft.OneConnect` | Appx | safe | Yes | Optional Windows application package: One Connect. |
| 29 | Print 3D | `Microsoft.Print3D` | Appx | safe | Yes | Optional Windows application package: Print 3D. |
| 30 | Power Automate | `Microsoft.PowerAutomateDesktop` | Appx | safe | Yes | Optional Windows application package: Power Automate. |
| 31 | Skype (UWP) | `Microsoft.SkypeApp` | Appx | safe | Yes | Optional Windows application package: Skype (UWP). |
| 32 | Microsoft To Do | `Microsoft.Todos` | Appx | safe | Yes | Optional Windows application package: Microsoft To Do. |
| 33 | Dev Home | `Microsoft.Windows.DevHome` | Appx | safe | Yes | Optional Windows application package: Dev Home. |
| 34 | Alarms & Clock | `Microsoft.WindowsAlarms` | Appx | safe | Yes | Optional Windows application package: Alarms & Clock. |
| 35 | Feedback Hub | `Microsoft.WindowsFeedbackHub` | Appx | safe | Yes | Optional Windows application package: Feedback Hub. |
| 36 | Windows Maps | `Microsoft.WindowsMaps` | Appx | safe | Yes | Optional Windows application package: Windows Maps. |
| 37 | Sound Recorder | `Microsoft.WindowsSoundRecorder` | Appx | safe | Yes | Optional Windows application package: Sound Recorder. |
| 38 | Xbox Console Companion | `Microsoft.XboxApp` | Appx | safe | Yes | Optional Windows application package: Xbox Console Companion. |
| 39 | Movies & TV | `Microsoft.ZuneVideo` | Appx | safe | Yes | Optional Windows application package: Movies & TV. |
| 40 | Family Safety | `MicrosoftCorporationII.MicrosoftFamily` | Appx | safe | Yes | Optional Windows application package: Family Safety. |
| 41 | Quick Assist | `MicrosoftCorporationII.QuickAssist` | Appx | safe | Yes | Optional Windows application package: Quick Assist. |
| 42 | Microsoft Teams (Old) | `MicrosoftTeams` | Appx | safe | Yes | Optional Windows application package: Microsoft Teams (Old). |
| 43 | Microsoft Teams (New) | `MSTeams` | Appx | safe | Yes | Optional Windows application package: Microsoft Teams (New). |
| 44 | ACG Media Player | `ACGMediaPlayer` | Appx | safe | Yes | Optional Windows application package: ACG Media Player. |
| 45 | Actipro Software | `ActiproSoftwareLLC` | Appx | safe | Yes | Optional Windows application package: Actipro Software. |
| 46 | Adobe Photoshop Express | `AdobeSystemsIncorporated.AdobePhotoshopExpress` | Appx | safe | Yes | Optional Windows application package: Adobe Photoshop Express. |
| 47 | Amazon | `Amazon.com.Amazon` | Appx | safe | Yes | Optional Windows application package: Amazon. |
| 48 | Prime Video | `AmazonVideo.PrimeVideo` | Appx | safe | Yes | Optional Windows application package: Prime Video. |
| 49 | Asphalt 8 | `Asphalt8Airborne` | Appx | safe | Yes | Optional Windows application package: Asphalt 8. |
| 50 | Autodesk SketchBook | `AutodeskSketchBook` | Appx | safe | Yes | Optional Windows application package: Autodesk SketchBook. |
| 51 | Caesars Slots | `CaesarsSlotsFreeCasino` | Appx | safe | Yes | Optional Windows application package: Caesars Slots. |
| 52 | Cooking Fever | `COOKINGFEVER` | Appx | safe | Yes | Optional Windows application package: Cooking Fever. |
| 53 | CyberLink Media Suite | `CyberLinkMediaSuiteEssentials` | Appx | safe | Yes | Optional Windows application package: CyberLink Media Suite. |
| 54 | Disney Magic Kingdoms | `DisneyMagicKingdoms` | Appx | safe | Yes | Optional Windows application package: Disney Magic Kingdoms. |
| 55 | Disney+ | `Disney.37853FC22B2CE` | Appx | safe | Yes | Optional Windows application package: Disney+. |
| 56 | Drawboard PDF | `DrawboardPDF` | Appx | safe | Yes | Optional Windows application package: Drawboard PDF. |
| 57 | Duolingo | `Duolingo-LearnLanguagesforFree` | Appx | safe | Yes | Optional Windows application package: Duolingo. |
| 58 | Eclipse Manager | `EclipseManager` | Appx | safe | Yes | Optional Windows application package: Eclipse Manager. |
| 59 | Facebook | `FACEBOOK.FACEBOOK` | Appx | safe | Yes | Optional Windows application package: Facebook. |
| 60 | FarmVille 2 | `FarmVille2CountryEscape` | Appx | safe | Yes | Optional Windows application package: FarmVille 2. |
| 61 | Flipboard | `Flipboard` | Appx | safe | Yes | Optional Windows application package: Flipboard. |
| 62 | Hidden City | `HiddenCity` | Appx | safe | Yes | Optional Windows application package: Hidden City. |
| 63 | Hulu | `HULULLC.HULUPLUS` | Appx | safe | Yes | Optional Windows application package: Hulu. |
| 64 | iHeartRadio | `iHeartRadio` | Appx | safe | Yes | Optional Windows application package: iHeartRadio. |
| 65 | Instagram | `Facebook.Instagram` | Appx | safe | Yes | Optional Windows application package: Instagram. |
| 66 | Bubble Witch 3 | `king.com.BubbleWitch3Saga` | Appx | safe | Yes | Optional Windows application package: Bubble Witch 3. |
| 67 | Candy Crush Saga | `king.com.CandyCrushSaga` | Appx | safe | Yes | Optional Windows application package: Candy Crush Saga. |
| 68 | Candy Crush Soda | `king.com.CandyCrushSodaSaga` | Appx | safe | Yes | Optional Windows application package: Candy Crush Soda. |
| 69 | LinkedIn | `LinkedInforWindows` | Appx | safe | Yes | Optional Windows application package: LinkedIn. |
| 70 | March of Empires | `MarchofEmpires` | Appx | safe | Yes | Optional Windows application package: March of Empires. |
| 71 | Netflix | `4DF9E0F8.Netflix` | Appx | safe | Yes | Optional Windows application package: Netflix. |
| 72 | NYT Crossword | `NYTCrossword` | Appx | safe | Yes | Optional Windows application package: NYT Crossword. |
| 73 | One Calendar | `OneCalendar` | Appx | safe | Yes | Optional Windows application package: One Calendar. |
| 74 | Pandora | `PandoraMediaInc` | Appx | safe | Yes | Optional Windows application package: Pandora. |
| 75 | Phototastic Collage | `PhototasticCollage` | Appx | safe | Yes | Optional Windows application package: Phototastic Collage. |
| 76 | PicsArt | `PicsArt-PhotoStudio` | Appx | safe | Yes | Optional Windows application package: PicsArt. |
| 77 | Polarr Photo Editor | `PolarrPhotoEditorAcademicEdition` | Appx | safe | Yes | Optional Windows application package: Polarr Photo Editor. |
| 78 | Royal Revolt | `flaregamesGmbH.RoyalRevolt` | Appx | safe | Yes | Optional Windows application package: Royal Revolt. |
| 79 | Live Wallpaper | `Sidia.LiveWallpaper` | Appx | safe | Yes | Optional Windows application package: Live Wallpaper. |
| 80 | Sling TV | `SlingTV` | Appx | safe | Yes | Optional Windows application package: Sling TV. |
| 81 | Spotify | `SpotifyAB.SpotifyMusic` | Appx | safe | Yes | Optional Windows application package: Spotify. |
| 82 | TikTok | `BytedancePte.Ltd.TikTok` | Appx | safe | Yes | Optional Windows application package: TikTok. |
| 83 | TuneIn Radio | `TuneInRadio` | Appx | safe | Yes | Optional Windows application package: TuneIn Radio. |
| 84 | WinZip | `WinZipUniversal` | Appx | safe | Yes | Optional Windows application package: WinZip. |
| 85 | Bing Search | `Microsoft.BingSearch` | Appx | optional | No | Optional Windows application package: Bing Search. |
| 86 | Xbox Gaming App | `Microsoft.GamingApp` | Appx | optional | No | Optional Windows application package: Xbox Gaming App. |
| 87 | Get Help | `Microsoft.GetHelp` | Appx | unsafe | No | Optional Windows application package: Get Help. |
| 88 | Microsoft 365 Companions | `Microsoft.M365Companions` | Appx | optional | No | Optional Windows application package: Microsoft 365 Companions. |
| 89 | Paint 3D | `Microsoft.MSPaint` | Appx | optional | No | Optional Windows application package: Paint 3D. |
| 90 | OneDrive | `Microsoft.OneDrive` | WinGet | optional | No | Optional Windows application package: OneDrive. |
| 91 | Outlook for Windows | `Microsoft.OutlookForWindows` | Appx | optional | No | Optional Windows application package: Outlook for Windows. |
| 92 | Paint | `Microsoft.Paint` | Appx | optional | No | Optional Windows application package: Paint. |
| 93 | People | `Microsoft.People` | Appx | safe | No | Optional Windows application package: People. |
| 94 | Remote Desktop | `Microsoft.RemoteDesktop` | Appx | optional | No | Optional Windows application package: Remote Desktop. |
| 95 | Snipping Tool | `Microsoft.ScreenSketch` | Appx | optional | No | Optional Windows application package: Snipping Tool. |
| 96 | Widgets Experience | `Microsoft.StartExperiencesApp` | Appx | optional | No | Optional Windows application package: Widgets Experience. |
| 97 | Whiteboard | `Microsoft.Whiteboard` | Appx | optional | No | Optional Windows application package: Whiteboard. |
| 98 | Photos | `Microsoft.Windows.Photos` | Appx | optional | No | Optional Windows application package: Photos. |
| 99 | Calculator | `Microsoft.WindowsCalculator` | Appx | optional | No | Optional Windows application package: Calculator. |
| 100 | Camera | `Microsoft.WindowsCamera` | Appx | optional | No | Optional Windows application package: Camera. |
| 101 | Mail & Calendar | `Microsoft.windowscommunicationsapps` | Appx | safe | No | Optional Windows application package: Mail & Calendar. |
| 102 | Notepad | `Microsoft.WindowsNotepad` | Appx | optional | No | Optional Windows application package: Notepad. |
| 103 | Microsoft Store | `Microsoft.WindowsStore` | Appx | unsafe | No | Optional Windows application package: Microsoft Store. |
| 104 | Windows Terminal | `Microsoft.WindowsTerminal` | Appx | unsafe | No | Optional Windows application package: Windows Terminal. |
| 105 | Xbox TCUI Framework | `Microsoft.Xbox.TCUI` | Appx | unsafe | No | Optional Windows application package: Xbox TCUI Framework. |
| 106 | Xbox Game Overlay | `Microsoft.XboxGameOverlay` | Appx | optional | No | Optional Windows application package: Xbox Game Overlay. |
| 107 | Xbox Gaming Overlay | `Microsoft.XboxGamingOverlay` | Appx | optional | No | Optional Windows application package: Xbox Gaming Overlay. |
| 108 | Xbox Identity Provider | `Microsoft.XboxIdentityProvider` | Appx | unsafe | No | Optional Windows application package: Xbox Identity Provider. |
| 109 | Xbox Speech To Text | `Microsoft.XboxSpeechToTextOverlay` | Appx | unsafe | No | Optional Windows application package: Xbox Speech To Text. |
| 110 | Phone Link | `Microsoft.YourPhone` | Appx | optional | No | Optional Windows application package: Phone Link. |
| 111 | Media Player | `Microsoft.ZuneMusic` | Appx | optional | No | Optional Windows application package: Media Player. |
| 112 | Cross Device Experience | `MicrosoftWindows.CrossDevice` | Appx | optional | No | Optional Windows application package: Cross Device Experience. |
| 113 | Windows Web Experience Pack | `MicrosoftWindows.Client.WebExperience` | Appx | optional | No | Optional Windows application package: Windows Web Experience Pack. |
| 114 | Widgets Platform Runtime | `Microsoft.WidgetsPlatformRuntime` | Appx | optional | No | Optional Windows application package: Widgets Platform Runtime. |
| 115 | LG Monitor App | `LGElectronics.LGMonitorApp` | Appx | optional | No | Optional Windows application package: LG Monitor App. |
| 116 | HP AI Experience Center | `AD2F1837.HPAIExperienceCenter` | Appx | optional | No | Optional Windows application package: HP AI Experience Center. |
| 117 | HP Connected Music | `AD2F1837.HPConnectedMusic` | Appx | optional | No | Optional Windows application package: HP Connected Music. |
| 118 | HP Connected Photo | `AD2F1837.HPConnectedPhotopoweredbySnapfish` | Appx | optional | No | Optional Windows application package: HP Connected Photo. |
| 119 | HP Desktop Support Utilities | `AD2F1837.HPDesktopSupportUtilities` | Appx | optional | No | Optional Windows application package: HP Desktop Support Utilities. |
| 120 | HP Easy Clean | `AD2F1837.HPEasyClean` | Appx | optional | No | Optional Windows application package: HP Easy Clean. |
| 121 | HP File Viewer | `AD2F1837.HPFileViewer` | Appx | optional | No | Optional Windows application package: HP File Viewer. |
| 122 | HP JumpStarts | `AD2F1837.HPJumpStarts` | Appx | optional | No | Optional Windows application package: HP JumpStarts. |
| 123 | HP PC Hardware Diagnostics | `AD2F1837.HPPCHardwareDiagnosticsWindows` | Appx | optional | No | Optional Windows application package: HP PC Hardware Diagnostics. |
| 124 | HP Power Manager | `AD2F1837.HPPowerManager` | Appx | optional | No | Optional Windows application package: HP Power Manager. |
| 125 | HP Printer Control | `AD2F1837.HPPrinterControl` | Appx | optional | No | Optional Windows application package: HP Printer Control. |
| 126 | HP Privacy Settings | `AD2F1837.HPPrivacySettings` | Appx | optional | No | Optional Windows application package: HP Privacy Settings. |
| 127 | HP QuickDrop | `AD2F1837.HPQuickDrop` | Appx | optional | No | Optional Windows application package: HP QuickDrop. |
| 128 | HP QuickTouch | `AD2F1837.HPQuickTouch` | Appx | optional | No | Optional Windows application package: HP QuickTouch. |
| 129 | HP Registration | `AD2F1837.HPRegistration` | Appx | optional | No | Optional Windows application package: HP Registration. |
| 130 | HP Support Assistant | `AD2F1837.HPSupportAssistant` | Appx | optional | No | Optional Windows application package: HP Support Assistant. |
| 131 | HP Sure Shield AI | `AD2F1837.HPSureShieldAI` | Appx | optional | No | Optional Windows application package: HP Sure Shield AI. |
| 132 | HP System Information | `AD2F1837.HPSystemInformation` | Appx | optional | No | Optional Windows application package: HP System Information. |
| 133 | HP Welcome | `AD2F1837.HPWelcome` | Appx | optional | No | Optional Windows application package: HP Welcome. |
| 134 | HP WorkWell | `AD2F1837.HPWorkWell` | Appx | optional | No | Optional Windows application package: HP WorkWell. |
| 135 | myHP | `AD2F1837.myHP` | Appx | optional | No | Optional Windows application package: myHP. |
| 136 | Lenovo Vantage | `E046963F.LenovoCompanion` | Appx | optional | No | Optional Windows application package: Lenovo Vantage. |
| 137 | Lenovo Vantage Service | `LenovoCompanyLimited.LenovoVantageService` | Appx | optional | No | Optional Windows application package: Lenovo Vantage Service. |
| 138 | Dell SupportAssist | `DellInc.DellSupportAssistforPCs` | Appx | optional | No | Optional Windows application package: Dell SupportAssist. |
| 139 | Dell Digital Delivery Services | `DellInc.DellDigitalDelivery` | Appx | optional | No | Optional Windows application package: Dell Digital Delivery Services. |
| 140 | Dell Mobile Connect | `DellInc.DellMobileConnect` | Appx | optional | No | Optional Windows application package: Dell Mobile Connect. |

### Practical guide to all 140 application entries

The table above defines the identity and policy used by the code. This guide adds the human context from the initial documentation: what each entry is, whether it would normally be removed, and which feature may be lost. `SelectedByDefault` expresses catalog policy; it does not prove that the app is installed.

#### Safe (86)

##### Clipchamp

- **Identity:** `Clipchamp.Clipchamp` · `Appx`.
- **What it is:** Microsoft video editor.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### 3D Builder

- **Identity:** `Microsoft.3DBuilder` · `Appx`.
- **What it is:** older 3D model/printing tool.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Cortana

- **Identity:** `Microsoft.549981C3F5F10` · `Appx`.
- **What it is:** Microsoft’s old assistant.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Finance

- **Identity:** `Microsoft.BingFinance` · `Appx`.
- **What it is:** financial news and data.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Food And Drink

- **Identity:** `Microsoft.BingFoodAndDrink` · `Appx`.
- **What it is:** recipes and food content.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Health And Fitness

- **Identity:** `Microsoft.BingHealthAndFitness` · `Appx`.
- **What it is:** health and fitness content.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing News

- **Identity:** `Microsoft.BingNews` · `Appx`.
- **What it is:** news.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Sports

- **Identity:** `Microsoft.BingSports` · `Appx`.
- **What it is:** sports news and results.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Translator

- **Identity:** `Microsoft.BingTranslator` · `Appx`.
- **What it is:** translation.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Travel

- **Identity:** `Microsoft.BingTravel` · `Appx`.
- **What it is:** travel information.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bing Weather

- **Identity:** `Microsoft.BingWeather` · `Appx`.
- **What it is:** weather forecasts.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft Copilot

- **Identity:** `XP9CXNGPPJ97XX` · `WinGet`.
- **What it is:** the Copilot app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Copilot+ AI Hub

- **Identity:** `Microsoft.Windows.AIHub` · `Appx`.
- **What it is:** AI features hub for supported PCs.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft PC Manager

- **Identity:** `Microsoft.PCManager` · `Appx`.
- **What it is:** Microsoft maintenance tools.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Get Started

- **Identity:** `Microsoft.Getstarted` · `Appx`.
- **What it is:** Windows tips and welcome content.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Messaging

- **Identity:** `Microsoft.Messaging` · `Appx`.
- **What it is:** the old messaging app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### 3D Viewer

- **Identity:** `Microsoft.Microsoft3DViewer` · `Appx`.
- **What it is:** 3D model viewer.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft Journal

- **Identity:** `Microsoft.MicrosoftJournal` · `Appx`.
- **What it is:** handwritten notes.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Office Hub

- **Identity:** `Microsoft.MicrosoftOfficeHub` · `Appx`.
- **What it is:** Microsoft 365 shortcuts and promotion.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Power BI

- **Identity:** `Microsoft.MicrosoftPowerBIForWindows` · `Appx`.
- **What it is:** Power BI report viewer.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Solitaire Collection

- **Identity:** `Microsoft.MicrosoftSolitaireCollection` · `Appx`.
- **What it is:** Microsoft card games.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Sticky Notes

- **Identity:** `Microsoft.MicrosoftStickyNotes` · `Appx`.
- **What it is:** Sticky Notes.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Mixed Reality Portal

- **Identity:** `Microsoft.MixedReality.Portal` · `Appx`.
- **What it is:** Mixed Reality portal.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Network Speed Test

- **Identity:** `Microsoft.NetworkSpeedTest` · `Appx`.
- **What it is:** network speed test.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft News

- **Identity:** `Microsoft.News` · `Appx`.
- **What it is:** Microsoft news.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### OneNote

- **Identity:** `Microsoft.Office.OneNote` · `Appx`.
- **What it is:** OneNote notes.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Sway

- **Identity:** `Microsoft.Office.Sway` · `Appx`.
- **What it is:** Sway presentations/pages.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### One Connect

- **Identity:** `Microsoft.OneConnect` · `Appx`.
- **What it is:** older Microsoft connectivity app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Print 3D

- **Identity:** `Microsoft.Print3D` · `Appx`.
- **What it is:** 3D printing.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Power Automate

- **Identity:** `Microsoft.PowerAutomateDesktop` · `Appx`.
- **What it is:** task automation.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Skype (UWP)

- **Identity:** `Microsoft.SkypeApp` · `Appx`.
- **What it is:** older Skype app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft To Do

- **Identity:** `Microsoft.Todos` · `Appx`.
- **What it is:** lists and tasks.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Dev Home

- **Identity:** `Microsoft.Windows.DevHome` · `Appx`.
- **What it is:** developer dashboard.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Alarms & Clock

- **Identity:** `Microsoft.WindowsAlarms` · `Appx`.
- **What it is:** alarms, clocks and timers.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Feedback Hub

- **Identity:** `Microsoft.WindowsFeedbackHub` · `Appx`.
- **What it is:** sending feedback to Microsoft.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Windows Maps

- **Identity:** `Microsoft.WindowsMaps` · `Appx`.
- **What it is:** maps.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Sound Recorder

- **Identity:** `Microsoft.WindowsSoundRecorder` · `Appx`.
- **What it is:** audio recording.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Xbox Console Companion

- **Identity:** `Microsoft.XboxApp` · `Appx`.
- **What it is:** old Xbox companion app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Movies & TV

- **Identity:** `Microsoft.ZuneVideo` · `Appx`.
- **What it is:** Microsoft video player.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Family Safety

- **Identity:** `MicrosoftCorporationII.MicrosoftFamily` · `Appx`.
- **What it is:** family controls.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Quick Assist

- **Identity:** `MicrosoftCorporationII.QuickAssist` · `Appx`.
- **What it is:** remote assistance.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft Teams (Old)

- **Identity:** `MicrosoftTeams` · `Appx`.
- **What it is:** old Teams app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Microsoft Teams (New)

- **Identity:** `MSTeams` · `Appx`.
- **What it is:** Teams app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### ACG Media Player

- **Identity:** `ACGMediaPlayer` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Actipro Software

- **Identity:** `ActiproSoftwareLLC` · `Appx`.
- **What it is:** third-party Actipro package.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Adobe Photoshop Express

- **Identity:** `AdobeSystemsIncorporated.AdobePhotoshopExpress` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Amazon

- **Identity:** `Amazon.com.Amazon` · `Appx`.
- **What it is:** Amazon shopping app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Prime Video

- **Identity:** `AmazonVideo.PrimeVideo` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Asphalt 8

- **Identity:** `Asphalt8Airborne` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Autodesk SketchBook

- **Identity:** `AutodeskSketchBook` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Caesars Slots

- **Identity:** `CaesarsSlotsFreeCasino` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Cooking Fever

- **Identity:** `COOKINGFEVER` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### CyberLink Media Suite

- **Identity:** `CyberLinkMediaSuiteEssentials` · `Appx`.
- **What it is:** CyberLink media utilities.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Disney Magic Kingdoms

- **Identity:** `DisneyMagicKingdoms` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Disney+

- **Identity:** `Disney.37853FC22B2CE` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Drawboard PDF

- **Identity:** `DrawboardPDF` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Duolingo

- **Identity:** `Duolingo-LearnLanguagesforFree` · `Appx`.
- **What it is:** language learning.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Eclipse Manager

- **Identity:** `EclipseManager` · `Appx`.
- **What it is:** third-party app called Eclipse Manager.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Facebook

- **Identity:** `FACEBOOK.FACEBOOK` · `Appx`.
- **What it is:** third-party social/content app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### FarmVille 2

- **Identity:** `FarmVille2CountryEscape` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Flipboard

- **Identity:** `Flipboard` · `Appx`.
- **What it is:** third-party social/content app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Hidden City

- **Identity:** `HiddenCity` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Hulu

- **Identity:** `HULULLC.HULUPLUS` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### iHeartRadio

- **Identity:** `iHeartRadio` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Instagram

- **Identity:** `Facebook.Instagram` · `Appx`.
- **What it is:** third-party social/content app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Bubble Witch 3

- **Identity:** `king.com.BubbleWitch3Saga` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Candy Crush Saga

- **Identity:** `king.com.CandyCrushSaga` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Candy Crush Soda

- **Identity:** `king.com.CandyCrushSodaSaga` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### LinkedIn

- **Identity:** `LinkedInforWindows` · `Appx`.
- **What it is:** third-party social/content app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### March of Empires

- **Identity:** `MarchofEmpires` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Netflix

- **Identity:** `4DF9E0F8.Netflix` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### NYT Crossword

- **Identity:** `NYTCrossword` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### One Calendar

- **Identity:** `OneCalendar` · `Appx`.
- **What it is:** third-party calendar.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Pandora

- **Identity:** `PandoraMediaInc` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Phototastic Collage

- **Identity:** `PhototasticCollage` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### PicsArt

- **Identity:** `PicsArt-PhotoStudio` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Polarr Photo Editor

- **Identity:** `PolarrPhotoEditorAcademicEdition` · `Appx`.
- **What it is:** the “Polarr Photo Editor” app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Royal Revolt

- **Identity:** `flaregamesGmbH.RoyalRevolt` · `Appx`.
- **What it is:** third-party game/entertainment app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Live Wallpaper

- **Identity:** `Sidia.LiveWallpaper` · `Appx`.
- **What it is:** third-party creative/editing app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Sling TV

- **Identity:** `SlingTV` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### Spotify

- **Identity:** `SpotifyAB.SpotifyMusic` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### TikTok

- **Identity:** `BytedancePte.Ltd.TikTok` · `Appx`.
- **What it is:** third-party social/content app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### TuneIn Radio

- **Identity:** `TuneInRadio` · `Appx`.
- **What it is:** media playback/streaming app.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### WinZip

- **Identity:** `WinZipUniversal` · `Appx`.
- **What it is:** file compression/archive utility.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `Yes`.

##### People

- **Identity:** `Microsoft.People` · `Appx`.
- **What it is:** contacts.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `No`.

##### Mail & Calendar

- **Identity:** `Microsoft.windowscommunicationsapps` · `Appx`.
- **What it is:** old mail/calendar apps.
- **Practical guidance:** Yes, if you do not use it. Basic Windows operation does not require it.
- **What may be lost:** Low: you mainly lose that app and its features.
- **Current policy:** `safe` · default `No`.

#### Optional (48)

##### Bing Search

- **Identity:** `Microsoft.BingSearch` · `Appx`.
- **What it is:** Bing web results integrated into Windows.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Xbox Gaming App

- **Identity:** `Microsoft.GamingApp` · `Appx`.
- **What it is:** Xbox and PC Game Pass.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose the Xbox app and convenient PC Game Pass access.
- **Current policy:** `optional` · default `No`.

##### Microsoft 365 Companions

- **Identity:** `Microsoft.M365Companions` · `Appx`.
- **What it is:** small apps tied to Microsoft 365.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Paint 3D

- **Identity:** `Microsoft.MSPaint` · `Appx`.
- **What it is:** Microsoft 3D editor.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### OneDrive

- **Identity:** `Microsoft.OneDrive` · `WinGet`.
- **What it is:** OneDrive file sync.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** Check whether Desktop, Documents or Pictures are synced first: synchronization will stop.
- **Current policy:** `optional` · default `No`.

##### Outlook for Windows

- **Identity:** `Microsoft.OutlookForWindows` · `Appx`.
- **What it is:** Outlook mail/calendar.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Paint

- **Identity:** `Microsoft.Paint` · `Appx`.
- **What it is:** basic image/drawing editor.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You will need another basic drawing/editing app.
- **Current policy:** `optional` · default `No`.

##### Remote Desktop

- **Identity:** `Microsoft.RemoteDesktop` · `Appx`.
- **What it is:** Remote Desktop client.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose that remote connection client.
- **Current policy:** `optional` · default `No`.

##### Snipping Tool

- **Identity:** `Microsoft.ScreenSketch` · `Appx`.
- **What it is:** screenshots and screen recording.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose the built-in screenshot and screen-recording tool.
- **Current policy:** `optional` · default `No`.

##### Widgets Experience

- **Identity:** `Microsoft.StartExperiencesApp` · `Appx`.
- **What it is:** Windows Widgets experience.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Whiteboard

- **Identity:** `Microsoft.Whiteboard` · `Appx`.
- **What it is:** collaborative whiteboard.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Photos

- **Identity:** `Microsoft.Windows.Photos` · `Appx`.
- **What it is:** photo viewer/editor.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You will need another image viewer.
- **Current policy:** `optional` · default `No`.

##### Calculator

- **Identity:** `Microsoft.WindowsCalculator` · `Appx`.
- **What it is:** calculator.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You will need another calculator.
- **Current policy:** `optional` · default `No`.

##### Camera

- **Identity:** `Microsoft.WindowsCamera` · `Appx`.
- **What it is:** camera/webcam app.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose the built-in Camera app.
- **Current policy:** `optional` · default `No`.

##### Notepad

- **Identity:** `Microsoft.WindowsNotepad` · `Appx`.
- **What it is:** simple text editor.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You will need another text editor.
- **Current policy:** `optional` · default `No`.

##### Xbox Game Overlay

- **Identity:** `Microsoft.XboxGameOverlay` · `Appx`.
- **What it is:** part of the Xbox in-game overlay.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You may lose parts of Game Bar.
- **Current policy:** `optional` · default `No`.

##### Xbox Gaming Overlay

- **Identity:** `Microsoft.XboxGamingOverlay` · `Appx`.
- **What it is:** Xbox Game Bar.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You may lose Game Bar, captures and Xbox widgets.
- **Current policy:** `optional` · default `No`.

##### Phone Link

- **Identity:** `Microsoft.YourPhone` · `Appx`.
- **What it is:** PC-to-phone integration.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose phone integration.
- **Current policy:** `optional` · default `No`.

##### Media Player

- **Identity:** `Microsoft.ZuneMusic` · `Appx`.
- **What it is:** media player.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You will need another media player.
- **Current policy:** `optional` · default `No`.

##### Cross Device Experience

- **Identity:** `MicrosoftWindows.CrossDevice` · `Appx`.
- **What it is:** cross-device features.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Windows Web Experience Pack

- **Identity:** `MicrosoftWindows.Client.WebExperience` · `Appx`.
- **What it is:** web components used by Widgets and other Windows surfaces.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** This can affect Widgets and other Windows surfaces.
- **Current policy:** `optional` · default `No`.

##### Widgets Platform Runtime

- **Identity:** `Microsoft.WidgetsPlatformRuntime` · `Appx`.
- **What it is:** runtime needed by Widgets.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** Widgets may stop working.
- **Current policy:** `optional` · default `No`.

##### LG Monitor App

- **Identity:** `LGElectronics.LGMonitorApp` · `Appx`.
- **What it is:** LG monitor utilities.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP AI Experience Center

- **Identity:** `AD2F1837.HPAIExperienceCenter` · `Appx`.
- **What it is:** HP AI features.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Connected Music

- **Identity:** `AD2F1837.HPConnectedMusic` · `Appx`.
- **What it is:** old HP media app.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Connected Photo

- **Identity:** `AD2F1837.HPConnectedPhotopoweredbySnapfish` · `Appx`.
- **What it is:** old HP photo app.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Desktop Support Utilities

- **Identity:** `AD2F1837.HPDesktopSupportUtilities` · `Appx`.
- **What it is:** HP support utilities.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Easy Clean

- **Identity:** `AD2F1837.HPEasyClean` · `Appx`.
- **What it is:** temporary input lock for cleaning the PC.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP File Viewer

- **Identity:** `AD2F1837.HPFileViewer` · `Appx`.
- **What it is:** HP file viewer.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP JumpStarts

- **Identity:** `AD2F1837.HPJumpStarts` · `Appx`.
- **What it is:** HP welcome/promotional app.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP PC Hardware Diagnostics

- **Identity:** `AD2F1837.HPPCHardwareDiagnosticsWindows` · `Appx`.
- **What it is:** HP hardware diagnostics.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Power Manager

- **Identity:** `AD2F1837.HPPowerManager` · `Appx`.
- **What it is:** HP battery/power controls.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You may lose HP-specific battery/charging controls.
- **Current policy:** `optional` · default `No`.

##### HP Printer Control

- **Identity:** `AD2F1837.HPPrinterControl` · `Appx`.
- **What it is:** HP printer controls.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** If you use an HP printer, you may lose controls from this app.
- **Current policy:** `optional` · default `No`.

##### HP Privacy Settings

- **Identity:** `AD2F1837.HPPrivacySettings` · `Appx`.
- **What it is:** HP privacy settings.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP QuickDrop

- **Identity:** `AD2F1837.HPQuickDrop` · `Appx`.
- **What it is:** HP quick file transfer.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP QuickTouch

- **Identity:** `AD2F1837.HPQuickTouch` · `Appx`.
- **What it is:** quick features on some HP PCs.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Registration

- **Identity:** `AD2F1837.HPRegistration` · `Appx`.
- **What it is:** HP device registration.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Support Assistant

- **Identity:** `AD2F1837.HPSupportAssistant` · `Appx`.
- **What it is:** HP support, diagnostics and updates.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose HP’s support/update workflow; Windows Update still works.
- **Current policy:** `optional` · default `No`.

##### HP Sure Shield AI

- **Identity:** `AD2F1837.HPSureShieldAI` · `Appx`.
- **What it is:** supported HP security features.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP System Information

- **Identity:** `AD2F1837.HPSystemInformation` · `Appx`.
- **What it is:** HP system information.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP Welcome

- **Identity:** `AD2F1837.HPWelcome` · `Appx`.
- **What it is:** HP welcome screen.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### HP WorkWell

- **Identity:** `AD2F1837.HPWorkWell` · `Appx`.
- **What it is:** HP wellbeing tools.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### myHP

- **Identity:** `AD2F1837.myHP` · `Appx`.
- **What it is:** HP features/support dashboard.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Lenovo Vantage

- **Identity:** `E046963F.LenovoCompanion` · `Appx`.
- **What it is:** Lenovo settings, battery, firmware and support.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You may lose Lenovo battery, charging, thermal-mode or update controls.
- **Current policy:** `optional` · default `No`.

##### Lenovo Vantage Service

- **Identity:** `LenovoCompanyLimited.LenovoVantageService` · `Appx`.
- **What it is:** service required by several Lenovo Vantage features.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** Lenovo Vantage may stop working correctly.
- **Current policy:** `optional` · default `No`.

##### Dell SupportAssist

- **Identity:** `DellInc.DellSupportAssistforPCs` · `Appx`.
- **What it is:** Dell support, diagnostics and updates.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Additional warning:** You lose Dell’s support/diagnostic/update workflow; Windows Update still works.
- **Current policy:** `optional` · default `No`.

##### Dell Digital Delivery Services

- **Identity:** `DellInc.DellDigitalDelivery` · `Appx`.
- **What it is:** delivery of software bundled/purchased with Dell.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

##### Dell Mobile Connect

- **Identity:** `DellInc.DellMobileConnect` · `Appx`.
- **What it is:** Dell phone-to-PC integration.
- **Practical guidance:** Only if you know you do not need it. VSO7 does not select it automatically.
- **What may be lost:** Medium: you may lose a Windows/OEM feature you actually use.
- **Current policy:** `optional` · default `No`.

#### Not recommended (6)

##### Get Help

- **Identity:** `Microsoft.GetHelp` · `Appx`.
- **What it is:** Windows help/support.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** You lose the built-in support app.
- **Current policy:** `unsafe` · default `No`.

##### Microsoft Store

- **Identity:** `Microsoft.WindowsStore` · `Appx`.
- **What it is:** app store and app updating.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** This can make installing and updating Microsoft apps much less convenient.
- **Current policy:** `unsafe` · default `No`.

##### Windows Terminal

- **Identity:** `Microsoft.WindowsTerminal` · `Appx`.
- **What it is:** modern Windows terminal.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** You may lose the modern terminal used by PowerShell, CMD and development tools.
- **Current policy:** `unsafe` · default `No`.

##### Xbox TCUI Framework

- **Identity:** `Microsoft.Xbox.TCUI` · `Appx`.
- **What it is:** Xbox sign-in/interface components used by games.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** Some games may lose Xbox dialogs or features.
- **Current policy:** `unsafe` · default `No`.

##### Xbox Identity Provider

- **Identity:** `Microsoft.XboxIdentityProvider` · `Appx`.
- **What it is:** Xbox sign-in and identity.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** This can break Xbox sign-in, Game Pass and games that use Xbox identity.
- **Current policy:** `unsafe` · default `No`.

##### Xbox Speech To Text

- **Identity:** `Microsoft.XboxSpeechToTextOverlay` · `Appx`.
- **What it is:** Xbox voice/text features.
- **Practical guidance:** I would not remove it unless you know exactly what depends on it.
- **What may be lost:** High: removing it can break other apps or Windows features.
- **Additional warning:** This can break Xbox voice/accessibility features.
- **Current policy:** `unsafe` · default `No`.

## 17. Profiles (`14 → 9`)

Profiles are data-only JSON with no commands or scriptblocks. Export the latest selection, create by IDs, import/preview, or import/apply. Apply revalidates IDs, applicability, high risk, apps, and Recovery. A valid profile may not apply to another PC. Apps require `ELIMINAR APPS`.

## 18. Backgrounds and language

Backgrounds: Disabled, Plasma, Matrix Rain, Starfield, Rotating Galaxy, Tunnel, Kaleidoscope, Radio Waves, Rain Drops, Horizon, Fire, Flame Fire, Fireworks, Bouncing Balls, Spinning Donut, Spinning Shapes, and Random. Random is the new default; saved preference wins. `Ctrl+F` freezes/resumes at supported prompts.

English is the clean-install default. Spanish persists when selected. Some inherited tool strings may remain in one language without changing logic.

## 19. Common messages

- **No applicable pending items:** nothing pending meets policy/applicability; it may already be optimal.
- **OK:** satisfied state, not a pending action.
- **Already applied:** compatible Recovery already owns the change.
- **Recovery already owns target:** review/restore the bundle if state differs or is ambiguous.
- **Pending restart:** a structured signal exists; the message should identify it.
- **PendingAppRestart:** configuration verified, effective state awaits app restart.
- **AdapterRestart:** a short disconnect is possible.
- **Unknown:** VSO does not guess; automation excludes it.

## 20. Code map for an AI or maintainer

| Area | Main functions |
|---|---|
| Main menu | `Show-Menu` |
| Console automation | `Get-VSO7ConsoleAutomaticAppRowsVSO`, `Get-VSO7ConsoleAutomaticPlanVSO`, `Show-VSO7ConsoleAutomaticVSO` |
| Recommendation | `Test-VSO7RecommendationAutoCandidateVSO`, `Get-VSO7RecommendedOptimizationPlanVSO` |
| Objectives | `Select-VSO7RecommendedObjectiveVSO`, `Show-VSO7RecommendedOptimizationVSO` |
| Extreme | `Get-VSOExtremeTweaks`, `Show-ExtremeOptimizer` |
| GPU | `Show-VSO7GraphicsMenuVSO`, `Show-VSO7PerAppGraphicsMenuVSO`, `Show-VSO7GraphicsDiagnosticsVSO` |
| Windows | `Show-VSO7WindowsFeatures`, `Show-VSO7FeatureCategoryVSO`, `Show-VSO7GroupedWindowsChoicesVSO` |
| Apps | `Show-VSO7AppSelectorVSO`, `Show-VSO7ManualAppSelectorVSO` |
| Gaming | `Show-VSO7GamingSelector`, `Invoke-VSO7GamingSession` |
| Diagnostics | `Show-VSO7AdvancedTuningDiagnostics`, `Show-VSO7LatencyHardwareLabVSO` |
| Tools | `Show-SpecificTools`, `Show-VSO7SystemTools` |
| Profiles | `Show-VSO7ConfigurationProfilesVSO` |
| Security/Recovery | `Initialize-VSO7SecureStateStorage`, `Get-VSO7RecoveryAuthKeyVSO` |

An AI must use FeatureId/AppId as identity; distinguish selection, preview, preflight, apply, verification, and recovery; inspect policy and native JSON primitives; never infer performance from a name; respect restart, ownership, and drift; and fail closed on unknown evidence.

## 21. Current limitations

- GUI is not the supported public interface.
- Manual app recommendation checks 84 safe/default entries without inventory; automatic mode filters detected Appx.
- Some selectable features lack a global manual selector and enter through recommendation/profile.
- Diagnostics depend on Windows, firmware, and drivers; unavailable does not mean broken hardware.
- Apps, caches, and Special operations may not be reversible.
- A restore point does not replace a data backup.

