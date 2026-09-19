# VSO7 1.2.1 — Manual técnico de uso y referencia funcional

**Interfaz soportada:** consola  
**Fuente documentada:** `VSO7-current/VSO7.ps1`  
**Catálogos:** `VSO7_FEATURE_CATALOG.json`, `VSO7_NATIVE_TWEAKS.json` y `VSO7_APP_CATALOG.json`  
**Fecha:** 19 de septiembre de 2026

Este manual explica cómo usar VSO7, cómo llegar a cada familia de ajustes, qué modifica cada flujo y qué riesgos, consecuencias, reinicios y límites de recuperación existen. También está escrito para que otra IA pueda reconstruir el comportamiento de VSO7 en lenguaje humano sin deducirlo únicamente de nombres de funciones.

La fuente y los catálogos mandan si una versión posterior contradice este documento. Los números de menú pertenecen a VSO7 1.2.1.

## 1. Uso seguro

1. Extrae la carpeta completa del ZIP a una carpeta local.
2. Ejecuta `START VSO7.bat`. No abras `VSO7.ps1` directamente, dentro del ZIP ni desde una ruta de red.
3. Acepta UAC solo si tú has iniciado el launcher.
4. Entrar en un menú no aplica nada. La mutación comienza al elegir Apply/Aplicar y superar las confirmaciones.
5. `[X]` y `[A]` son selecciones pendientes. `[OK]` significa ya satisfecho o ya aplicado; no es una selección que vaya a repetirse.
6. No borres `C:\ProgramData\VicoreDevelopment\VSO7\Secrets`, `recovery-auth.key` ni Recovery para saltarte un error. La clave autentica backups existentes.
7. La eliminación de apps y las limpiezas no ofrecen la misma reversibilidad que un valor de Registro respaldado.
8. Reinicia o cierra sesión cuando VSO lo indique. Las operaciones de riesgo alto pueden bloquearse ante un reinicio pendiente real o un estado ambiguo.
9. Más agresivo no significa más rápido. Los niveles 3 y 4 solo tienen sentido para una necesidad concreta.

## 2. Inicio, consola y almacenamiento

El launcher verifica arquitectura e integridad, solicita una sola elevación y prefiere Windows Terminal. Si no está disponible, abre el host elevado en la consola clásica. En ConsoleHost clásico, seleccionar texto o desplazar el búfer puede pausar visualmente la animación; es comportamiento del host, no un bloqueo del motor.

VSO guarda `Logs` e `Informes` junto a la aplicación cuando puede demostrar que la carpeta local es escribible y segura. Configuración, estado, perfiles, Recovery, PresentMon administrado y secretos se guardan bajo `C:\ProgramData\VicoreDevelopment\VSO7`.

`Secrets\recovery-auth.key` es una clave aleatoria de 32 bytes usada para autenticar material de Recovery. Si una identidad externa puede escribir allí, o falta una clave de la que dependen backups, VSO falla cerrado y conserva el estado.

## 3. Cómo leer un selector

| Marca | Significado |
|---|---|
| `[ ]` | Disponible, no seleccionado. |
| `[X]` | Seleccionado manualmente, todavía no aplicado. |
| `[A]` | Seleccionado automáticamente, todavía no aplicado. |
| `[OK]` | Ya óptimo/satisfecho; se excluye de cambios pendientes. |
| `[ADMIN]` | Requiere contexto administrativo. |
| `[N/A]` | No aplicable a este equipo. |
| `[UNSUPPORTED]` | Build, edición, hardware o proveedor no soportado. |
| `[?]` | Estado no demostrable; la automatización lo excluye. |

Los niveles de riesgo son: **1 bajo**, **2 medio**, **3 alto** y **4 muy alto**. `Evidence` representa respaldo técnico; la automatización solo admite E1/E2. `Maturity` distingue Stable, Conditional, Experimental, Diagnostic y Deprecated. `AutoSelection=Eligible` permite considerar una feature; `Manual` exige decisión humana; `Never` prohíbe añadirla automáticamente.

La selección automática exige además: mutación seleccionable, no ser preferencia subjetiva, no reducir seguridad, riesgo máximo 2, objetivo coincidente, madurez Stable/Conditional, recomendación Recommended u Optional solicitada y aplicabilidad demostrable.

## 4. Rutas rápidas

| Objetivo | Ruta desde el menú principal |
|---|---|
| GPU global, HAGS y juegos en ventana | `13 → 13 → 1` |
| GPU/preferencia gráfica por ejecutable | `13 → 13 → 2` |
| Diagnóstico GPU/HAGS/MPO/HDR/topología | `13 → 13 → 3` |
| Ver GPU y driver | `14 → 1 → 11` |
| CPU y energía contextual | `13 → 12` |
| USB y energía | `13 → 9` |
| Topología CPU/P-E/SMT | `14 → 10 → 1` |
| Planes de energía | `14 → 1 → 6` |
| Tweaks de red | `13 → 10` |
| Diagnóstico NIC/Wi-Fi | `14 → 10 → 7` |
| Gateway, jitter y pérdida local | `14 → 10 → 8` |
| Privacidad, sugerencias e IA | `13 → 1` |
| Sistema, gaming y Windows Update | `13 → 2` |
| Inicio, búsqueda, barra y multitarea | `13 → 3` y `13 → 6` |
| Explorador y apariencia | `13 → 4` y `13 → 6` |
| Apps safe realmente detectadas | `13 → 7 → 1` |
| Catálogo manual de 140 apps | `13 → 7 → 2` |
| Xbox/HP OEM/Edge forzado | `13 → 8` |
| Inicio automático | `14 → 5` o `14 → 1 → 7` |
| Limpieza guiada | `14 → 7` o `14 → 1 → 16` |
| Extremos por riesgo | `10` |
| Sanity scan | `17` o `14 → 8` |
| Automático conjunto | `19` |
| Recovery | `12` |

## 5. Menú principal

| Nº | Opción | Al entrar | Qué hace y consecuencias |
|---:|---|---|---|
| 1 | VSO Score | Solo lectura | Resume estado y puntuación; puede guardar historial local. No es un benchmark de FPS. |
| 2 | Benchmark A/B | No muta al entrar | Baseline/post de CPU, DPC, interrupciones, contexto, disco, RAM y procesos; PresentMon es opcional. Escribe informes. |
| 3 | Análisis rápido | Solo lectura | Windows, CPU, RAM, GPU, disco, batería, energía, Game Mode, captura, apariencia e inicio. |
| 4 | Optimización recomendada | No | Plan por objetivo y aplicabilidad, preview, optional elegibles, explicación, apply y restauración de la última sesión. |
| 5 | Optimización segura | No | Selector de Game Mode, captura y temporales; las tres empiezan marcadas. |
| 6 | Gaming temporal | No | Juego a prioridad High, procesos elegidos a BelowNormal y High performance opcional; restaura al cerrar el juego. |
| 7 | Gaming permanente | No | Game Mode, captura, plan reversible y temporales. Cambios persistentes/limpieza al aplicar. |
| 8 | Equilibrada | No | Preset bajo/medio; muestra todo y exige `EQUILIBRADO`. Puede quedar parcial si un paso posterior falla. |
| 9 | Agresiva controlada | No | Añade transparencia/animaciones y exige `AGRESIVO`. No toca Defender, Firewall, VBS, BCD/HPET, pagefile, HAGS, BitLocker existente ni Update. |
| 10 | Extrema | No | 31 tweaks por riesgo, detalle, Dry Run, Apply y revertir. Incluye cambios irreversibles y de seguridad. |
| 11 | Punto de restauración | Pregunta | Comprueba/crea checkpoint solo tras confirmación. |
| 12 | Revertir/Recovery | No hasta elegir | Restaura cambios registrados respetando ownership y drift externo. |
| 13 | Windows/Debloat | No | Catálogo nativo: privacidad, Windows, CPU, red, GPU, apps y opciones especiales. |
| 14 | Herramientas | No | Hardware, TRIM, almacenamiento, startup, overlays, limpieza, perfiles y laboratorio. |
| 15 | Abrir carpeta | Abre Explorer | No modifica configuración. |
| 16 | Idioma/apariencia | Solo VSO | Guarda idioma y fondo animado; Random es default nuevo, la preferencia previa prevalece. |
| 17 | Sanity scan | Solo lectura | BCD, MMCSS, red, memoria, scheduler, interrupciones, USB y energía; no autocorrige. |
| 18 | Diagnóstico explicado | Solo lectura | Contexto y recomendaciones. Las filas OK no son cambios pendientes. |
| 19 | Automático tweaks+apps | No | Plan editable; tweaks primero. Si esa fase falla/parcial, no elimina apps. |
| 0 | Salir | No | Cierra sin cambios adicionales. |

## 6. Automatización y objetivos

Los objetivos son Balanced, Performance, Gaming, Responsiveness y PowerEfficiency. Privacy existe como dominio pero es manual. Ningún objetivo hereda otro y Balanced no es un fallback universal.

El motor ordena por FeatureId; excluye diagnósticos, experimentales, preferencias, seguridad reducida y policy Manual/Never; exige coincidencia de objetivo y aplicabilidad; separa AlreadyOptimal; resuelve conflictos y dependencias; y conserva los IDs revisados entre confirmación y ejecución.

«No hay recomendaciones automáticas pendientes» puede significar que todo elegible ya está `[OK]`, que el objetivo no coincide, que son preferencias/manuales o que el hardware/estado no aplica. No significa que la sección esté vacía.

La opción 4 trabaja solo con features. La 19 combina features y apps detectadas. Seleccionar, recalcular o Dry Run no aplica nada.

## 7. Opción 13 — Windows/Debloat

| Submenú | Contenido | Consecuencia |
|---:|---|---|
| 1 | Privacidad, sugerencias e IA | Telemetría, ads, ubicación, Copilot, Recall, Click to Do y AI; privacidad es decisión manual. |
| 2 | Sistema, gaming y Update | Captura, Fast Startup, Storage Sense y políticas de Update; puede alterar mantenimiento/comodidad. |
| 3 | Inicio, barra y multitarea | Principalmente preferencias visuales y de flujo, no rendimiento objetivo. |
| 4 | Explorador y apariencia | Extensiones, ocultos, inicio del Explorador, panel, transparencias y animaciones. |
| 5 | Features opcionales y otros | Sandbox, WSL y terceros; puede requerir reinicio/virtualización. |
| 6 | Nueve selectores exclusivos | Evita aplicar variantes incompatibles simultáneamente. |
| 7 | Apps | Automático detectado o manual de 140 entradas; reinstalación no garantizada. |
| 8 | Special/OEM | Xbox/Game Bar, HP OEM y Edge forzado; alto/muy alto riesgo. |
| 9 | Power & USB | Suspensión selectiva USB revisada. |
| 10 | Network | RSS/RSC/offloads/autotuning/energía NIC; algunos reinician el adaptador. |
| 11 | Diagnostics/remediation | Corrección revisada de un override MMCSS concreto. |
| 12 | CPU & Power | Boost, EPP, máximo CPU, refrigeración, throttling y ASPM según hardware/AC/DC. |
| 13 | Graphics & GPU | Global, por app y diagnóstico. |

En un selector de categoría, `R` reemplaza las marcas por las recomendaciones de esa sección; `O` cambia el objetivo del próximo cálculo conservando las marcas; `X` limpia. Aplicar vuelve a comprobar aplicabilidad, muestra los IDs, confirma alto riesgo y exige Recovery.

### Elección única (`13 → 6`)

1. Spotlight: on, on sin icono o off.
2. Alt+Tab: 0, 3, 5 o 20 pestañas.
3. Búsqueda de taskbar: oculta, icono, icono+texto o cuadro.
4. Agrupación barra principal: siempre, al llenarse o nunca.
5. Agrupación barras secundarias: siempre, al llenarse o nunca.
6. Multi-monitor: todas, principal+monitor activo o solo su monitor.
7. Explorador: Home, This PC, Downloads u OneDrive.
8. Letras de unidad: antes, después, primero en red u ocultas.
9. All apps: categorías, cuadrícula o lista si la build lo soporta.

### Apps (`13 → 7`)

`13 → 7 → 1` inventaría Appx instaladas para todos los usuarios y aprovisionadas una sola vez. Solo propone entradas `safe`, `SelectedByDefault=true`, método Appx y detectadas. WinGet y removers especiales permanecen manuales.

`13 → 7 → 2` muestra las 140 entradas, 12 por página. `B` busca aproximadamente, texto libre también busca y `P3` salta de página. “Select recommended removals” marca las **84** entradas safe/default del catálogo **sin filtrar antes por instalación**. Antes de eliminar muestra todo, avisa de unsafe, exige `ELIMINAR APPS` y punto de restauración. Recovery no garantiza reinstalación.

## 8. GPU

`13 → 13 → 1` expone optimizaciones globales en ventana y HAGS solo si la build/soporte permite considerarlas. HAGS puede requerir reinicio. VSO separa estado configurado de efectivo y no promete FPS por un valor de Registro.

`13 → 13 → 2` elige un EXE: Windows decide elimina `GpuPreference`; ahorro usa valor 1; alto rendimiento usa 2; windowed ON usa `SwapEffectUpgradeEnable=1`; OFF se bloquea ante token Auto HDR incompatible; reset elimina solo el token objetivo. Otros tokens se preservan. La configuración se verifica inmediatamente, el efecto queda `PendingAppRestart`.

`13 → 13 → 3` lee PnP/PCI, DXCore, DXGI, topología híbrida, tearing, HAGS, DisplayConfig, Hz, DRR, HDR/WCG y MPO. PnP/PCI/path/EDID son identidad persistente; LUID/source/target son de sesión. HDR/WCG/VRR/Auto HDR/Auto SR/MPO permanecen diagnóstico; no aplica Disable MPO.

## 9. CPU, energía, USB y red

`13 → 12` evita presets universales de CPU mínima al 100 %. Distingue sobremesa/portátil y AC/batería para máximo CPU, Power Throttling, EPP, boost, refrigeración y PCIe. Performance puede aumentar consumo, temperatura y ruido; eficiencia puede reducir respuesta/boost.

`13 → 9` restaura suspensión selectiva USB cuando procede. Deshabilitarla solo debe probarse ante un periférico problemático y aparece como extremo riesgo 3.

`14 → 1 → 6` gestiona planes sin sustituir OEM/custom. Para High performance VSO debe guardar y restaurar el GUID original.

`13 → 10` usa adaptadores físicos y capacidades del driver. Restaurar RSS/offloads/autotuning corrige tweak packs indiscriminados. Desactivar RSC/interrupt moderation es prueba manual de latencia y puede aumentar CPU o reducir throughput. Reiniciar NIC causa corte breve. Wake-on-LAN es preferencia. `14 → 10 → 7/8` diagnostica NIC/Wi-Fi y red local; no confunde LAN con ISP.

## 10. Gaming

Game Mode puede aparecer en varios flujos. Si ya está aplicado y pertenece a Recovery compatible, VSO lo trata como AlreadyApplied y conserva el rollback. Ownership diferente/ambiguo bloquea.

Desactivar captura limita Game DVR/AppCapture, pero no necesariamente herramientas externas.

El modo temporal no inicia juegos desde el proceso elevado. El usuario abre el juego; VSO revalida PID, ruta, hora y prioridad; pone el juego en High, fondos elegidos en BelowNormal y opcionalmente High performance. Al cerrar, restaura solo aquello que aún posee. Si queda incompleto, conserva estado para reintentar.

El modo permanente aplica Game Mode, captura, plan reversible y limpieza sin monitorizar el cierre de un juego.

## 11. Herramientas y laboratorio

`14`: (1) herramientas específicas; (2) hardware/TRIM/drivers solo lectura; (3) almacenamiento; (4) historial; (5) startup con rollback; (6) cerrar overlays sin cambiar autoarranque; (7) limpieza guiada; (8) Sanity; (9) perfiles JSON; (10) laboratorio.

`14 → 1`: Game Mode; captura; transparencia; animaciones; temporales >7 días; planes; startup; CPU/RAM por proceso; salud Windows; RAM; GPU/driver; página gráfica; almacenamiento; extrema; overlays; limpieza guiada.

`14 → 10`: topología CPU; DPC/ISR; MSI/MSI-X y afinidad; USB; salud de discos; drivers; NIC/Wi-Fi; calidad local; audio/input; firmware/dependencias; QoS/DSCP. Todo es diagnóstico. DPC/ISR sin ETW no atribuye un driver, y DSCP no reduce ping si la red no lo respeta.

## 12. Benchmark

Opción 2: (1) baseline 10 s; (2) post y HTML; (3) medición aislada; (4) última comparación; (5) FPS baseline 60 s; (6) FPS post y lows; (7) gestor de PresentMon. PresentMon solo se descarga tras acción explícita y verificación. Las condiciones A/B deben ser comparables; menos CPU de fondo no demuestra automáticamente más FPS o menor input lag.

## 13. Recovery y reinicios

Antes de una mutación reversible VSO registra baseline e intención, escribe y relee. Al restaurar comprueba que el estado actual aún coincide con el aplicado; si hay drift evita pisar cambios externos. Un lote puede detenerse en el primer error con pasos anteriores ya aplicados: revisar Applied, Failed, RollbackStatus, bundle y log.

La detección de reinicio pendiente reconoce CBS, Windows Update, UpdateExeVolatile no nulo, cambio de nombre y renombrados de archivo poblados. Un PendingFileRenameOperations vacío se ignora. Evidencia ilegible/ambigua bloquea alto riesgo.

## 14. Extrema

Los 31 elementos son toggles. Los controles siguientes seleccionan riesgo 1, hasta 2, hasta 3 o todo; limpian; muestran detalle; simulan; aplican; o revierten. Un umbral de riesgo no es una recomendación.

| Nº | ID | Tweak | Riesgo | Reinicio | Recovery | Efecto/consecuencia |
|---:|---|---|---|---|---|---|
| 1 | `gaming.gamemode` | Activar Modo de juego | 1 · Bajo | No | Reversible | Activa el modo Juego de Windows. |
| 2 | `gaming.gamedvr` | Desactivar Game DVR/captura en segundo plano | 1 · Bajo | No | Reversible | Reduce captura en segundo plano; pierdes funciones de grabacion de Windows. |
| 3 | `ui.transparency` | Desactivar transparencias | 1 · Bajo | No | Reversible | Reduce efectos visuales de la interfaz. |
| 4 | `ui.animations` | Reducir animaciones/efectos visuales | 1 · Bajo | Sí | Reversible | Usa el preset visual de mejor rendimiento y desactiva animacion de ventanas; cambia la estetica. |
| 5 | `delivery.p2p` | Delivery Optimization sin P2P | 1 · Bajo | No | Reversible | DownloadMode=0: HTTP sin peering; Windows Update sigue funcionando. |
| 6 | `cleanup.temp` | Limpiar temporales > 7 dias | 1 · Bajo | No | No reversible | Borra temporales antiguos, omitiendo archivos bloqueados. |
| 7 | `cleanup.shaders` | Limpiar caches de shaders NVIDIA/DirectX | 1 · Bajo | No | No reversible | Se regeneran; puede haber microstutter inicial. |
| 8 | `cleanup.dev` | Limpiar caches npm/pip | 1 · Bajo | No | No reversible | Solo caches descargables de desarrollo. |
| 9 | `cleanup.vscode` | Limpiar caches de VS Code/Insiders | 1 · Bajo | No | No reversible | Cache, GPUCache, CachedData y VSIX cache; no User. |
| 10 | `cleanup.spotify` | Vaciar LocalCache de Spotify Store | 1 · Bajo | No | No reversible | No borra LocalState. |
| 11 | `cleanup.lghub` | Vaciar cache de Logitech G HUB | 1 · Bajo | No | No reversible | No toca depots/current.json/next.json. |
| 12 | `cleanup.winsxs` | DISM StartComponentCleanup (sin ResetBase) | 1 · Bajo | No | No reversible | Metodo soportado por Microsoft para componentes sustituidos. |
| 13 | `power.hibernate` | Desactivar hibernacion | 2 · Medio | No | Reversible | Libera hiberfil.sys; desactiva hibernacion/Inicio rapido asociado. |
| 14 | `search.indexing` | Desactivar Windows Search/indexacion | 2 · Medio | No | Reversible | Menos I/O de indexacion; busquedas pueden ser mas lentas. |
| 15 | `xbox.services` | Desactivar servicios Xbox clasicos | 2 · Medio | No | Reversible | Puede afectar Xbox app/Game Pass/funciones Xbox. |
| 16 | `telemetry.diagtrack` | Desactivar Connected User Experiences/DiagTrack | 2 · Medio | No | Reversible | Reduce telemetria/diagnostico en segundo plano; puede limitar datos de diagnostico. |
| 17 | `power.usbSuspend` | Desactivar suspension selectiva USB (experimental) | 3 · Alto | No | Reversible | Puede ayudar a perifericos con problemas, pero Microsoft recomienda mantener selective suspend en uso general; aumenta consumo. |
| 18 | `power.pcieAspm` | PCIe Link State Power Management OFF (experimental) | 3 · Alto | No | Reversible | Reduce ahorro PCIe; beneficio de rendimiento no garantizado y aumenta consumo. |
| 19 | `cleanup.fortnite` | Borrar PersistentDownloadDir de Fortnite | 2 · Medio | No | No reversible | Fortnite volvera a descargar contenido cuando lo necesite. |
| 20 | `cleanup.bobby` | Borrar cache .minecraft/.bobby | 2 · Medio | No | No reversible | NO toca logs, crash-reports, saves, Xaero ni JourneyMap. |
| 21 | `cleanup.dumps` | Limpiar crash dumps antiguos | 2 · Medio | No | No reversible | Borra .dmp antiguos; pierdes diagnostico de esos fallos. |
| 22 | `services.spooler` | Desactivar cola de impresion | 3 · Alto | No | Reversible | Rompe impresion mientras este desactivada. |
| 23 | `services.location` | Desactivar servicio de ubicacion | 3 · Alto | No | Reversible | Apps que usan ubicacion pueden dejar de funcionar correctamente. |
| 24 | `services.bluetooth` | Desactivar servicio Bluetooth | 3 · Alto | No | Reversible | Rompe perifericos Bluetooth mientras este desactivado. |
| 25 | `virtualization.hyperv` | Desactivar hipervisor Hyper-V | 3 · Alto | Sí | Reversible | Puede romper Hyper-V, Docker, emuladores y virtualizacion dependiente. |
| 26 | `virtualization.wsl` | Desactivar WSL + Virtual Machine Platform | 3 · Alto | Sí | Reversible | Rompe WSL2 y normalmente Docker Desktop con backend WSL. |
| 27 | `virtualization.sandbox` | Desactivar Windows Sandbox | 3 · Alto | Sí | Reversible | Quita la caracteristica Windows Sandbox. |
| 28 | `security.memoryIntegrity` | Desactivar Memory Integrity / HVCI | 4 · Muy alto | Sí | Reversible | REDUCE SEGURIDAD DEL KERNEL. Solo seleccion manual/consciente. |
| 29 | `security.credentialGuard` | Desactivar Credential Guard (sin UEFI lock) | 4 · Muy alto | Sí | Reversible | REDUCE PROTECCION DE CREDENCIALES. Si hay UEFI lock VSO7 se niega. |
| 30 | `security.vbs` | Desactivar VBS base | 4 · Muy alto | Sí | Reversible | REDUCE AISLAMIENTO BASADO EN VIRTUALIZACION. |
| 31 | `virtualization.hypervisorLaunchOff` | BCD hypervisorlaunchtype OFF | 4 · Muy alto | Sí | Reversible | Impide arrancar el hipervisor de Windows; rompe VBS/Hyper-V/WSL2 dependiente. |

Los cuatro riesgo 4 reducen aislamiento/seguridad o impiden el hipervisor. Hyper-V/WSL/Sandbox afectan Docker, emuladores y WSL2. Spooler, ubicación y Bluetooth rompen esas funciones mientras estén deshabilitados.

## 15. Catálogo completo

Los anexos siguientes se generan estáticamente desde los JSON de esta build. `Selectable=true` no garantiza una pantalla manual dedicada. Algunas features Storage se alcanzan por recomendación, perfiles o flujos especializados.

**VSO7.ps1 SHA-256:** `D88F46386C73A5694DFA457DB0744987FE3C64CC4F1236223A03CAF042A116FA`

| Categoría | Ruta | Total | Seleccionables | Mutaciones | Eligible | Manual | Never |
|---|---|---:|---:|---:|---:|---:|---:|
| AI | 13 → 1 | 7 | 7 | 7 | 0 | 7 | 0 |
| Appearance | 13 → 4 | 6 | 3 | 0 | 0 | 0 | 6 |
| Audio | 14 → 10 → 9 | 1 | 0 | 0 | 0 | 0 | 1 |
| Benchmark & Diagnostics | 2; 14 → 10 | 2 | 0 | 0 | 0 | 0 | 2 |
| CPU & Power | 13 → 12 | 12 | 12 | 12 | 6 | 6 | 0 |
| Diagnostics | 13 → 11 | 2 | 1 | 1 | 0 | 1 | 1 |
| Drivers | 14 → 2 o 14 → 10 → 6 | 1 | 0 | 0 | 0 | 0 | 1 |
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
| Services | 14 → 10 → 10; mutaciones en 10 | 1 | 0 | 0 | 0 | 0 | 1 |
| Special | 13 → 8 | 8 | 3 | 3 | 0 | 3 | 5 |
| Start Menu & Search | 13 → 3 | 12 | 6 | 0 | 0 | 0 | 12 |
| Storage | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | 9 | 8 | 8 | 2 | 6 | 1 |
| System | 13 → 2 | 8 | 8 | 8 | 0 | 7 | 1 |
| Taskbar | 13 → 3 | 19 | 6 | 0 | 0 | 0 | 19 |
| USB & HID | 14 → 10 → 4; 17 | 2 | 0 | 0 | 0 | 0 | 2 |
| Wi-Fi | 14 → 10 → 7 | 1 | 0 | 0 | 0 | 0 | 1 |
| Windows Update | 13 → 2 | 4 | 4 | 4 | 0 | 4 | 0 |

### Referencia detallada de las 183 features

#### AI (7)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7AI001` | Desactivar Microsoft Copilot / Disable Copilot | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva la integracion de Copilot en Windows. No desinstala aplicaciones de terceros. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (3 operación/es) |
| `V7AI002` | Desactivar Windows Recall / Disable Recall | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva Recall para evitar que Windows use esa funcion de historial/capturas asistidas por IA. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (5 operación/es) |
| `V7AI003` | Desactivar Click to Do / Disable Click To Do | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva el analisis contextual de texto e imagenes de Click to Do. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7AI004` | Evitar inicio automatico del servicio de IA / Disable AI Service Auto Start | 13 → 1 | Mutation | 2 · Medio | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Impide que el servicio de IA configurado por Windows se inicie automaticamente; algunas funciones de IA pueden dejar de funcionar. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7AI005` | Desactivar funciones de IA de Edge / Disable Edge AI | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva varias funciones de IA integradas en Microsoft Edge. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (8 operación/es) |
| `V7AI006` | Desactivar funciones de IA de Paint / Disable Paint AI | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva funciones de IA de Paint cuando Windows las expone mediante estas politicas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (5 operación/es) |
| `V7AI007` | Desactivar funciones de IA del Bloc de notas / Disable Notepad AI | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva funciones de IA del Bloc de notas cuando estan disponibles. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### Appearance (6)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7UI001` | Activar Windows Spotlight en el escritorio / Enable Desktop Spotlight | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Activa los fondos rotatorios de Spotlight y su acceso informativo en el escritorio. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7UI002` | Desactivar Windows Spotlight del escritorio / Disable Desktop Spotlight | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Evita que Windows cambie automaticamente el fondo del escritorio mediante Spotlight. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7UI003` | Ocultar el icono de Spotlight / Hide Desktop Spotlight Icon | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Mantiene Spotlight pero oculta el acceso "Mas informacion sobre esta imagen" del escritorio. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7UI004` | Activar modo oscuro / Enable Dark Mode | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Activa el tema oscuro para Windows y aplicaciones compatibles. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7UI005` | Desactivar transparencias / Disable Transparency | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reduce efectos translucidos de Windows. Es un cambio visual reversible. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7UI006` | Reducir animaciones y efectos visuales / Disable Animations | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Desactiva varias animaciones para que la interfaz se sienta mas inmediata. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### Audio (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7AU001` | Contexto de latencia de audio / Audio device/driver latency context | 14 → 10 → 9 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Inventaria dispositivos/controladores de audio y muestra DPC/ISR solo como contexto; la atribucion por driver requiere ETW. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: audio PnP, driver version, signature, DPC/ISR context | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Benchmark & Diagnostics (2)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7BM001` | Metricas de frame PresentMon ampliadas / Extended PresentMon frame metrics | 2; 14 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Anade frametime P95 junto a FPS medio, lows 1%/0.1%, P99 y P99.9 usando el flujo PresentMon verificado existente. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: P95 frametime, P99 frametime, 1% low, 0.1% low | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7BM002` | Veredicto A/B con margen de ruido / Noise-gated A/B verdict | 2; 14 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E2 · Auto=Never | Diagnostics | None | Clasifica una comparacion PresentMon como Improved/Regressed/Inconclusive solo cuando varias metricas superan umbrales conservadores. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: AvgFPS gate, 1% low gate, P99 frame-time gate | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### CPU & Power (12)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableActiveCoolingOnAcLaptop` | Priorizar refrigeracion activa en AC/laptop / Prefer active cooling on AC laptop | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E2 · Auto=Eligible | Performance, Gaming | None | Establece System Cooling Policy=Active solo en AC de portatiles si el setting existe, preservando DC. Puede aumentar ruido para contener temperatura antes de reducir rendimiento. Interacciones: No todos los OEM exponen o respetan este setting; si no existe, VSO7 lo marca Not Applicable. Medición: fan behavior, CPU temperature, sustained clocks | Administrador=sí; Tipo de equipo=Laptop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"SYSCOOLPOL","RequireACDifferentFrom":1} | Ninguna declarada | PowerSetting; sin Undo declarativo; revisar motor |
| `EnableProcessorBoostModeOnAcDesktop` | Habilitar boost de CPU en AC si estaba desactivado / Enable CPU boost on AC when it was disabled | 13 → 12 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | En un PC de escritorio, cambia PERFBOOSTMODE de Disabled a Enabled solo para AC del plan activo. DC se preserva y no se usa Aggressive. Interacciones: Puede aumentar consumo, temperatura y ruido. Solo aparece cuando el ajuste existe y AC está explícitamente en Disabled. Medición: CPU frequency/boost residency under the target workload, temperature and package power, frametime/FPS A/B | Administrador=sí; Comandos=["powercfg.exe"]; Tipo de equipo=["Desktop"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFBOOSTMODE","RequireACEquals":0} | Ninguna declarada | PowerSetting; sin Undo declarativo; revisar motor |
| `RestoreMaxProcessorStateOnAcDesktop` | Restaurar maximo CPU al 100 % en AC/desktop / Restore 100% CPU maximum on AC desktop | 13 → 12 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, Gaming, Responsiveness | None | Restaura PROCTHROTTLEMAX a 100 % solo en AC y solo en desktop cuando un plan lo limita por debajo de 100. Conserva DC exactamente. Interacciones: Puede aumentar temperatura/consumo frente a un limite intencional. No toca minimo CPU ni boost agresivo. Medición: sustained clocks, CPU package power, temperature | Administrador=sí; Tipo de equipo=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PROCTHROTTLEMAX","RequireACBelow":100} | Ninguna declarada | PowerSetting; sin Undo declarativo; revisar motor |
| `RestorePowerThrottlingToUserControl` | Restaurar Power Throttling a control normal / Restore normal Power Throttling control | 13 → 12 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, PowerEfficiency | None | Elimina PowerThrottlingOff=1 cuando una policy/tweak lo desactivo globalmente. Devuelve a Windows y al usuario el control normal; no promete mas FPS. Interacciones: Policy ADMX documentada. Puede reducir consumo de procesos en segundo plano. Medición: background CPU/power use | Administrador=sí; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling","Name":"PowerThrottlingOff","NumericMin":1,"NumericMax":1} | Ninguna declarada | Registry; sin Undo declarativo; revisar motor |
| `SetProcessorEppBalancedOnAcDesktop` | EPP equilibrado en AC/desktop / Balanced EPP on AC desktop | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Establece PERFEPP=50 en AC/desktop como punto equilibrado explicito. Es una preferencia de trade-off, no un boost FPS universal. Interacciones: Preserva DC. Medición: CPU package power, responsiveness | Administrador=sí; Tipo de equipo=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":50} | Grupo exclusivo: ProcessorEppAc | PowerSetting; sin Undo declarativo; revisar motor |
| `SetProcessorEppEfficiencyOnBatteryLaptop` | EPP eficiente en bateria/laptop / Efficiency-oriented EPP on laptop battery | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Establece PERFEPP=80 solo en DC de portatiles cuando el setting existe, preservando AC. Favorece autonomia/temperatura frente a rendimiento pico. Interacciones: No se aplica a desktop. Medición: battery drain, temperature, responsiveness | Administrador=sí; Tipo de equipo=Laptop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireDCDifferentFrom":80} | Grupo exclusivo: ProcessorEppDc | PowerSetting; sin Undo declarativo; revisar motor |
| `SetProcessorEppPerformanceOnAcDesktop` | EPP orientado a rendimiento en AC/desktop / Performance-oriented EPP on AC desktop | 13 → 12 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Establece PERFEPP=0 solo en AC/desktop cuando el setting existe. Favorece rendimiento sobre ahorro; no se recomienda automaticamente y debe medirse con temperatura/consumo. Interacciones: EPP es efectivo principalmente en CPPC v2 con modo autonomo. Hardware/firmware puede modular el resultado. Medición: frametime A/B, CPU package power, temperature, boost residency | Administrador=sí; Tipo de equipo=Desktop; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":0} | Grupo exclusivo: ProcessorEppAc | PowerSetting; sin Undo declarativo; revisar motor |
| `V7PW101` | EPP equilibrado en AC para portatil / Balanced EPP on AC laptop | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Establece EPP=50 solo en AC para un portatil. Windows documenta 0 como rendimiento y 100 como ahorro; 50 es un equilibrio, no una promesa gaming. Medición: CPU package power, temperature, frametimes | Administrador=sí; Tipo de equipo=["Laptop"]; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":50} | Grupo exclusivo: V7LaptopAcEpp | PowerSetting; sin Undo declarativo; revisar motor |
| `V7PW102` | EPP rendimiento en AC para portatil / Performance-oriented EPP on AC laptop | 13 → 12 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Establece EPP=20 solo en AC para favorecer rendimiento sin forzar 0. Puede aumentar consumo, temperatura y ruido; medir antes/despues. Medición: CPU package power, temperature, frametimes | Administrador=sí; Tipo de equipo=["Laptop"]; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFEPP","RequireACDifferentFrom":20} | Grupo exclusivo: V7LaptopAcEpp | PowerSetting; sin Undo declarativo; revisar motor |
| `V7PW103` | Desactivar boost de CPU en bateria / Disable CPU boost on battery | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Desactiva Processor Performance Boost Mode solo en DC para reducir consumo/temperatura en portatil. AC se conserva exactamente. Medición: battery discharge rate, temperature, battery workload latency | Administrador=sí; Tipo de equipo=["Laptop"]; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PROCESSOR","SettingAlias":"PERFBOOSTMODE","RequireDCDifferentFrom":0} | Grupo exclusivo: V7LaptopDcBoost | PowerSetting; sin Undo declarativo; revisar motor |
| `V7PW104` | PCIe ASPM moderado en bateria / Moderate PCIe ASPM on battery | 13 → 12 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | None | Configura ASPM=1 solo en DC para un portatil. Es un trade-off de energia/latencia y no se aplica en AC. Medición: battery discharge rate, device latency/stability | Administrador=sí; Tipo de equipo=["Laptop"]; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PCIEXPRESS","SettingAlias":"ASPM","RequireDCDifferentFrom":1} | Grupo exclusivo: V7LaptopDcAspm | PowerSetting; sin Undo declarativo; revisar motor |
| `V7PW105` | PCIe ASPM maximo en bateria / Maximum PCIe ASPM on battery | 13 → 12 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness, PowerEfficiency | None | Configura ASPM=2 solo en DC para maximizar ahorro de enlace PCIe. Puede aumentar latencia de salida de estados de ahorro; probar segun hardware. Medición: battery discharge rate, device latency/stability | Administrador=sí; Tipo de equipo=["Laptop"]; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_PCIEXPRESS","SettingAlias":"ASPM","RequireDCDifferentFrom":2} | Grupo exclusivo: V7LaptopDcAspm | PowerSetting; sin Undo declarativo; revisar motor |

#### Diagnostics (2)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `NormalizeClampedSystemResponsivenessOverride` | Normalizar override MMCSS <10 a 20 / Normalize clamped MMCSS override below 10 to 20 | 13 → 11 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Diagnostics | None | Cuando SystemResponsiveness existe con un valor 0-9, lo normaliza explícitamente a 20. Windows documenta que 0-9 ya se clampa a 20, por lo que esta remediación alinea valor configurado y efectivo sin prometer más rendimiento. El rollback restaura exactamente el DWORD anterior. Interacciones: No es un tweak de rendimiento: antes y después el valor efectivo documentado es 20. Medición: compare configured value with documented effective MMCSS value before and after | Administrador=sí; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile","Name":"SystemResponsiveness","NumericMin":0,"NumericMax":9} | Grupo exclusivo: SystemResponsivenessOverride | Registry; sin Undo declarativo; revisar motor |
| `V7DI201` | Modelo Partial para multiples targets / Multi-target Partial state model | 13 → 11 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Agrega estados por target sin confundir mezcla Baseline/Applied con Drift. Error/Ambiguous/Drift explicitos mantienen precedencia. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: Baseline, Applied, Partial, Drift, PendingRestart | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Drivers (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7DR001` | Inventario asesor de controladores / Driver advisor inventory | 14 → 2 o 14 → 10 → 6 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Inventaria controladores firmados GPU/red/audio/storage/USB/sistema con version/fecha/proveedor; no afirma que exista uno mas nuevo. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: driver version, driver date, provider, signature | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### File Explorer (20)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7FE001` | Abrir Explorador en Inicio / Explorer To Home | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que nuevas ventanas del Explorador abran la pagina Inicio. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7FE002` | Abrir Explorador en Este equipo / Explorer To This PC | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que nuevas ventanas del Explorador muestren unidades y carpetas de Este equipo. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE003` | Abrir Explorador en Descargas / Explorer To Downloads | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que el Explorador abra directamente la carpeta Descargas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE004` | Abrir Explorador en OneDrive / Explorer To One Drive | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que el Explorador abra OneDrive por defecto; requiere que OneDrive este configurado. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE005` | Mostrar extensiones de archivo / Show Known File Extensions | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra .exe, .txt, .jpg y otras extensiones conocidas; ayuda a identificar mejor los archivos. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE006` | Mostrar archivos y carpetas ocultos / Show Hidden Folders | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace visibles elementos marcados como ocultos en el Explorador. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE007` | Ocultar unidades extraibles duplicadas / Hide Dupli Drive | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Evita que ciertas unidades USB aparezcan duplicadas en el panel de navegacion. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE008` | Ocultar Inicio del Explorador / Hide Home | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita Inicio/Home del panel de navegacion del Explorador. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (11 operación/es) |
| `V7FE009` | Ocultar Galeria del Explorador / Hide Gallery | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita Galeria del panel de navegacion. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (10 operación/es) |
| `V7FE010` | Ocultar OneDrive del Explorador / Hide OneDrive | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta OneDrive del panel de navegacion; no desinstala el cliente ni borra archivos. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (10 operación/es) |
| `V7FE011` | Ocultar carpeta Objetos 3D / Hide3d Objects | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita la carpeta Objetos 3D de Este equipo. | Sin condición declarada | Ninguna declarada | Registry; sin Undo declarativo; revisar motor |
| `V7FE012` | Ocultar carpeta Musica / Hide Music | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita Musica de Este equipo/panel segun la version de Windows. | Sin condición declarada | Grupo exclusivo: V7ExplorerMusicNamespace | Registry; sin Undo declarativo; revisar motor |
| `V7FE013` | Añadir carpetas comunes a Este equipo / Add Folders To This PC | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Vuelve a mostrar carpetas comunes como Documentos/Descargas en Este equipo. | Sin condición declarada | Grupo exclusivo: V7ExplorerMusicNamespace | Registry; rollback declarativo (13 operación/es) |
| `V7FE014` | Ocultar Incluir en biblioteca / Hide Include In Library | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita esa entrada del menu contextual del Explorador. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7FE015` | Ocultar Dar acceso a / Hide Give Access To | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita la entrada de compartir mediante "Dar acceso a" del menu contextual. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (8 operación/es) |
| `V7FE016` | Ocultar Compartir / Hide Share | 13 → 4 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita la entrada Compartir del menu contextual moderno. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE017` | Mostrar letra de unidad antes del nombre / Show Drive Letters First | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | En el Explorador, muestra C:, D:, etc. antes de la etiqueta de la unidad. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE018` | Mostrar letra de unidad despues del nombre / Show Drive Letters Last | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Mantiene la letra visible, pero despues de la etiqueta. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7FE019` | Mostrar primero letras de unidades de red / Show Network Drive Letters First | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Prioriza la letra antes del nombre en unidades de red. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7FE020` | Ocultar letras de unidad / Hide Drive Letters | 13 → 4 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta C:, D:, etc. en la interfaz del Explorador; las rutas y unidades siguen existiendo. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### Firmware (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7FW001` | Inventario BIOS/UEFI / BIOS/UEFI inventory | 14 → 10 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Muestra identidad de firmware/sistema y Secure Boot cuando es consultable. R9 no muta firmware. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: BIOS version, release date, Secure Boot | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Gaming (8)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisableBackgroundGameCapturePerUser` | Desactivar capturas de juego por usuario / Disable per-user background game capture | 13 → 2 | Mutation | 1 · Bajo | Optional · Conditional · E2 · Auto=Manual | Gaming | AppRestart | Desactiva AppCapture/GameDVR para el usuario actual sin crear una policy de equipo ni tocar protocolos ms-gamebar. Es una preferencia reversible, no una promesa de FPS. Interacciones: No desinstala Game Bar. Algunas apps/juegos deben reiniciarse para observar el cambio. Medición: capture/background recording behavior | RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\System\\GameConfigStore","Name":"GameDVR_Enabled","Value":0,"Kind":"DWord"},{"Path":"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\GameDVR","Name":"AppCaptureEnabled","Value":0,"Kind":"DWord"}] | Ninguna declarada | Registry; sin Undo declarativo; revisar motor |
| `RestoreGameRecordingPolicyToUserControl` | Restaurar control de grabacion al usuario / Restore game recording policy to user control | 13 → 2 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Gaming, Performance | AppRestart | Elimina un override AllowGameDVR=0 impuesto por policy para devolver el control a Windows/usuario. No activa capturas por si mismo y restaura exactamente el valor previo al hacer rollback. Interacciones: La policy esta documentada por Microsoft. Solo aplica si el DWORD existe y vale 0. Medición: Game Bar recording availability after app restart | Administrador=sí; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\GameDVR","Name":"AllowGameDVR","NumericMin":0,"NumericMax":0} | Conflicta: V7GM001 | Registry; sin Undo declarativo; revisar motor |
| `V7GM001` | Desactivar captura/grabacion de juegos (legacy) / Disable game capture/recording (legacy) | 13 → 2 | Mutation | 1 · Bajo | Advanced · Conditional · E1 · Auto=Manual | Gaming, Performance | AppRestart | Desactiva captura/grabacion de juegos. VSO7 conserva esta variante avanzada por compatibilidad funcional, pero recomienda la variante por usuario porque esta tambien escribe una policy de equipo. Interacciones: La policy AllowGameDVR puede impedir que el usuario reactive capturas desde Settings. Prefiere DisableBackgroundGameCapturePerUser salvo que quieras imponer una policy. Medición: Game Bar capture availability before/after | Administrador=sí | Conflicta: RestoreGameRecordingPolicyToUserControl | Registry; rollback declarativo (3 operación/es) |
| `V7GM002` | Desactivar integracion de Barra de juegos / Disable Game Bar Integration | 13 → 2 | Diagnostic | 2 · Medio | NotRecommended · Deprecated · E5 · Auto=Never | Gaming, Performance | None | Compatibilidad VSO7 legacy que redirige protocolos ms-gamebar mediante HKCR. No se ofrece para nuevas aplicaciones porque es demasiado invasiva y no es necesaria para desactivar capturas. Interacciones: Se conserva unicamente para reconocer/restaurar estados VSO7 prerelease; no se ofrece como tweak nuevo. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (9 operación/es) |
| `V7GM101` | Activar Game Mode / Enable Game Mode | 13 → 2 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Gaming | AppRestart | Activa la preferencia oficial de Game Mode. No promete mas FPS; Windows decide la optimizacion efectiva segun juego, hardware y scheduler. Medición: A/B game frametimes, 1% lows, background CPU activity | Build mínimo=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"AutoGameModeEnabled","Value":1,"Kind":"DWord"}] | Grupo exclusivo: V7GameMode | Registry; sin Undo declarativo; revisar motor |
| `V7GM102` | Desactivar Game Mode para prueba A/B / Disable Game Mode for A/B testing | 13 → 2 | Mutation | 1 · Bajo | Experimental · Experimental · E1 · Auto=Never | Gaming, Performance | AppRestart | Desactiva Game Mode de forma reversible para comparar un juego concreto. No es una recomendacion universal. Medición: A/B game frametimes, 1% lows, background CPU activity | Build mínimo=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"AutoGameModeEnabled","Value":0,"Kind":"DWord"}] | Grupo exclusivo: V7GameMode | Registry; sin Undo declarativo; revisar motor |
| `V7GM103` | Permitir abrir Game Bar con mando / Allow controller to open Game Bar | 13 → 2 | Mutation | 1 · Bajo | Optional · Stable · E1 · Auto=Manual | Preferences | None | Activa la preferencia oficial que permite abrir Game Bar con el boton del mando. Es una preferencia de UX, no un tweak de rendimiento. | Build mínimo=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"UseNexusForGameBarEnabled","Value":1,"Kind":"DWord"}] | Grupo exclusivo: V7ControllerGameBar | Registry; sin Undo declarativo; revisar motor |
| `V7GM104` | Bloquear apertura de Game Bar con mando / Block controller from opening Game Bar | 13 → 2 | Mutation | 1 · Bajo | Optional · Stable · E1 · Auto=Manual | Preferences | None | Desactiva de forma reversible la apertura de Game Bar mediante el boton del mando. Solo cambia comportamiento de entrada/UX. | Build mínimo=22000; RegistryAnyDifferent=[{"Path":"HKEY_CURRENT_USER\\Software\\Microsoft\\GameBar","Name":"UseNexusForGameBarEnabled","Value":0,"Kind":"DWord"}] | Grupo exclusivo: V7ControllerGameBar | Registry; sin Undo declarativo; revisar motor |

#### Graphics & GPU (7)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7GP001` | Activar optimizaciones para juegos en ventana / Enable optimizations for windowed games | 13 → 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Performance | AppRestart | Configura de forma reversible la preferencia Windows de optimizaciones para juegos en ventana. El read-back demuestra ConfigurationVerification; el estado efectivo queda PendingAppRestart. El almacenamiento de Settings se trata como contrato condicional hasta smoke test nativo. Interacciones: Auto HDR puede forzar estas optimizaciones. Reinicia la app/juego para evaluar estado efectivo; VSO7 conserva tokens no poseidos. Medición: DX10/DX11 windowed/borderless frame latency, Present mode, app restart | Build mínimo=22621; GraphicsGlobalWindowedDesired=sí | Grupo exclusivo: V7WindowedGamesGlobal | Special; recuperación especializada o no garantizada |
| `V7GP002` | Desactivar optimizaciones para juegos en ventana (A/B) / Disable optimizations for windowed games (A/B) | 13 → 13 → 1 | Mutation | 2 · Medio | Experimental · Conditional · E3 · Auto=Never | Performance | AppRestart | Configura el override global reversible para A/B. El read-back solo verifica configuracion; EffectiveVerification queda PendingAppRestart. Se bloquea con Auto HDR presente y el mecanismo de almacenamiento permanece condicional hasta smoke test nativo. Interacciones: Auto HDR puede forzar estas optimizaciones. Reinicia la app/juego para evaluar estado efectivo; VSO7 conserva tokens no poseidos. Medición: A/B frame latency, Present mode, compatibility regressions | Build mínimo=22621; GraphicsGlobalWindowedDesired=no | Grupo exclusivo: V7WindowedGamesGlobal | Special; recuperación especializada o no garantizada |
| `V7GP003` | Activar HAGS si el soporte esta verificado / Enable HAGS when support is verified | 13 → 13 → 1 | Mutation | 2 · Medio | Optional · Conditional · E2 · Auto=Manual | Performance, Gaming | SystemRestart | HAGS solo se muta cuando dxdiag produce un agregado Stable no ambiguo por adaptador. El write/read-back prueba configuracion; EffectiveVerification queda PendingReboot hasta una comprobacion posterior al reinicio. Interacciones: Estados Stable mezclados Enabled/Disabled, Experimental o Unknown bloquean la mutacion. AlwaysOff junto a un Stable coherente no invalida por si solo el sistema. Medición: post-reboot HAGS effective state, frame-time consistency, GPU scheduling regressions | Build mínimo=19041; Administrador=sí; Comandos=["dxdiag.exe"]; HagsSupported=sí; HagsDesiredEnabled=sí | Grupo exclusivo: V7HagsMode | Special; recuperación especializada o no garantizada |
| `V7GP004` | Desactivar HAGS (A/B) si el soporte esta verificado / Disable HAGS (A/B) when support is verified | 13 → 13 → 1 | Mutation | 2 · Medio | Experimental · Experimental · E2 · Auto=Never | Performance | SystemRestart | HAGS solo se muta cuando dxdiag produce un agregado Stable no ambiguo por adaptador. El write/read-back prueba configuracion; EffectiveVerification queda PendingReboot hasta una comprobacion posterior al reinicio. Interacciones: Estados Stable mezclados Enabled/Disabled, Experimental o Unknown bloquean la mutacion. AlwaysOff junto a un Stable coherente no invalida por si solo el sistema. Medición: post-reboot HAGS effective state, VR/frame-time comparison, regression testing | Build mínimo=19041; Administrador=sí; Comandos=["dxdiag.exe"]; HagsSupported=sí; HagsDesiredEnabled=no | Grupo exclusivo: V7HagsMode | Special; recuperación especializada o no garantizada |
| `V7GP101` | Diagnostico nativo de topologia GPU / Native GPU topology diagnostic | 13 → 13 → 1 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Combina DXCore, DXGI, PnP y correlacion LUID manteniendo identidad persistente separada de la identidad de sesion. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: DXCore, DXGI, PnP, LUID correlation | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7GP102` | Diagnostico HDR/WCG/DRR por pantalla / Per-display HDR/WCG/DRR diagnostic | 13 → 13 → 1 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Muestra targets activos separando soporte/usuario/activo de HDR y WCG y el estado Dynamic Refresh Rate. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: HDR support/user/active, WCG support/user/active, ActiveColorMode, DRR | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7GP103` | Diagnostico de identidad grafica persistente/runtime / Graphics persistent/runtime identity diagnostic | 13 → 13 → 1 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Muestra evidencia de identidad persistente/runtime usada para correlacionar GPUs y pantallas, fallando cerrado ante ambiguedad. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: PnP, VEN/DEV/SUBSYS, monitor device path, EDID validity, runtime LUID | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Input (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7IN001` | Diagnostico de preferencias de raton y teclado / Mouse and keyboard preference diagnostic | 14 → 10 → 9 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Lee aceleracion/sensibilidad de raton y repeticion de teclado y los clasifica como preferencias, no como latencia medida. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: mouse thresholds, sensitivity, keyboard delay, keyboard speed | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Latency & Interrupts (5)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7LT001` | Resumen DPC/ISR del sistema / DPC/ISR system overview | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Muestrea contadores de rendimiento de Windows para actividad DPC/ISR sin afirmar latencia de entrada directa ni atribucion por driver. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: DPC average/max, ISR average/max, interrupt rate, ETW readiness | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7LT002` | Topologia CPU y clases heterogeneas / CPU topology and heterogeneous classes | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Enumera CPU Sets de Windows, grupos, cores, SMT y EfficiencyClass/SchedulingClass cuando el sistema los expone. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: processor groups, EfficiencyClass, SchedulingClass, parked CPU sets | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7LT003` | Inventario de politica de interrupciones / Interrupt policy inventory | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Lee overrides explicitos de politica de interrupciones y distingue ausencia/herencia de una configuracion explicita. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: MSI override, MessageNumberLimit, affinity policy, assignment mask | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7LT004` | Inventario MSI/MSI-X de NIC / NIC MSI/MSI-X capability inventory | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Usa el proveedor de hardware NetAdapter de Windows para mostrar soporte/estado MSI/MSI-X, mensajes y NUMA de adaptadores de red. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: MsiSupported, MsiEnabled, MsiXSupported, MsiXEnabled, NUMA | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7LT005` | Preparacion ETW DPC/ISR / ETW DPC/ISR trace readiness | 14 → 10 → 2/3; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Indica si estan disponibles componentes de trazado de Windows para investigar DPC/ISR; no inventa atribucion por driver. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: WPR availability, xperf availability, trace-required attribution | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Multi-tasking (7)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7MT001` | Desactivar ajuste de ventanas / Disable Window Snapping | 13 → 3 | Preference | 2 · Medio | Optional · Conditional · E3 · Auto=Never | Preferences | None | Desactiva la funcion de acoplar ventanas a bordes y zonas de la pantalla. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7MT002` | Desactivar sugerencias al acoplar ventanas / Disable Snap Assist | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Mantiene otras funciones de ventanas pero evita que Windows sugiera apps para completar un diseño. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7MT003` | Ocultar diseños de acoplamiento / Disable Snap Layouts | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta el panel de diseños que aparece al pasar por maximizar o en la parte superior. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7MT004` | No mostrar pestanas en Alt+Tab / Hide Tabs In Alt Tab | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que Alt+Tab muestre ventanas y no pestanas recientes de aplicaciones compatibles. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7MT005` | Mostrar 3 pestanas en Alt+Tab / Show3 Tabs In Alt Tab | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configura Alt+Tab para incluir hasta tres pestanas recientes de aplicaciones compatibles. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7MT006` | Mostrar 5 pestanas en Alt+Tab / Show5 Tabs In Alt Tab | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configura Alt+Tab para incluir hasta cinco pestanas recientes. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7MT007` | Mostrar 20 pestanas en Alt+Tab / Show20 Tabs In Alt Tab | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Configura Alt+Tab para incluir muchas pestanas recientes; puede hacer el selector mas cargado. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |

#### Network (26)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisablePhysicalNicInterruptModerationForLowLatency` | Desactivar moderación para prueba de baja latencia / Disable interrupt moderation for a low-latency test | 13 → 10 | Mutation | 2 · Medio | Advanced · Conditional · E2 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Desactiva interrupt moderation únicamente donde el driver publica la keyword estandarizada, para A/B en cargas sensibles a latencia. Interacciones: Microsoft documenta que la moderación puede aumentar RTT percibido. Desactivarla aumenta interrupciones y puede empeorar CPU/throughput. Medición: application RTT/frametime A/B, interrupt/DPC rate, CPU utilization | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*InterruptModeration","RegistryValue":"0"}]} | Conflicta: EnablePhysicalNicInterruptModeration; Grupo exclusivo: InterruptModerationPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `DisablePhysicalNicRscForLowLatency` | Desactivar RSC para prueba de baja latencia / Disable RSC for a measured low-latency test | 13 → 10 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Desactiva RSC IPv4/IPv6 solo en NIC físicas compatibles para una prueba A/B de baja latencia. No es recomendación universal. Interacciones: Solo tiene sentido si una carga de baja latencia y bajo throughput demuestra mejora. Puede aumentar CPU y reducir throughput. Medición: application RTT/frametime A/B, receive throughput, CPU utilization | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*RscIPv4","RegistryValue":"0"},{"RegistryKeyword":"*RscIPv6","RegistryValue":"0"}]} | Conflicta: RestorePhysicalNicRsc; Grupo exclusivo: PhysicalRscPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `EnablePhysicalNicInterruptModeration` | Activar moderación de interrupciones / Enable interrupt moderation | 13 → 10 | Mutation | 2 · Medio | Optional · Conditional · E1 · Auto=Manual | Performance | AdapterRestart | Activa la keyword NDIS estandarizada de interrupt moderation solo cuando el driver la expone. Reduce interrupciones y carga de CPU a cambio de posible latencia añadida. Interacciones: Es la opción orientada a eficiencia/throughput; no es automáticamente mejor para una carga de latencia estricta. Medición: interrupt/DPC rate, CPU utilization, application latency A/B | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*InterruptModeration","RegistryValue":"1"}]} | Conflicta: DisablePhysicalNicInterruptModerationForLowLatency; Grupo exclusivo: InterruptModerationPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `EnablePhysicalNicRss` | Activar RSS en NIC física compatible / Enable RSS on a supported physical NIC | 13 → 10 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Activa RSS únicamente en NIC físicas activas y compatibles, identificadas por InterfaceGuid/PnP y verificadas después del cambio. RSS distribuye la recepción entre CPU; no promete menor ping. Si RSS global del stack está desactivado, conviene restaurarlo primero. Interacciones: Puede reiniciar brevemente la NIC. R3 guarda InterfaceGuid y PnPDeviceID; backups R2 conservan una ruta legacy fail-closed por descripción. Medición: throughput under receive load, CPU utilization during receive load, game/network latency A/B if that is the target workload | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterRss","Enable-NetAdapterRss","Disable-NetAdapterRss"]; PhysicalRssDisabledRequired=sí | Ninguna declarada | NetAdapterRss; sin Undo declarativo; revisar motor |
| `EnableTcpEcnForTesting` | Activar ECN para prueba A/B / Enable TCP ECN for A/B testing | 13 → 10 | Mutation | 2 · Medio | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Activa ECN en perfiles TCP configurables como prueba avanzada en redes que realmente soportan ECN. No entra en recomendaciones automaticas. Interacciones: El beneficio depende del camino de red y congestion. Medir A/B. Medición: loss under congestion, latency under congestion, throughput | Administrador=sí; Comandos=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"EcnCapability","Value":"Enabled","AllowedSourceValues":["Disabled"]} | Grupo exclusivo: TcpEcn | NetTcpSetting; sin Undo declarativo; revisar motor |
| `EnableWakeOnMagicPacketPhysicalNics` | Activar Wake-on-Magic-Packet compatible / Enable supported Wake-on-Magic-Packet | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | AdapterRestart | Activa WakeOnMagicPacket solo en NIC fisicas que Windows reporta como compatibles. Guarda identidad InterfaceGuid/PnP y baseline por adaptador. Interacciones: VSO7 escribe con -NoRestart y marca Effective=PendingRestart para no cortar conectividad automaticamente. Medición: Wake-on-LAN test after adapter/system restart | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"WakeOnMagicPacket","Value":"Enabled","OnlyUp":false} | Ninguna declarada | NetAdapterPower; sin Undo declarativo; revisar motor |
| `EnableWakeOnPatternPhysicalNics` | Activar Wake-on-Pattern compatible / Enable supported Wake-on-Pattern | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | AdapterRestart | Activa WakeOnPattern solo en NIC fisicas que Windows reporta como compatibles. Puede despertar el equipo por patrones distintos al Magic Packet, por lo que es una preferencia de wake, no rendimiento. Interacciones: Se configura con -NoRestart y queda PendingRestart. Medición: sleep/wake behavior | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"WakeOnPattern","Value":"Enabled","OnlyUp":false} | Ninguna declarada | NetAdapterPower; sin Undo declarativo; revisar motor |
| `RestoreGlobalReceiveSegmentCoalescing` | Restaurar RSC global del stack TCP/IP / Restore global TCP/IP RSC | 13 → 10 | Mutation | 1 · Bajo | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Activa Receive Segment Coalescing global cuando estaba desactivado. Favorece eficiencia/throughput y no garantiza menor latencia. Interacciones: El estado global no sustituye a la capability RSC de cada NIC. Medición: receive throughput, CPU utilization, latency A/B | Administrador=sí; Comandos=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"ReceiveSegmentCoalescing","Value":"Enabled"} | Ninguna declarada | NetOffloadGlobal; sin Undo declarativo; revisar motor |
| `RestoreGlobalReceiveSideScaling` | Restaurar RSS global del stack TCP/IP / Restore global TCP/IP RSS | 13 → 10 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance, Gaming | None | Activa Receive Side Scaling a nivel global del stack de red cuando estaba desactivado. Es independiente del estado RSS de cada NIC. Interacciones: RSS global y RSS de NIC son capas distintas; tras restaurar el global, revisa también la feature física si procede. Medición: receive throughput, per-core CPU distribution under receive load | Administrador=sí; Comandos=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"ReceiveSideScaling","Value":"Enabled"} | Ninguna declarada | NetOffloadGlobal; sin Undo declarativo; revisar motor |
| `RestoreGlobalTaskOffload` | Restaurar task offload global / Restore global task offload | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E2 · Auto=Eligible | Performance, Responsiveness | AdapterRestart | Vuelve a habilitar el offload global TCP/IP si fue desactivado. La lectura posterior confirma el valor configurado, pero Microsoft documenta que TaskOffload se hace efectivo tras reiniciar el adaptador o el equipo. Interacciones: Configured puede quedar Enabled mientras Effective permanece PendingRestart. VSO7 no reinicia automaticamente todas las NIC para evitar cortar conectividad. Medición: CPU utilization under network load, throughput | Administrador=sí; Comandos=["Get-NetOffloadGlobalSetting","Set-NetOffloadGlobalSetting"]; NetOffloadGlobal={"Property":"TaskOffload","Value":"Enabled"} | Ninguna declarada | NetOffloadGlobal; sin Undo declarativo; revisar motor |
| `RestoreNicSelectiveSuspendOnLaptops` | Restaurar selective suspend de NIC en laptop / Restore NIC selective suspend on laptops | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | AdapterRestart | Habilita selective suspend solo en NIC fisicas de portatiles que lo soportan y lo tienen desactivado. Es ahorro energetico capability-based, no una optimizacion de ping. Interacciones: Se configura con -NoRestart y queda PendingRestart. Medición: idle battery drain, network resume behavior | Administrador=sí; Tipo de equipo=Laptop; Comandos=["Get-NetAdapter","Get-NetAdapterPowerManagement","Set-NetAdapterPowerManagement"]; NetAdapterPowerManagement={"Property":"SelectiveSuspend","Value":"Enabled","OnlyUp":false} | Ninguna declarada | NetAdapterPower; sin Undo declarativo; revisar motor |
| `RestorePhysicalNicChecksumOffloads` | Restaurar checksum offloads de NIC física / Restore physical NIC checksum offloads | 13 → 10 | Mutation | 2 · Medio | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | AdapterRestart | Restaura Rx+Tx en las descargas de checksum IPv4/TCP/UDP que la NIC física expone mediante keywords NDIS estandarizadas. No crea claves ausentes. Interacciones: Microsoft recomienda mantener checksum offload activado; VSO7 solo toca propiedades que el driver publica con el valor permitido. Puede reiniciar brevemente la NIC. Medición: throughput and CPU utilization under network load, driver error counters before/after | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*IPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*TCPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*UDPChecksumOffloadIPv4","RegistryValue":"3"},{"RegistryKeyword":"*TCPChecksumOffloadIPv6","RegistryValue":"3"},{"RegistryKeyword":"*UDPChecksumOffloadIPv6","RegistryValue":"3"}]} | Ninguna declarada | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `RestorePhysicalNicEee` | Restaurar Energy Efficient Ethernet / Restore Energy Efficient Ethernet | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Eligible | PowerEfficiency | AdapterRestart | Activa únicamente la keyword NDIS estandarizada *EEE donde el driver la expone y admite Enabled. No toca variantes vendor-specific de Green Ethernet. Interacciones: Es una función de ahorro energético, no un boost de FPS. VSO7 no asume que desactivarla reduzca ping. Medición: idle power consumption, network stability/latency A/B if troubleshooting | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*EEE","RegistryValue":"1"}]} | Conflicta: V7NW204; Grupo exclusivo: V7EeePolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `RestorePhysicalNicLso` | Restaurar Large Send Offload (LSO) / Restore Large Send Offload (LSO) | 13 → 10 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Activa LSO v2 IPv4/IPv6 solo donde el driver lo expone y admite Enabled. Reduce trabajo de segmentación en CPU; no se presenta como tweak de ping. Interacciones: LSO favorece eficiencia/throughput en muchas cargas, pero una carga de latencia concreta debe medirse A/B. Medición: throughput, CPU utilization under transmit-heavy load, latency A/B if latency is the target workload | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*LsoV2IPv4","RegistryValue":"1"},{"RegistryKeyword":"*LsoV2IPv6","RegistryValue":"1"}]} | Ninguna declarada | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `RestorePhysicalNicRsc` | Restaurar RSC en NIC física / Restore RSC on physical NICs | 13 → 10 | Mutation | 2 · Medio | Advanced · Conditional · E1 · Auto=Manual | Performance, Responsiveness | AdapterRestart | Activa RSC IPv4/IPv6 únicamente en NIC físicas que lo publican. RSC reduce procesamiento de cabeceras y favorece throughput de recepción. Interacciones: Microsoft indica que RSC puede afectar latencia y que cargas de baja latencia/bajo throughput pueden beneficiarse de desactivarlo. Medición: receive throughput, CPU utilization, latency A/B for low-latency workloads | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*RscIPv4","RegistryValue":"1"},{"RegistryKeyword":"*RscIPv6","RegistryValue":"1"}]} | Conflicta: DisablePhysicalNicRscForLowLatency; Grupo exclusivo: PhysicalRscPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `RestoreTcpAutoTuningNormal` | Restaurar TCP receive autotuning Normal / Restore TCP receive autotuning to Normal | 13 → 10 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | None | Normaliza AutoTuningLevelLocal a Normal únicamente en perfiles TCP con overrides restrictivos: Disabled, HighlyRestricted o Restricted. Experimental se deja intacto y se reporta por separado. Interacciones: No modifica Experimental. Normal es el estado general documentado; cualquier perfil agresivo requiere revisión separada. Medición: TCP throughput over high-bandwidth/high-latency paths, Get-NetTCPSetting before/after | Administrador=sí; Comandos=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"AutoTuningLevelLocal","Value":"Normal","AllowedSourceValues":["Disabled","HighlyRestricted","Restricted"]} | Ninguna declarada | NetTcpSetting; sin Undo declarativo; revisar motor |
| `RestoreTcpEcnDefaultDisabled` | Restaurar ECN a Disabled / Restore TCP ECN to Disabled | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Restaura EcnCapability=Disabled en perfiles TCP donde fue activado explicitamente. Disabled es el estado general observado/documentado; una red ECN-aware puede justificar la feature experimental opuesta. Interacciones: No promete menor ping. Medición: packet loss/congestion behavior, throughput | Administrador=sí; Comandos=["Get-NetTCPSetting","Set-NetTCPSetting"]; NetTcpSetting={"Property":"EcnCapability","Value":"Disabled","AllowedSourceValues":["Enabled"]} | Grupo exclusivo: TcpEcn | NetTcpSetting; sin Undo declarativo; revisar motor |
| `RestoreTcpTimestampsAllowed` | Restaurar TCP timestamps a Allowed / Restore TCP timestamps to Allowed | 13 → 10 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Performance, Responsiveness | None | Normaliza Timestamps a Allowed en perfiles con un override Enabled/Disabled. Windows documenta Allowed como comportamiento predeterminado: acepta timestamps entrantes cuando el peer los soporta sin forzarlos universalmente. Interacciones: Usa MSFT_NetTCPSetting porque Set-NetTCPSetting en PS5.1 solo admite Enabled/Disabled; Allowed=2 se valida mediante CIM. Afecta conexiones TCP nuevas; no reescribe conexiones ya establecidas. Medición: MSFT_NetTCPSetting.Timestamps before/after, new TCP connections | Administrador=sí; Comandos=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Allowed","AllowedSourceValues":["Enabled","Disabled"]} | Grupo exclusivo: V7TcpTimestampMode | NetTcpCimSetting; sin Undo declarativo; revisar motor |
| `V7NW101` | Forzar TCP timestamps para prueba A/B / Force TCP timestamps for A/B testing | 13 → 10 | Mutation | 2 · Medio | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Cambia Timestamps mediante MSFT_NetTCPSetting, no mediante un valor que Set-NetTCPSetting de PS5.1 rechaza. Es experimental y debe medirse con conexiones nuevas. Medición: new-connection throughput, packet traces, CPU/network latency | Administrador=sí; Comandos=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Enabled","AllowedSourceValues":["Allowed","Disabled"]} | Grupo exclusivo: V7TcpTimestampMode | NetTcpCimSetting; sin Undo declarativo; revisar motor |
| `V7NW102` | Desactivar TCP timestamps para prueba A/B / Disable TCP timestamps for A/B testing | 13 → 10 | Mutation | 2 · Medio | Experimental · Experimental · E3 · Auto=Never | Performance, Responsiveness | None | Cambia Timestamps mediante MSFT_NetTCPSetting, no mediante un valor que Set-NetTCPSetting de PS5.1 rechaza. Es experimental y debe medirse con conexiones nuevas. Medición: new-connection throughput, packet traces, CPU/network latency | Administrador=sí; Comandos=["Get-CimInstance","Set-CimInstance"]; NetTcpCimSetting={"Property":"Timestamps","Value":"Disabled","AllowedSourceValues":["Allowed","Enabled"]} | Grupo exclusivo: V7TcpTimestampMode | NetTcpCimSetting; sin Undo declarativo; revisar motor |
| `V7NW201` | Diagnostico de calidad de red local / Local network quality diagnostic | 13 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Mide ping/perdida/jitter al gateway y velocidad de enlace para separar problemas LAN de Internet/servidor de juego. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: gateway latency, jitter, packet loss, link speed | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7NW202` | Inventario de politicas QoS/DSCP / QoS/DSCP active policy inventory | 13 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Lee politicas QoS activas, incluido matching por aplicacion y DSCP, sin afirmar que DSCP reduzca el ping. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: AppPathNameMatchCondition, DSCPAction, ActiveStore | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7NW203` | Inventario de capacidades de driver NIC / NIC driver capability inventory | 13 → 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Enumera propiedades avanzadas expuestas por el driver mediante RegistryKeyword y los valores validos anunciados por el propio driver. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: RegistryKeyword, ValidRegistryValues, current value | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7NW204` | Desactivar Energy Efficient Ethernet para prueba A/B / Disable Energy Efficient Ethernet for A/B testing | 13 → 10 | Mutation | 2 · Medio | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Desactiva unicamente la keyword NDIS estandarizada *EEE donde el driver expone y acepta Disabled. No toca variantes vendor-specific y no promete menor ping. Interacciones: Puede aumentar consumo. Se recomienda medir estabilidad/latencia y restaurar si no mejora. Medición: latency/jitter A/B, idle power, link stability | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*EEE","RegistryValue":"0"}]} | Conflicta: RestorePhysicalNicEee; Grupo exclusivo: V7EeePolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `V7NW205` | Desactivar Large Send Offload para prueba A/B / Disable Large Send Offload for A/B testing | 13 → 10 | Mutation | 2 · Medio | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Desactiva LSO v2 IPv4/IPv6 solo donde el driver expone las keywords estandarizadas. Puede aumentar uso de CPU; no es una recomendacion universal. Interacciones: LSO suele mejorar eficiencia/throughput. Solo usar como A/B en una carga concreta y medir CPU, throughput y latencia. Medición: CPU utilization, throughput, latency/jitter A/B | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*LsoV2IPv4","RegistryValue":"0"},{"RegistryKeyword":"*LsoV2IPv6","RegistryValue":"0"}]} | Conflicta: RestorePhysicalNicLso; Grupo exclusivo: V7LsoPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |
| `V7NW206` | Desactivar checksum offloads para prueba A/B / Disable checksum offloads for A/B testing | 13 → 10 | Mutation | 3 · Alto | Experimental · Experimental · E1 · Auto=Never | Performance, Responsiveness | AdapterRestart | Desactiva Rx/Tx checksum offload mediante keywords NDIS estandarizadas solo cuando el driver acepta Disabled. Microsoft normalmente recomienda mantener offloads; esto es experimental. Interacciones: Puede empeorar CPU/throughput y no se recomienda por defecto. VSO7 preserva baseline por NIC y reinicia solo adapters afectados. Medición: CPU utilization, throughput, packet errors, latency A/B | Administrador=sí; Comandos=["Get-NetAdapter","Get-NetAdapterAdvancedProperty","Set-NetAdapterAdvancedProperty","Restart-NetAdapter"]; NetAdapterAdvancedProperties={"Properties":[{"RegistryKeyword":"*IPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*TCPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*UDPChecksumOffloadIPv4","RegistryValue":"0"},{"RegistryKeyword":"*TCPChecksumOffloadIPv6","RegistryValue":"0"},{"RegistryKeyword":"*UDPChecksumOffloadIPv6","RegistryValue":"0"}]} | Conflicta: RestorePhysicalNicChecksumOffloads; Grupo exclusivo: V7ChecksumOffloadPolicy | NetAdapterAdvanced; sin Undo declarativo; revisar motor |

#### Optional Windows Features (2)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7OF001` | Activar Windows Sandbox / Enable Windows Sandbox | 13 → 5 | Mutation | 3 · Alto | Advanced · Conditional · E3 · Auto=Manual | System | SystemRestart | Habilita la caracteristica opcional Sandbox. Puede requerir reinicio y virtualizacion compatible. | Administrador=sí; Módulos=["Dism"]; Features opcionales=["Containers-DisposableClientVM"] | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7OF002` | Activar WSL / Enable Windows Subsystem For Linux | 13 → 5 | Mutation | 3 · Alto | Advanced · Conditional · E3 · Auto=Manual | System | SystemRestart | Habilita WSL y Virtual Machine Platform. Puede requerir reinicio y cambia las caracteristicas opcionales instaladas. | Administrador=sí; Módulos=["Dism"]; Features opcionales=["VirtualMachinePlatform","Microsoft-Windows-Subsystem-Linux"] | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Other (2)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7OT001` | Ocultar Inicio de Configuracion / Disable Settings Home | 13 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | General | None | Hace que Configuracion no use la pagina Home/Inicio promocional como entrada principal. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7OT002` | Desactivar extras de Brave / Disable Brave Bloat | 13 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | General | None | Desactiva varias funciones promocionales de Brave, como componentes de IA/cripto, segun la version instalada. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### Power & USB (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableUsbSelectiveSuspend` | Restaurar suspensión selectiva USB / Restore USB selective suspend | 13 → 9 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, PowerEfficiency | None | Activa la suspensión selectiva USB en AC y DC del plan de energía activo cuando estaba desactivada. Microsoft recomienda no deshabilitarla globalmente; VSO7 conserva el valor real anterior y no la presenta como mejora de FPS. Interacciones: El comportamiento efectivo también depende del controlador y del dispositivo USB. Medición: powercfg /query for the active scheme, USB ETW/power diagnostics only when troubleshooting device behavior | Administrador=sí; Comandos=["powercfg.exe"]; PowerSetting={"SubGroupAlias":"SUB_USB","SettingAlias":"USBSELECTIVE","RequireDifferentFrom":1} | Grupo exclusivo: UsbSelectiveSuspendPolicy | PowerSetting; sin Undo declarativo; revisar motor |

#### Privacy & Suggested Content (8)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7PV001` | Reducir telemetria y anuncios dirigidos / Disable Telemetry | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva varias opciones de diagnostico, seguimiento y personalizacion publicitaria de Windows sin desactivar Windows Update. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (17 operación/es) |
| `V7PV002` | Desactivar consejos y contenido sugerido / Disable Suggestions | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Quita recomendaciones, consejos y sugerencias promocionales que Windows muestra en distintas partes de la interfaz. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (19 operación/es) |
| `V7PV003` | Desactivar notificaciones de aplicaciones / Disable Notifications | 13 → 1 | Mutation | 2 · Medio | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva las notificaciones de aplicaciones y otros remitentes. Puedes perder avisos utiles. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7PV004` | Desactivar servicios de ubicacion / Disable Location Services | 13 → 1 | Mutation | 2 · Medio | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Impide que Windows y las aplicaciones usen la ubicacion del dispositivo hasta que lo vuelvas a activar. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7PV005` | Desactivar Buscar mi dispositivo / Disable Find My Device | 13 → 1 | Mutation | 2 · Medio | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Desactiva el seguimiento usado por Buscar mi dispositivo; perderas esa funcion antirrobo/localizacion. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7PV006` | Quitar consejos de la pantalla de bloqueo / Disable Lockscreen Tips | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Elimina sugerencias y contenido promocional de la pantalla de bloqueo. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7PV007` | Quitar anuncios y sugerencias de Edge / Disable Edge Ads | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Reduce noticias, recomendaciones y contenido promocional dentro de Microsoft Edge. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (13 operación/es) |
| `V7PV008` | Ocultar promociones de Microsoft 365 en Configuracion / Disable Settings365 Ads | 13 → 1 | Mutation | 1 · Bajo | Optional · Conditional · E3 · Auto=Manual | Privacy | None | Quita banners y promociones de Microsoft 365/Copilot de la pagina principal de Configuracion. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### Services (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SV001` | Diagnostico de dependencias de servicios / Service dependency diagnostic | 14 → 10 → 10; mutaciones en 10 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Diagnostics | None | Muestra dependencias de servicios antes de cualquier recomendacion futura; VSO7 no desactiva servicios en masa. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: ServicesDependedOn, DependentServices, status | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Special (8)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SP001` | Eliminar aplicaciones seleccionadas / Remove Apps | 13 → 8 | Diagnostic | 4 · Muy alto | Advanced · Conditional · E3 · Auto=Never | System | None | Elimina solo las aplicaciones que elijas en el selector. Algunas apps del sistema pueden ser dificiles de recuperar; revisa cada una antes de confirmar. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP002` | Lista de aplicaciones / Apps | 13 → 8 | Diagnostic | 1 · Bajo | Advanced · Conditional · E3 · Auto=Never | System | None | Define que aplicaciones se eliminarian. Se usa desde el selector de apps y no es un interruptor independiente. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP003` | Eliminar apps de Xbox y Barra de juegos / Remove Gaming Apps | 13 → 8 | Mutation | 3 · Alto | Advanced · Conditional · E3 · Auto=Manual | System | None | Desinstala la app Xbox y componentes de Barra de juegos. No conviene si usas Game Pass, capturas Xbox o funciones sociales de Xbox. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP004` | Eliminar software OEM de HP / Remove HP Apps | 13 → 8 | Mutation | 3 · Alto | Advanced · Conditional · E3 · Auto=Manual | System | None | Desinstala varias aplicaciones HP preinstaladas. Puede quitar utilidades de soporte o funciones especificas del fabricante. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP005` | Crear punto de restauracion / Create Restore Point | 13 → 8 | Diagnostic | 1 · Bajo | Advanced · Conditional · E3 · Auto=Never | System | None | Crea un punto de restauracion de Windows antes de aplicar cambios. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP006` | Reemplazar diseño de Inicio / Replace Start | 13 → 8 | Diagnostic | 3 · Alto | Advanced · Conditional · E3 · Auto=Never | System | None | Sustituye los anclados de Inicio del usuario actual por una plantilla que debes proporcionar. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP007` | Reemplazar Inicio para todos los usuarios / Replace Start All Users | 13 → 8 | Diagnostic | 4 · Muy alto | Advanced · Conditional · E3 · Auto=Never | System | None | Aplica una plantilla de Inicio a usuarios existentes y nuevos; requiere revisar cuidadosamente la plantilla. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7SP008` | Forzar desinstalacion de Microsoft Edge / Force Remove Edge | 13 → 8 | Mutation | 4 · Muy alto | Advanced · Conditional · E3 · Auto=Manual | System | None | Intenta quitar Edge incluso en configuraciones donde Windows lo trata como componente. Puede romper enlaces, widgets o funciones que dependen de WebView/Edge. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Start Menu & Search (12)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `DisableSearchHighlights` | Desactivar contenido destacado de Busqueda / Disable Search Highlights | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita el contenido dinamico o promocional que aparece en el cuadro de busqueda de Windows sin desactivar la busqueda. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `DisableSearchHistory` | Desactivar historial de busqueda de Windows / Disable Search History | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Evita que la busqueda de Windows conserve el historial de busquedas del dispositivo. No desactiva Windows Search ni borra tus archivos. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7ST001` | Vaciar aplicaciones ancladas de Inicio / Clear Start | 13 → 3 | Diagnostic | 3 · Alto | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reservado para una implementacion nativa futura; esta RC no reemplaza archivos binarios del menu Inicio. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7ST002` | Vaciar Inicio para todos los usuarios / Clear Start All Users | 13 → 3 | Diagnostic | 4 · Muy alto | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reservado para una implementacion nativa futura; esta RC no reemplaza archivos binarios del menu Inicio. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7ST003` | Ocultar Recomendados en Inicio / Disable Start Recommended | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta la seccion de archivos y aplicaciones recomendadas del menu Inicio. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (5 operación/es) |
| `V7ST004` | Ocultar Todas las aplicaciones en Inicio / Disable Start All Apps | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta la seccion/lista de todas las aplicaciones del menu Inicio. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7ST005` | Quitar Enlace Movil de Inicio / Disable Start Phone Link | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Desactiva la integracion de Phone Link/Enlace Movil en el menu Inicio. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7ST006` | Desactivar resultados web de Bing en Busqueda / Disable Bing | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Hace que la busqueda de Inicio se centre en resultados locales en vez de consultar Bing/Copilot. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (3 operación/es) |
| `V7ST007` | Quitar sugerencias de Microsoft Store en Busqueda / Disable Store Search Suggestions | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Reservado en este RC: no se expone hasta disponer de un metodo nativo con rollback de permisos suficientemente robusto. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7ST008` | Mostrar Todas las aplicaciones por categorias / Start All Apps Category | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Usa la vista por categorias para Todas las aplicaciones cuando esa version de Windows lo admite. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7ST009` | Mostrar Todas las aplicaciones en cuadricula / Start All Apps Grid | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Cambia Todas las aplicaciones a una vista de cuadricula. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7ST010` | Mostrar Todas las aplicaciones en lista / Start All Apps List | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Usa la vista clasica en lista para Todas las aplicaciones. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |

#### Storage (9)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `EnableNtfsTrimWhenDisabledNoReFs` | Restaurar TRIM NTFS en SSD/NVMe / Restore NTFS TRIM on SSD/NVMe | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Recommended · Conditional · E1 · Auto=Eligible | Balanced, Performance | None | Habilita delete notifications (TRIM/unmap) solo si NTFS las tiene desactivadas, existe almacenamiento SSD/NVMe y no hay volumen ReFS detectado. VSO7 evita mezclar el cambio con ReFS para mantener ownership claro. Interacciones: Microsoft documenta TRIM NTFS habilitado por defecto y efectivo en el siguiente unmap; no requiere reinicio. Medición: fsutil behavior query DisableDeleteNotify | Administrador=sí; Comandos=["fsutil.exe","Get-PhysicalDisk","Get-Volume"]; StorageMediaAnyOf=["SSD"]; FsutilNtfsTrimDisabledNoReFs=sí | Ninguna declarada | FsutilTrim; sin Undo declarativo; revisar motor |
| `EnableScheduledDriveOptimization` | Restaurar optimizacion programada de unidades / Restore scheduled drive optimization | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Recommended · Stable · E1 · Auto=Eligible | Balanced, Performance | None | Vuelve a habilitar la tarea integrada ScheduledDefrag si fue desactivada. Windows selecciona defrag/retrim/tier optimization segun el tipo de unidad; VSO7 no fuerza defrag sobre SSD. Interacciones: La tarea de mantenimiento usa la logica nativa de Windows para cada media. Medición: ScheduledDefrag enabled state, Optimize Drives last-run history | Administrador=sí; Comandos=["Get-ScheduledTask","Enable-ScheduledTask","Disable-ScheduledTask","Export-ScheduledTask"]; ScheduledTaskDisabled={"TaskPath":"\\Microsoft\\Windows\\Defrag\\","TaskName":"ScheduledDefrag"} | Ninguna declarada | ScheduledTaskState; sin Undo declarativo; revisar motor |
| `RestoreStorageSensePolicyToUserControl` | Restaurar control de Storage Sense al usuario / Restore Storage Sense policy to user control | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Elimina una policy AllowStorageSenseGlobal=0 que bloquea Storage Sense, devolviendo el control a Settings. No fuerza Storage Sense a encenderse. Interacciones: Policy ADMX documentada por Microsoft; solo se elimina cuando esta explicitamente en 0. Medición: Storage Sense Settings availability | Administrador=sí; RegistryValue={"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","NumericMin":0,"NumericMax":0} | Grupo exclusivo: V7StorageSenseGlobal | Registry; sin Undo declarativo; revisar motor |
| `RestoreStorageSenseTempCleanupPolicyToUserControl` | Restaurar control de temporales de Storage Sense / Restore Storage Sense temp-cleanup policy to user control | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Elimina una policy que fuerza o bloquea la limpieza de temporales de Storage Sense para devolver esa decision al usuario. Interacciones: No borra archivos durante la aplicacion. Medición: Storage Sense temporary-files option availability | Administrador=sí; RegistryValueExists=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup"}] | Grupo exclusivo: V7StorageSenseTemp | Registry; sin Undo declarativo; revisar motor |
| `V7SR101` | Permitir Storage Sense por politica / Allow Storage Sense by policy | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Fuerza la policy oficial que permite Storage Sense. Es administracion de Windows, no un boost de rendimiento. Medición: Storage Sense Settings | Build mínimo=18362; Edición=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrador=sí; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","Value":1,"Kind":"DWord"}] | Grupo exclusivo: V7StorageSenseGlobal | Registry; sin Undo declarativo; revisar motor |
| `V7SR102` | Bloquear Storage Sense por politica / Block Storage Sense by policy | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Advanced · Conditional · E1 · Auto=Manual | Performance | None | Bloquea Storage Sense mediante policy. Puede impedir limpiezas automaticas; no se recomienda como optimizacion. Medición: Storage Sense Settings | Build mínimo=18362; Edición=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrador=sí; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseGlobal","Value":0,"Kind":"DWord"}] | Grupo exclusivo: V7StorageSenseGlobal | Registry; sin Undo declarativo; revisar motor |
| `V7SR103` | Permitir limpieza de temporales de Storage Sense / Allow Storage Sense temporary-file cleanup | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | Preferences | None | Permite mediante policy la limpieza de temporales no usados cuando Storage Sense se ejecuta. Medición: Storage Sense Settings | Build mínimo=18362; Edición=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrador=sí; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup","Value":1,"Kind":"DWord"}] | Grupo exclusivo: V7StorageSenseTemp | Registry; sin Undo declarativo; revisar motor |
| `V7SR104` | Bloquear limpieza de temporales de Storage Sense / Block Storage Sense temporary-file cleanup | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Mutation | 1 · Bajo | Advanced · Conditional · E1 · Auto=Manual | Performance | None | Impide por policy que Storage Sense elimine temporales. Es una preferencia administrativa, no una optimizacion. Medición: Storage Sense Settings | Build mínimo=18362; Edición=["Professional","ProfessionalN","Enterprise","EnterpriseN","Education","EducationN","IoTEnterprise","IoTEnterpriseS"]; Administrador=sí; RegistryAnyDifferent=[{"Path":"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\StorageSense","Name":"AllowStorageSenseTemporaryFilesCleanup","Value":0,"Kind":"DWord"}] | Grupo exclusivo: V7StorageSenseTemp | Registry; sin Undo declarativo; revisar motor |
| `V7ST201` | Salud y fiabilidad de discos fisicos / Physical disk health and reliability | 4/19; diagnostics 14 → 3 o 14 → 10 → 5 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance | None | Lee contadores Storage como temperatura, desgaste, horas y errores cuando dispositivo/driver los exponen. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: health status, temperature, wear, uncorrected errors | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### System (8)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7SY001` | Desactivar bandeja al arrastrar archivos / Disable Drag Tray | 13 → 2 | Mutation | 1 · Bajo | Advanced · Conditional · E3 · Auto=Manual | System | None | Desactiva la bandeja que aparece al arrastrar archivos para compartir o moverlos. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY002` | Usar menu contextual clasico / Revert Context Menu | 13 → 2 | Mutation | 1 · Bajo | Advanced · Conditional · E3 · Auto=Manual | System | None | Usa el estilo clasico de menu contextual similar a Windows 10. Es principalmente un cambio de interfaz. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY003` | Desactivar Mejorar precision del puntero / Disable Mouse Acceleration | 13 → 2 | Mutation | 1 · Bajo | Optional · Conditional · E1 · Auto=Manual | System | Logoff | Desactiva la aceleracion del puntero de Windows para la ruta de puntero tradicional. Es una preferencia de control; juegos con raw input pueden ignorarla. Medición: pointer feel/consistency; not FPS | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (3 operación/es) |
| `V7SY004` | Desactivar atajo de Teclas especiales / Disable Sticky Keys | 13 → 2 | Mutation | 1 · Bajo | Advanced · Conditional · E3 · Auto=Manual | System | None | Evita que pulsar Shift cinco veces abra el dialogo de Teclas especiales; no desactiva el teclado. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY005` | Desactivar Sensor de almacenamiento / Disable Storage Sense | 13 → 2 | Mutation | 2 · Medio | Optional · Conditional · E1 · Auto=Manual | System | None | Desactiva Storage Sense para el usuario actual. Es una preferencia de limpieza/espacio, no una optimizacion de FPS. Medición: free-space behavior over time | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY006` | Desactivar Inicio rapido / Disable Fast Startup | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Hace que Apagar realice un apagado mas completo en vez de usar hibernacion parcial. El arranque puede tardar algo mas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY007` | Evitar cifrado automatico futuro de BitLocker / Disable Bitlocker Auto Encryption | 13 → 2 | Mutation | 3 · Alto | Advanced · Conditional · E3 · Auto=Never | System | None | Evita que Windows active automaticamente el cifrado del dispositivo en ciertos equipos. No descifra unidades ya cifradas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7SY008` | Desactivar red durante Modern Standby / Disable Modern Standby Networking | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Reduce actividad de red mientras el equipo esta en Modern Standby; puede retrasar sincronizaciones en reposo. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |

#### Taskbar (19)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7TB001` | Alinear barra de tareas a la izquierda / Taskbar Align Left | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Mueve los iconos principales de la barra de tareas a la izquierda. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB002` | Ocultar Busqueda de la barra de tareas / Hide Search Taskbar | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Quita el boton/cuadro de Busqueda de la barra; la busqueda de Inicio sigue disponible. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB003` | Mostrar icono de Busqueda / Show Search Icon Taskbar | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra solo el icono de Busqueda en la barra de tareas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB004` | Mostrar icono y texto de Busqueda / Show Search Label Taskbar | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra el icono de Busqueda acompañado de su etiqueta. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB005` | Mostrar cuadro de Busqueda / Show Search Box Taskbar | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra el cuadro de busqueda completo en la barra de tareas. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7TB006` | Ocultar Vista de tareas / Hide Taskview | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta el boton Vista de tareas; Win+Tab sigue dependiendo de la configuracion de Windows. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB007` | Desactivar Widgets / Disable Widgets | 13 → 3 | Preference | 3 · Alto | Optional · Conditional · E3 · Auto=Never | Preferences | None | Desactiva widgets de la barra y pantalla de bloqueo eliminando sus paquetes relacionados. Puede requerir reinstalarlos para recuperarlos. | Sin condición declarada | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7TB008` | Ocultar Chat/Reunirse ahora / Hide Chat | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Oculta el acceso de Chat/Reunirse ahora de la barra de tareas. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (2 operación/es) |
| `V7TB009` | Mostrar Finalizar tarea en la barra / Enable End Task | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Añade una opcion para finalizar una aplicacion desde el menu contextual de su icono en la barra. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB010` | Activar ultimo clic activo en la barra / Enable Last Active Click | 13 → 3 | Preference | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Al pulsar un grupo de ventanas en la barra, cambia directamente a la ultima ventana activa. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB011` | Combinar siempre botones de la barra principal / Combine Taskbar Always | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Agrupa siempre ventanas de la misma aplicacion y oculta etiquetas en el monitor principal. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7TB012` | Combinar siempre en barras secundarias / Combine Multi-Monitor Taskbar Always | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Agrupa siempre ventanas en las barras de monitores secundarios. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7TB013` | Combinar botones cuando la barra se llene / Combine Taskbar When Full | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Mantiene etiquetas hasta que falte espacio en la barra principal. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB014` | Combinar en monitores secundarios cuando se llenen / Combine Multi-Monitor Taskbar When Full | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Aplica el comportamiento "cuando se llene" a barras secundarias. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB015` | No combinar botones de la barra principal / Combine Taskbar Never | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra cada ventana por separado con su etiqueta en el monitor principal. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB016` | No combinar en barras secundarias / Combine Multi-Monitor Taskbar Never | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra las ventanas separadas en monitores secundarios. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB017` | Mostrar apps en todas las barras / Multi-Monitor Taskbar Mode All | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | En varios monitores, muestra los iconos de las aplicaciones en todas las barras. | Sin condición declarada | Ninguna declarada | Registry; solo diagnóstico |
| `V7TB018` | Mostrar apps en barra principal y monitor activo / Multi-Monitor Taskbar Mode Main Active | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | Muestra cada app en la barra principal y en la del monitor donde esta su ventana. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7TB019` | Mostrar apps solo en su monitor / Multi-Monitor Taskbar Mode Active | 13 → 3 | Diagnostic | 1 · Bajo | Optional · Conditional · E3 · Auto=Never | Preferences | None | En varios monitores, cada ventana aparece solo en la barra del monitor donde esta abierta. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

#### USB & HID (2)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7US001` | Topologia controlador-dispositivo USB / USB controller-to-device topology | 14 → 10 → 4; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Relaciona controladores USB con dispositivos conectados y clasifica roles HID, audio, almacenamiento y hubs. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: controller, device, PnP class, classification | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |
| `V7US002` | Diagnostico de energia USB / USB power diagnostic | 14 → 10 → 4; 17 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Responsiveness, Performance | None | Muestra valores actuales de selective suspend y metadatos de energia de hubs sin exponer una desactivacion global indiscriminada. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: USBSELECTIVE AC/DC, hub power support | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Wi-Fi (1)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7WF001` | Inventario de capacidades Wi-Fi / Wi-Fi driver capability inventory | 14 → 10 → 7 | Diagnostic | 1 · Bajo | Diagnostic · Diagnostic · E1 · Auto=Never | Performance, Responsiveness | None | Enumera propiedades Wi-Fi avanzadas expuestas por el driver y separa nombres localizados de identificadores RegistryKeyword estables. Interacciones: Solo lectura. Un estado Unknown/no disponible no se presenta como fallo del sistema. Medición: preferred band if exposed, roaming if exposed, power/MIMO values if exposed | Administrador=no; RuntimeProbeRequired=sí; FailClosedWhenUnavailable=sí | Ninguna declarada | Special; recuperación especializada o no garantizada |

#### Windows Update (4)

| ID | Nombre ES / EN | Ruta | Tipo | Riesgo | Policy | Objetivos | Reinicio | Efecto/interacción | Aplicabilidad exacta | Relaciones | Recovery |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `V7WU001` | No recibir actualizaciones en cuanto esten disponibles / Disable Update ASAP | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Desactiva la opcion de adelantarse a actualizaciones no urgentes; Windows Update sigue funcionando. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7WU002` | Evitar reinicios automaticos de Update con sesion iniciada / Prevent Update Auto Reboot | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Reduce reinicios automaticos por actualizaciones mientras hay un usuario conectado. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7WU003` | Desactivar compartir actualizaciones con otros PCs / Disable Delivery Optimization | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Evita que Delivery Optimization intercambie partes de actualizaciones con otros equipos. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |
| `V7WU004` | Evitar apps compañeras automaticas de dispositivos / Disable Device Auto App Download | 13 → 2 | Mutation | 2 · Medio | Advanced · Conditional · E3 · Auto=Manual | System | None | Impide que Windows instale automaticamente ciertas aplicaciones recomendadas al conectar hardware. | Sin condición declarada | Ninguna declarada | Registry; rollback declarativo (1 operación/es) |

### Guía práctica de los 120 ajustes seleccionables

Esta subsección conserva la explicación orientada al usuario de la documentación inicial y la cruza con el `FeatureId` y los metadatos del catálogo de VSO7 1.2.1. La matriz técnica anterior sigue siendo la referencia autoritativa para aplicabilidad, relaciones, operaciones y Recovery. Aquí se explica en lenguaje directo qué hace cada ajuste, cuándo tiene sentido y qué se puede perder.

#### Especiales

##### `V7SP003` — Eliminar apps de Xbox y Barra de juegos

- **Qué hace:** Desinstala la app Xbox y componentes de Barra de juegos. No conviene si usas Game Pass, capturas Xbox o funciones sociales de Xbox.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección. Perderás componentes de Xbox/Game Bar. Puede afectar Game Pass, capturas, inicio de sesión Xbox o funciones sociales.
- **Reversibilidad indicada:** No con el Recovery normal de VSO7. Si lo aplicas, asume que quizá tengas que repararlo o reinstalarlo manualmente.
- **Metadatos actuales:** riesgo 3/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SP004` — Eliminar software OEM de HP

- **Qué hace:** Desinstala varias aplicaciones HP preinstaladas. Puede quitar utilidades de soporte o funciones especificas del fabricante.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección. Puedes perder utilidades de batería, soporte, diagnóstico, impresora u otras funciones propias de HP.
- **Reversibilidad indicada:** No con el Recovery normal de VSO7. Si lo aplicas, asume que quizá tengas que repararlo o reinstalarlo manualmente.
- **Metadatos actuales:** riesgo 3/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SP008` — Forzar desinstalacion de Microsoft Edge

- **Qué hace:** Intenta quitar Edge incluso en configuraciones donde Windows lo trata como componente. Puede romper enlaces, widgets o funciones que dependen de WebView/Edge.
- **Cuándo merece la pena:** Puede quitar Edge, pero VSO7 lo considera una operación agresiva: otras partes de Windows pueden depender de componentes de Edge.
- **Consecuencia o riesgo práctico:** **Muy alto (4/4)** — Muy alto: puede quitar un componente importante y ser difícil de recuperar. Puede romper enlaces, Widgets o funciones que usan componentes web de Microsoft. Recuperarlo puede requerir reinstalación manual.
- **Reversibilidad indicada:** No con el Recovery normal de VSO7. Si lo aplicas, asume que quizá tengas que repararlo o reinstalarlo manualmente.
- **Metadatos actuales:** riesgo 4/4 · `Advanced` · reinicio `None` · auto `Manual`.

#### Privacidad y contenido sugerido

##### `V7PV001` — Reducir telemetria y anuncios dirigidos

- **Qué hace:** Desactiva varias opciones de diagnostico, seguimiento y personalizacion publicitaria de Windows sin desactivar Windows Update.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV002` — Desactivar consejos y contenido sugerido

- **Qué hace:** Quita recomendaciones, consejos y sugerencias promocionales que Windows muestra en distintas partes de la interfaz.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV003` — Desactivar notificaciones de aplicaciones

- **Qué hace:** Desactiva las notificaciones de aplicaciones y otros remitentes. Puedes perder avisos utiles.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV004` — Desactivar servicios de ubicacion

- **Qué hace:** Impide que Windows y las aplicaciones usen la ubicacion del dispositivo hasta que lo vuelvas a activar.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta. Las aplicaciones dejarán de obtener la ubicación hasta que lo reviertas.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV005` — Desactivar Buscar mi dispositivo

- **Qué hace:** Desactiva el seguimiento usado por Buscar mi dispositivo; perderas esa funcion antirrobo/localizacion.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta. Pierdes “Buscar mi dispositivo”.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV006` — Quitar consejos de la pantalla de bloqueo

- **Qué hace:** Elimina sugerencias y contenido promocional de la pantalla de bloqueo.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV007` — Quitar anuncios y sugerencias de Edge

- **Qué hace:** Reduce noticias, recomendaciones y contenido promocional dentro de Microsoft Edge.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PV008` — Ocultar promociones de Microsoft 365 en Configuracion

- **Qué hace:** Quita banners y promociones de Microsoft 365/Copilot de la pagina principal de Configuracion.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

#### Inteligencia artificial

##### `V7AI001` — Desactivar Microsoft Copilot

- **Qué hace:** Desactiva la integracion de Copilot en Windows. No desinstala aplicaciones de terceros.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI002` — Desactivar Windows Recall

- **Qué hace:** Desactiva Recall para evitar que Windows use esa funcion de historial/capturas asistidas por IA.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI003` — Desactivar Click to Do

- **Qué hace:** Desactiva el analisis contextual de texto e imagenes de Click to Do.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI004` — Evitar inicio automatico del servicio de IA

- **Qué hace:** Impide que el servicio de IA configurado por Windows se inicie automaticamente; algunas funciones de IA pueden dejar de funcionar.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI005` — Desactivar funciones de IA de Edge

- **Qué hace:** Desactiva varias funciones de IA integradas en Microsoft Edge.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI006` — Desactivar funciones de IA de Paint

- **Qué hace:** Desactiva funciones de IA de Paint cuando Windows las expone mediante estas politicas.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7AI007` — Desactivar funciones de IA del Bloc de notas

- **Qué hace:** Desactiva funciones de IA del Bloc de notas cuando estan disponibles.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

#### Gaming

##### `V7GM001` — Desactivar captura/grabacion de juegos (legacy)

- **Qué hace:** Desactiva captura/grabacion de juegos. VSO7 conserva esta variante avanzada por compatibilidad funcional, pero recomienda la variante por usuario porque esta tambien escribe una regla de Windows de equipo.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio. Pierdes captura/grabación de Xbox Game Bar mientras esté aplicado.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `AppRestart` · auto `Manual`.

##### `RestoreGameRecordingPolicyToUserControl` — Restaurar control de grabacion al usuario

- **Qué hace:** Quita una prohibición forzada de grabación de juegos y devuelve el control al usuario. No activa las capturas por sí solo.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AppRestart` · auto `Manual`.

##### `DisableBackgroundGameCapturePerUser` — Desactivar capturas de juego por usuario

- **Qué hace:** Desactiva la grabación de juego en segundo plano para tu usuario. Reduce actividad de captura, pero pierdes la función de guardar lo que acaba de pasar de Xbox Game Bar.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio. Pierdes la captura automática en segundo plano de Xbox Game Bar.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AppRestart` · auto `Manual`.

##### `V7GM101` — Activar Game Mode

- **Qué hace:** Activa la preferencia oficial de Game Mode. No promete mas FPS; Windows decide la optimizacion efectiva segun juego, hardware y scheduler.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `AppRestart` · auto `Eligible`.

##### `V7GM102` — Desactivar Game Mode para prueba A/B

- **Qué hace:** Desactiva Game Mode de forma reversible para comparar un juego concreto. No es una recomendacion universal.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Experimental` · reinicio `AppRestart` · auto `Never`.

##### `V7GM103` — Permitir abrir Game Bar con mando

- **Qué hace:** Activa la preferencia oficial que permite abrir Game Bar con el boton del mando. Es una preferencia de UX, no un ajuste de rendimiento.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7GM104` — Bloquear apertura de Game Bar con mando

- **Qué hace:** Desactiva de forma reversible la apertura de Game Bar mediante el boton del mando. Solo cambia comportamiento de entrada/UX.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

#### Inicio y busqueda

##### `V7ST003` — Ocultar Recomendados en Inicio

- **Qué hace:** Oculta la seccion de archivos y aplicaciones recomendadas del menu Inicio.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7ST004` — Ocultar Todas las aplicaciones en Inicio

- **Qué hace:** Oculta la seccion/lista de todas las aplicaciones del menu Inicio.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7ST005` — Quitar Enlace Movil de Inicio

- **Qué hace:** Desactiva la integracion de Phone Link/Enlace Movil en el menu Inicio.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7ST006` — Desactivar resultados web de Bing en Busqueda

- **Qué hace:** Hace que la busqueda de Inicio se centre en resultados locales en vez de consultar Bing/Copilot.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `DisableSearchHistory` — Desactivar historial de busqueda de Windows

- **Qué hace:** Evita que la busqueda de Windows conserve el historial de busquedas del dispositivo. No desactiva Windows Search ni borra tus archivos.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `DisableSearchHighlights` — Desactivar contenido destacado de Busqueda

- **Qué hace:** Quita el contenido dinamico o promocional que aparece en el cuadro de busqueda de Windows sin desactivar la busqueda.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

#### Otros

##### `V7OT001` — Ocultar Inicio de Configuracion

- **Qué hace:** Hace que Configuracion no use la pagina Home/Inicio promocional como entrada principal.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7OT002` — Desactivar extras de Brave

- **Qué hace:** Desactiva varias funciones promocionales de Brave, como componentes de IA/cripto, segun la version instalada.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

#### Apariencia

##### `V7UI004` — Activar modo oscuro

- **Qué hace:** Activa el tema oscuro para Windows y aplicaciones compatibles.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7UI005` — Desactivar transparencias

- **Qué hace:** Reduce efectos translucidos de Windows. Es un cambio visual reversible.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7UI006` — Reducir animaciones y efectos visuales

- **Qué hace:** Desactiva varias animaciones para que la interfaz se sienta mas inmediata.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio. La interfaz se verá menos animada y más simple.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

#### Sistema

##### `V7SY001` — Desactivar bandeja al arrastrar archivos

- **Qué hace:** Desactiva la bandeja que aparece al arrastrar archivos para compartir o moverlos.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SY002` — Usar menu contextual clasico

- **Qué hace:** Usa el estilo clasico de menu contextual similar a Windows 10. Es principalmente un cambio de interfaz.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SY003` — Desactivar Mejorar precision del puntero

- **Qué hace:** Desactiva la aceleracion del puntero de Windows para la ruta de puntero tradicional. Es una preferencia de control; juegos con raw input pueden ignorarla.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `Logoff` · auto `Manual`.

##### `V7SY004` — Desactivar atajo de Teclas especiales

- **Qué hace:** Evita que pulsar Shift cinco veces abra el dialogo de Teclas especiales; no desactiva el teclado.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SY005` — Desactivar Sensor de almacenamiento

- **Qué hace:** Desactiva Storage Sense para el usuario actual. Es una preferencia de limpieza/espacio, no una optimizacion de FPS.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7SY006` — Desactivar Inicio rapido

- **Qué hace:** Hace que Apagar realice un apagado mas completo en vez de usar hibernacion parcial. El arranque puede tardar algo mas.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SY007` — Evitar cifrado automatico futuro de BitLocker

- **Qué hace:** Evita que Windows active automaticamente el cifrado del dispositivo en ciertos equipos. No descifra unidades ya cifradas.
- **Cuándo merece la pena:** Sí funciona, pero no es una optimización de rendimiento. Evita cifrado automático futuro y por tanto reduce protección si el equipo se pierde o es robado.
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección. Reduce seguridad frente a pérdida o robo porque evita que Windows active automáticamente cifrado en ciertos equipos. Reduce una protección de seguridad de Windows.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 3/4 · `Advanced` · reinicio `None` · auto `Never`.

##### `V7SY008` — Desactivar red durante Modern Standby

- **Qué hace:** Reduce actividad de red mientras el equipo esta en Modern Standby; puede retrasar sincronizaciones en reposo.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta. Sin red durante Modern Standby, algunas sincronizaciones/notificaciones pueden esperar hasta que despiertes el PC.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

#### Multitarea

##### `V7MT001` — Desactivar ajuste de ventanas

- **Qué hace:** Desactiva la funcion de acoplar ventanas a bordes y zonas de la pantalla.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7MT002` — Desactivar sugerencias al acoplar ventanas

- **Qué hace:** Mantiene otras funciones de ventanas pero evita que Windows sugiera aplicaciones para completar un diseño.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7MT003` — Ocultar diseños de acoplamiento

- **Qué hace:** Oculta el panel de diseños que aparece al pasar por maximizar o en la parte superior.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

#### Barra de tareas

##### `V7TB001` — Alinear barra de tareas a la izquierda

- **Qué hace:** Mueve los iconos principales de la barra de tareas a la izquierda.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7TB006` — Ocultar Vista de tareas

- **Qué hace:** Oculta el boton Vista de tareas; Win+Tab sigue dependiendo de la configuracion de Windows.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7TB007` — Desactivar Widgets

- **Qué hace:** Desactiva widgets de la barra y pantalla de bloqueo eliminando sus paquetes relacionados. Puede requerir reinstalarlos para recuperarlos.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección.
- **Reversibilidad indicada:** No con el Recovery normal de VSO7. Si lo aplicas, asume que quizá tengas que repararlo o reinstalarlo manualmente.
- **Metadatos actuales:** riesgo 3/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7TB008` — Ocultar Chat/Reunirse ahora

- **Qué hace:** Oculta el acceso de Chat/Reunirse ahora de la barra de tareas.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7TB009` — Mostrar Finalizar tarea en la barra

- **Qué hace:** Añade una opcion para finalizar una aplicacion desde el menu contextual de su icono en la barra.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7TB010` — Activar ultimo clic activo en la barra

- **Qué hace:** Al pulsar un grupo de ventanas en la barra, cambia directamente a la ultima ventana activa.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

#### Explorador de archivos

##### `V7FE005` — Mostrar extensiones de archivo

- **Qué hace:** Muestra .exe, .txt, .jpg y otras extensiones conocidas; ayuda a identificar mejor los archivos.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE006` — Mostrar archivos y carpetas ocultos

- **Qué hace:** Hace visibles elementos marcados como ocultos en el Explorador.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE007` — Ocultar unidades extraibles duplicadas

- **Qué hace:** Evita que ciertas unidades USB aparezcan duplicadas en el panel de navegacion.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE008` — Ocultar Inicio del Explorador

- **Qué hace:** Quita Inicio/Home del panel de navegacion del Explorador.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE009` — Ocultar Galeria del Explorador

- **Qué hace:** Quita Galeria del panel de navegacion.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE010` — Ocultar OneDrive del Explorador

- **Qué hace:** Oculta OneDrive del panel de navegacion; no desinstala el cliente ni borra archivos.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE011` — Ocultar carpeta Objetos 3D

- **Qué hace:** Quita la carpeta Objetos 3D de Este equipo.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE012` — Ocultar carpeta Musica

- **Qué hace:** Quita Musica de Este equipo/panel segun la version de Windows.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE013` — Añadir carpetas comunes a Este equipo

- **Qué hace:** Vuelve a mostrar carpetas comunes como Documentos/Descargas en Este equipo.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE014` — Ocultar Incluir en biblioteca

- **Qué hace:** Quita esa entrada del menu contextual del Explorador.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE015` — Ocultar Dar acceso a

- **Qué hace:** Quita la entrada de compartir mediante "Dar acceso a" del menu contextual.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

##### `V7FE016` — Ocultar Compartir

- **Qué hace:** Quita la entrada Compartir del menu contextual moderno.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Never`.

#### Windows Update

##### `V7WU001` — No recibir actualizaciones en cuanto esten disponibles

- **Qué hace:** Desactiva la opcion de adelantarse a actualizaciones no urgentes; Windows Update sigue funcionando.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7WU002` — Evitar reinicios automaticos de Update con sesion iniciada

- **Qué hace:** Reduce reinicios automaticos por actualizaciones mientras hay un usuario conectado.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta. Puede retrasar reinicios que Windows Update quería hacer automáticamente.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7WU003` — Desactivar compartir actualizaciones con otros PCs

- **Qué hace:** Evita que Delivery Optimization intercambie partes de actualizaciones con otros equipos.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7WU004` — Evitar apps compañeras automaticas de dispositivos

- **Qué hace:** Impide que Windows instale automaticamente ciertas aplicaciones recomendadas al conectar hardware.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

#### Funciones opcionales de Windows

##### `V7OF001` — Activar Windows Sandbox

- **Qué hace:** Habilita la caracteristica opcional Sandbox. Puede requerir reinicio y virtualizacion compatible.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección. Añade una función de virtualización de Windows y puede requerir reinicio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 3/4 · `Advanced` · reinicio `SystemRestart` · auto `Manual`.

##### `V7OF002` — Activar WSL

- **Qué hace:** Habilita WSL y Virtual Machine Platform. Puede requerir reinicio y cambia las caracteristicas opcionales instaladas.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección. Añade WSL y componentes de virtualización. Puede requerir reinicio y cambia funciones instaladas.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 3/4 · `Advanced` · reinicio `SystemRestart` · auto `Manual`.

#### Energía y USB

##### `EnableUsbSelectiveSuspend` — Restaurar suspensión selectiva USB

- **Qué hace:** Devuelve a Windows la capacidad de poner en reposo dispositivos USB que no se están usando. Ahorra energía; no es un tweak para ganar FPS.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

#### Red

##### `EnablePhysicalNicRss` — Activar RSS en NIC física compatible

- **Qué hace:** Permite que el trabajo de recibir datos de red se reparta entre varios núcleos del procesador. Puede ayudar con mucho tráfico; no promete bajar el ping.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicChecksumOffloads` — Restaurar checksum offloads de NIC física

- **Qué hace:** Permite que la tarjeta de red haga parte del trabajo de comprobar los datos que entran y salen, en vez de cargar todo sobre la CPU.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Recommended` · reinicio `AdapterRestart` · auto `Eligible`.

##### `RestorePhysicalNicLso` — Restaurar Large Send Offload (LSO)

- **Qué hace:** Permite que la tarjeta de red prepare envíos grandes con menos trabajo para la CPU. Suele ayudar a eficiencia de red; no es un tweak de ping.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicRsc` — Restaurar RSC en NIC física

- **Qué hace:** Permite agrupar parte del tráfico recibido para reducir trabajo de CPU. Favorece eficiencia y velocidad sostenida, no necesariamente latencia.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `AdapterRestart` · auto `Manual`.

##### `DisablePhysicalNicRscForLowLatency` — Desactivar RSC para prueba de baja latencia

- **Qué hace:** Deja de agrupar tráfico recibido para probar si tu caso concreto mejora algo de latencia. Puede aumentar el uso de CPU; está pensado para comparar antes/después.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `AdapterRestart` · auto `Manual`.

##### `RestoreGlobalReceiveSideScaling` — Restaurar RSS global del stack TCP/IP

- **Qué hace:** Vuelve a permitir que Windows reparta el trabajo de red entrante entre varios núcleos. Es una restauración sensata si alguien lo había desactivado.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `RestoreGlobalReceiveSegmentCoalescing` — Restaurar RSC global del stack TCP/IP

- **Qué hace:** Vuelve a permitir que Windows agrupe tráfico recibido para reducir trabajo de CPU. No es una mejora universal de ping.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `RestoreGlobalTaskOffload` — Restaurar task offload global

- **Qué hace:** Vuelve a permitir que Windows use funciones de ayuda de la tarjeta de red en vez de hacerlo todo con la CPU.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AdapterRestart` · auto `Eligible`.

##### `RestoreTcpAutoTuningNormal` — Restaurar TCP receive autotuning Normal

- **Qué hace:** Devuelve a Windows el control automático del tamaño de recepción de red. Evita límites manuales que pueden reducir la velocidad de descarga o transferencia.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `EnablePhysicalNicInterruptModeration` — Activar moderación de interrupciones

- **Qué hace:** Hace que la tarjeta de red agrupe avisos a la CPU. Reduce carga de procesador, pero puede añadir una cantidad pequeña de latencia.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `AdapterRestart` · auto `Manual`.

##### `DisablePhysicalNicInterruptModerationForLowLatency` — Desactivar moderación para prueba de baja latencia

- **Qué hace:** Hace que la tarjeta de red avise a la CPU con menos agrupación para probar menor latencia. Puede aumentar bastante el trabajo de CPU.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `AdapterRestart` · auto `Manual`.

##### `RestorePhysicalNicEee` — Restaurar Energy Efficient Ethernet

- **Qué hace:** Vuelve a activar el ahorro de energía de Ethernet cuando la tarjeta lo soporta. Ahorra energía; no es una mejora de gaming.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AdapterRestart` · auto `Eligible`.

##### `EnableWakeOnMagicPacketPhysicalNics` — Activar Wake-on-Magic-Packet compatible

- **Qué hace:** Permite encender o despertar el PC desde la red con una señal especial cuando la tarjeta lo soporta. No mejora el rendimiento.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AdapterRestart` · auto `Manual`.

##### `RestoreNicSelectiveSuspendOnLaptops` — Restaurar selective suspend de NIC en laptop

- **Qué hace:** Vuelve a permitir que un portátil duerma una tarjeta de red inactiva para ahorrar batería. No mejora el ping.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AdapterRestart` · auto `Eligible`.

##### `RestoreTcpEcnDefaultDisabled` — Restaurar ECN a Disabled

- **Qué hace:** Devuelve una función especial de congestión de red a su estado normal desactivado. Es una normalización, no un tweak de velocidad.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `EnableTcpEcnForTesting` — Activar ECN para prueba A/B

- **Qué hace:** Activa una función especial de congestión de red para probarla en una red compatible. No se recomienda como mejora general.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `None` · auto `Never`.

##### `RestoreTcpTimestampsAllowed` — Restaurar TCP timestamps a Allowed

- **Qué hace:** Devuelve las marcas de tiempo de red al comportamiento normal de Windows. No promete menor ping.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `EnableWakeOnPatternPhysicalNics` — Activar Wake-on-Pattern compatible

- **Qué hace:** Permite que ciertos patrones de tráfico despierten el PC. Es comodidad/energía, no rendimiento.
- **Cuándo merece la pena:** Sí, hace exactamente ese cambio, pero es una preferencia de uso o aspecto; **no es una promesa de más rendimiento**.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AdapterRestart` · auto `Manual`.

##### `V7NW101` — Forzar TCP timestamps para prueba A/B

- **Qué hace:** Fuerza unas marcas de tiempo de red solo para comparar resultados. No es una optimización general.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `None` · auto `Never`.

##### `V7NW102` — Desactivar TCP timestamps para prueba A/B

- **Qué hace:** Desactiva unas marcas de tiempo de red solo para comparar resultados. No es una optimización general.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `None` · auto `Never`.

##### `V7NW204` — Desactivar Energy Efficient Ethernet para prueba A/B

- **Qué hace:** Desactiva el ahorro de energía de Ethernet para probar si cambia la latencia o estabilidad. Puede aumentar consumo y no garantiza menor ping.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `AdapterRestart` · auto `Never`.

##### `V7NW205` — Desactivar Large Send Offload para prueba A/B

- **Qué hace:** Hace que la CPU se encargue de más trabajo al enviar datos de red para comparar resultados. Puede aumentar uso de CPU y no garantiza menor latencia.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `AdapterRestart` · auto `Never`.

##### `V7NW206` — Desactivar checksum offloads para prueba A/B

- **Qué hace:** Hace que la CPU se encargue también de comprobar paquetes de red para comparar resultados. Puede aumentar bastante el uso de CPU y normalmente no se recomienda.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Alto (3/4)** — Alto: puede desactivar una función importante o reducir una protección.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 3/4 · `Experimental` · reinicio `AdapterRestart` · auto `Never`.

#### Diagnóstico

##### `NormalizeClampedSystemResponsivenessOverride` — Normalizar override MMCSS <10 a 20

- **Qué hace:** Corrige un valor raro de prioridades multimedia cuando está entre 0 y 9. Windows ya trata esos valores como 20, así que esto ordena la configuración pero no debería dar más rendimiento.
- **Cuándo merece la pena:** Sí hace el cambio, pero **no esperes una mejora de rendimiento**: Windows ya interpreta esos valores de forma equivalente.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

#### CPU y energia

##### `EnableProcessorBoostModeOnAcDesktop` — Habilitar boost de CPU en AC si estaba desactivado

- **Qué hace:** Vuelve a permitir el turbo del procesador en un sobremesa conectado a corriente si estaba desactivado.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `RestorePowerThrottlingToUserControl` — Restaurar Power Throttling a control normal

- **Qué hace:** Devuelve a Windows y al usuario el control normal del ahorro de energía de procesos en segundo plano.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `RestoreMaxProcessorStateOnAcDesktop` — Restaurar maximo CPU al 100 % en AC/desktop

- **Qué hace:** Quita un límite artificial del procesador y vuelve a permitir el 100 % cuando un sobremesa está conectado a corriente.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `SetProcessorEppPerformanceOnAcDesktop` — EPP orientado a rendimiento en AC/desktop

- **Qué hace:** Hace que un sobremesa conectado a corriente favorezca más el rendimiento de CPU que el ahorro de energía. Puede aumentar consumo y temperatura.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `SetProcessorEppBalancedOnAcDesktop` — EPP equilibrado en AC/desktop

- **Qué hace:** Busca un punto medio entre respuesta de CPU y consumo en un sobremesa conectado a corriente.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `SetProcessorEppEfficiencyOnBatteryLaptop` — EPP eficiente en bateria/laptop

- **Qué hace:** Hace que un portátil con batería favorezca autonomía y temperatura frente al rendimiento máximo.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Eligible`.

##### `EnableActiveCoolingOnAcLaptop` — Priorizar refrigeracion activa en AC/laptop

- **Qué hace:** En un portátil enchufado, prefiere usar más los ventiladores antes que bajar el rendimiento de CPU. Puede hacer más ruido.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Eligible`.

##### `V7PW101` — EPP equilibrado en AC para portatil

- **Qué hace:** En un portátil enchufado, deja la CPU en un equilibrio entre rendimiento y consumo.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7PW102` — EPP rendimiento en AC para portatil

- **Qué hace:** En un portátil enchufado, hace que la CPU favorezca más el rendimiento. Puede aumentar temperatura, consumo y ruido.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7PW103` — Desactivar boost de CPU en bateria

- **Qué hace:** Con batería, desactiva el turbo de CPU para gastar menos y calentarse menos. También reduce el rendimiento máximo.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio. Con batería tendrás menos rendimiento máximo de CPU.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Eligible`.

##### `V7PW104` — PCIe ASPM moderado en bateria

- **Qué hace:** Con batería, usa un ahorro moderado de energía para dispositivos PCIe. Puede añadir un poco de latencia al salir del ahorro.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Eligible`.

##### `V7PW105` — PCIe ASPM maximo en bateria

- **Qué hace:** Con batería, usa el ahorro de energía PCIe más fuerte. Ahorra más, pero puede tardar más en recuperar plena respuesta.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta. Puede empeorar la respuesta de algunos dispositivos PCIe al salir del ahorro.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Advanced` · reinicio `None` · auto `Manual`.

#### Almacenamiento

##### `EnableNtfsTrimWhenDisabledNoReFs` — Restaurar TRIM NTFS en SSD/NVMe

- **Qué hace:** Vuelve a activar el aviso que permite a un SSD saber qué espacio borrado puede reutilizar. Es mantenimiento normal para SSD compatibles.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `EnableScheduledDriveOptimization` — Restaurar optimizacion programada de unidades

- **Qué hace:** Vuelve a activar el mantenimiento programado de unidades de Windows. Windows decide el mantenimiento apropiado según el tipo de disco.
- **Cuándo merece la pena:** Sí, cuando VSO7 detecta que tu PC está en el caso que intenta corregir. Es de las opciones más conservadoras.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Recommended` · reinicio `None` · auto `Eligible`.

##### `RestoreStorageSensePolicyToUserControl` — Restaurar control de Storage Sense al usuario

- **Qué hace:** Quita una orden que obligaba o bloqueaba Storage Sense y devuelve esa decisión al usuario.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `RestoreStorageSenseTempCleanupPolicyToUserControl` — Restaurar control de temporales de Storage Sense

- **Qué hace:** Devuelve al usuario el control sobre si Storage Sense limpia archivos temporales.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7SR101` — Permitir Storage Sense por politica

- **Qué hace:** Fuerza la regla de Windows oficial que permite Storage Sense. Es administracion de Windows, no un boost de rendimiento.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7SR102` — Bloquear Storage Sense por politica

- **Qué hace:** Bloquea Storage Sense mediante regla de Windows. Puede impedir limpiezas automaticas; no se recomienda como optimizacion.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

##### `V7SR103` — Permitir limpieza de temporales de Storage Sense

- **Qué hace:** Permite mediante regla de Windows la limpieza de temporales no usados cuando Storage Sense se ejecuta.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `None` · auto `Manual`.

##### `V7SR104` — Bloquear limpieza de temporales de Storage Sense

- **Qué hace:** Impide por regla de Windows que Storage Sense elimine temporales. Es una preferencia administrativa, no una optimizacion.
- **Cuándo merece la pena:** Funciona como cambio de Windows, pero solo tiene sentido en casos concretos. **No lo apliques pensando que “más tweaks = más rendimiento”.**
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Advanced` · reinicio `None` · auto `Manual`.

#### Graficos y GPU

##### `V7GP001` — Activar optimizaciones para juegos en ventana

- **Qué hace:** Activa la optimización moderna de Windows para juegos que funcionan en ventana o ventana sin bordes. Puede mejorar cómo se presentan algunos juegos compatibles.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Bajo (1/4)** — Bajo: es difícil que cause un problema serio.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 1/4 · `Optional` · reinicio `AppRestart` · auto `Manual`.

##### `V7GP002` — Desactivar optimizaciones para juegos en ventana (A/B)

- **Qué hace:** Desactiva temporalmente esa optimización de juegos en ventana para poder comparar. No se presenta como mejor opción universal.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `AppRestart` · auto `Never`.

##### `V7GP003` — Activar HAGS si el soporte esta verificado

- **Qué hace:** Activa la programación de GPU acelerada por hardware solo cuando Windows y el controlador indican que está soportada. El resultado depende de la GPU y del juego.
- **Cuándo merece la pena:** Sí, hace lo que indica. Merece la pena solo si prefieres ese comportamiento o tienes ese problema concreto.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Optional` · reinicio `SystemRestart` · auto `Manual`.

##### `V7GP004` — Desactivar HAGS (A/B) si el soporte esta verificado

- **Qué hace:** Desactiva la programación de GPU acelerada por hardware para comparar antes/después en un equipo compatible. No se asume que sea mejor.
- **Cuándo merece la pena:** El cambio funciona, pero **no está demostrado que mejore todos los PCs**. Está para comparar antes/después.
- **Consecuencia o riesgo práctico:** **Medio (2/4)** — Medio: puede afectar alguna función, compatibilidad, consumo o respuesta.
- **Reversibilidad indicada:** Sí. VSO7 guarda el estado anterior para poder restaurarlo.
- **Metadatos actuales:** riesgo 2/4 · `Experimental` · reinicio `SystemRestart` · auto `Never`.

## 16. Catálogo de aplicaciones

`safe` es candidata conservadora, pero se pierde la app. `optional` depende del usuario. `unsafe` puede afectar Windows y nunca se preselecciona. `SelectedByDefault` no significa instalada. Appx y WinGet son motores diferentes.

| Nº | Aplicación | AppId | Método | Clasificación | Default | Descripción catalogada |
|---:|---|---|---|---|---|---|
| 1 | Clipchamp | `Clipchamp.Clipchamp` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Clipchamp. |
| 2 | 3D Builder | `Microsoft.3DBuilder` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: 3D Builder. |
| 3 | Cortana | `Microsoft.549981C3F5F10` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Cortana. |
| 4 | Bing Finance | `Microsoft.BingFinance` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Finance. |
| 5 | Bing Food And Drink | `Microsoft.BingFoodAndDrink` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Food And Drink. |
| 6 | Bing Health And Fitness | `Microsoft.BingHealthAndFitness` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Health And Fitness. |
| 7 | Bing News | `Microsoft.BingNews` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing News. |
| 8 | Bing Sports | `Microsoft.BingSports` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Sports. |
| 9 | Bing Translator | `Microsoft.BingTranslator` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Translator. |
| 10 | Bing Travel | `Microsoft.BingTravel` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Travel. |
| 11 | Bing Weather | `Microsoft.BingWeather` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bing Weather. |
| 12 | Microsoft Copilot | `XP9CXNGPPJ97XX` | WinGet | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft Copilot. |
| 13 | Copilot+ AI Hub | `Microsoft.Windows.AIHub` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Copilot+ AI Hub. |
| 14 | Microsoft PC Manager | `Microsoft.PCManager` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft PC Manager. |
| 15 | Get Started | `Microsoft.Getstarted` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Get Started. |
| 16 | Messaging | `Microsoft.Messaging` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Messaging. |
| 17 | 3D Viewer | `Microsoft.Microsoft3DViewer` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: 3D Viewer. |
| 18 | Microsoft Journal | `Microsoft.MicrosoftJournal` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft Journal. |
| 19 | Office Hub | `Microsoft.MicrosoftOfficeHub` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Office Hub. |
| 20 | Power BI | `Microsoft.MicrosoftPowerBIForWindows` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Power BI. |
| 21 | Solitaire Collection | `Microsoft.MicrosoftSolitaireCollection` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Solitaire Collection. |
| 22 | Sticky Notes | `Microsoft.MicrosoftStickyNotes` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Sticky Notes. |
| 23 | Mixed Reality Portal | `Microsoft.MixedReality.Portal` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Mixed Reality Portal. |
| 24 | Network Speed Test | `Microsoft.NetworkSpeedTest` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Network Speed Test. |
| 25 | Microsoft News | `Microsoft.News` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft News. |
| 26 | OneNote | `Microsoft.Office.OneNote` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: OneNote. |
| 27 | Sway | `Microsoft.Office.Sway` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Sway. |
| 28 | One Connect | `Microsoft.OneConnect` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: One Connect. |
| 29 | Print 3D | `Microsoft.Print3D` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Print 3D. |
| 30 | Power Automate | `Microsoft.PowerAutomateDesktop` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Power Automate. |
| 31 | Skype (UWP) | `Microsoft.SkypeApp` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Skype (UWP). |
| 32 | Microsoft To Do | `Microsoft.Todos` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft To Do. |
| 33 | Dev Home | `Microsoft.Windows.DevHome` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Dev Home. |
| 34 | Alarms & Clock | `Microsoft.WindowsAlarms` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Alarms & Clock. |
| 35 | Feedback Hub | `Microsoft.WindowsFeedbackHub` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Feedback Hub. |
| 36 | Windows Maps | `Microsoft.WindowsMaps` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Windows Maps. |
| 37 | Sound Recorder | `Microsoft.WindowsSoundRecorder` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Sound Recorder. |
| 38 | Xbox Console Companion | `Microsoft.XboxApp` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Xbox Console Companion. |
| 39 | Movies & TV | `Microsoft.ZuneVideo` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Movies & TV. |
| 40 | Family Safety | `MicrosoftCorporationII.MicrosoftFamily` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Family Safety. |
| 41 | Quick Assist | `MicrosoftCorporationII.QuickAssist` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Quick Assist. |
| 42 | Microsoft Teams (Old) | `MicrosoftTeams` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft Teams (Old). |
| 43 | Microsoft Teams (New) | `MSTeams` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Microsoft Teams (New). |
| 44 | ACG Media Player | `ACGMediaPlayer` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: ACG Media Player. |
| 45 | Actipro Software | `ActiproSoftwareLLC` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Actipro Software. |
| 46 | Adobe Photoshop Express | `AdobeSystemsIncorporated.AdobePhotoshopExpress` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Adobe Photoshop Express. |
| 47 | Amazon | `Amazon.com.Amazon` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Amazon. |
| 48 | Prime Video | `AmazonVideo.PrimeVideo` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Prime Video. |
| 49 | Asphalt 8 | `Asphalt8Airborne` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Asphalt 8. |
| 50 | Autodesk SketchBook | `AutodeskSketchBook` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Autodesk SketchBook. |
| 51 | Caesars Slots | `CaesarsSlotsFreeCasino` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Caesars Slots. |
| 52 | Cooking Fever | `COOKINGFEVER` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Cooking Fever. |
| 53 | CyberLink Media Suite | `CyberLinkMediaSuiteEssentials` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: CyberLink Media Suite. |
| 54 | Disney Magic Kingdoms | `DisneyMagicKingdoms` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Disney Magic Kingdoms. |
| 55 | Disney+ | `Disney.37853FC22B2CE` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Disney+. |
| 56 | Drawboard PDF | `DrawboardPDF` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Drawboard PDF. |
| 57 | Duolingo | `Duolingo-LearnLanguagesforFree` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Duolingo. |
| 58 | Eclipse Manager | `EclipseManager` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Eclipse Manager. |
| 59 | Facebook | `FACEBOOK.FACEBOOK` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Facebook. |
| 60 | FarmVille 2 | `FarmVille2CountryEscape` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: FarmVille 2. |
| 61 | Flipboard | `Flipboard` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Flipboard. |
| 62 | Hidden City | `HiddenCity` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Hidden City. |
| 63 | Hulu | `HULULLC.HULUPLUS` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Hulu. |
| 64 | iHeartRadio | `iHeartRadio` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: iHeartRadio. |
| 65 | Instagram | `Facebook.Instagram` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Instagram. |
| 66 | Bubble Witch 3 | `king.com.BubbleWitch3Saga` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Bubble Witch 3. |
| 67 | Candy Crush Saga | `king.com.CandyCrushSaga` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Candy Crush Saga. |
| 68 | Candy Crush Soda | `king.com.CandyCrushSodaSaga` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Candy Crush Soda. |
| 69 | LinkedIn | `LinkedInforWindows` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: LinkedIn. |
| 70 | March of Empires | `MarchofEmpires` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: March of Empires. |
| 71 | Netflix | `4DF9E0F8.Netflix` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Netflix. |
| 72 | NYT Crossword | `NYTCrossword` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: NYT Crossword. |
| 73 | One Calendar | `OneCalendar` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: One Calendar. |
| 74 | Pandora | `PandoraMediaInc` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Pandora. |
| 75 | Phototastic Collage | `PhototasticCollage` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Phototastic Collage. |
| 76 | PicsArt | `PicsArt-PhotoStudio` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: PicsArt. |
| 77 | Polarr Photo Editor | `PolarrPhotoEditorAcademicEdition` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Polarr Photo Editor. |
| 78 | Royal Revolt | `flaregamesGmbH.RoyalRevolt` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Royal Revolt. |
| 79 | Live Wallpaper | `Sidia.LiveWallpaper` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Live Wallpaper. |
| 80 | Sling TV | `SlingTV` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Sling TV. |
| 81 | Spotify | `SpotifyAB.SpotifyMusic` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: Spotify. |
| 82 | TikTok | `BytedancePte.Ltd.TikTok` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: TikTok. |
| 83 | TuneIn Radio | `TuneInRadio` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: TuneIn Radio. |
| 84 | WinZip | `WinZipUniversal` | Appx | safe | Sí | Paquete opcional de aplicación de Windows: WinZip. |
| 85 | Bing Search | `Microsoft.BingSearch` | Appx | optional | No | Paquete opcional de aplicación de Windows: Bing Search. |
| 86 | Xbox Gaming App | `Microsoft.GamingApp` | Appx | optional | No | Paquete opcional de aplicación de Windows: Xbox Gaming App. |
| 87 | Get Help | `Microsoft.GetHelp` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Get Help. |
| 88 | Microsoft 365 Companions | `Microsoft.M365Companions` | Appx | optional | No | Paquete opcional de aplicación de Windows: Microsoft 365 Companions. |
| 89 | Paint 3D | `Microsoft.MSPaint` | Appx | optional | No | Paquete opcional de aplicación de Windows: Paint 3D. |
| 90 | OneDrive | `Microsoft.OneDrive` | WinGet | optional | No | Paquete opcional de aplicación de Windows: OneDrive. |
| 91 | Outlook for Windows | `Microsoft.OutlookForWindows` | Appx | optional | No | Paquete opcional de aplicación de Windows: Outlook for Windows. |
| 92 | Paint | `Microsoft.Paint` | Appx | optional | No | Paquete opcional de aplicación de Windows: Paint. |
| 93 | People | `Microsoft.People` | Appx | safe | No | Paquete opcional de aplicación de Windows: People. |
| 94 | Remote Desktop | `Microsoft.RemoteDesktop` | Appx | optional | No | Paquete opcional de aplicación de Windows: Remote Desktop. |
| 95 | Snipping Tool | `Microsoft.ScreenSketch` | Appx | optional | No | Paquete opcional de aplicación de Windows: Snipping Tool. |
| 96 | Widgets Experience | `Microsoft.StartExperiencesApp` | Appx | optional | No | Paquete opcional de aplicación de Windows: Widgets Experience. |
| 97 | Whiteboard | `Microsoft.Whiteboard` | Appx | optional | No | Paquete opcional de aplicación de Windows: Whiteboard. |
| 98 | Photos | `Microsoft.Windows.Photos` | Appx | optional | No | Paquete opcional de aplicación de Windows: Photos. |
| 99 | Calculator | `Microsoft.WindowsCalculator` | Appx | optional | No | Paquete opcional de aplicación de Windows: Calculator. |
| 100 | Camera | `Microsoft.WindowsCamera` | Appx | optional | No | Paquete opcional de aplicación de Windows: Camera. |
| 101 | Mail & Calendar | `Microsoft.windowscommunicationsapps` | Appx | safe | No | Paquete opcional de aplicación de Windows: Mail & Calendar. |
| 102 | Notepad | `Microsoft.WindowsNotepad` | Appx | optional | No | Paquete opcional de aplicación de Windows: Notepad. |
| 103 | Microsoft Store | `Microsoft.WindowsStore` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Microsoft Store. |
| 104 | Windows Terminal | `Microsoft.WindowsTerminal` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Windows Terminal. |
| 105 | Xbox TCUI Framework | `Microsoft.Xbox.TCUI` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Xbox TCUI Framework. |
| 106 | Xbox Game Overlay | `Microsoft.XboxGameOverlay` | Appx | optional | No | Paquete opcional de aplicación de Windows: Xbox Game Overlay. |
| 107 | Xbox Gaming Overlay | `Microsoft.XboxGamingOverlay` | Appx | optional | No | Paquete opcional de aplicación de Windows: Xbox Gaming Overlay. |
| 108 | Xbox Identity Provider | `Microsoft.XboxIdentityProvider` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Xbox Identity Provider. |
| 109 | Xbox Speech To Text | `Microsoft.XboxSpeechToTextOverlay` | Appx | unsafe | No | Paquete opcional de aplicación de Windows: Xbox Speech To Text. |
| 110 | Phone Link | `Microsoft.YourPhone` | Appx | optional | No | Paquete opcional de aplicación de Windows: Phone Link. |
| 111 | Media Player | `Microsoft.ZuneMusic` | Appx | optional | No | Paquete opcional de aplicación de Windows: Media Player. |
| 112 | Cross Device Experience | `MicrosoftWindows.CrossDevice` | Appx | optional | No | Paquete opcional de aplicación de Windows: Cross Device Experience. |
| 113 | Windows Web Experience Pack | `MicrosoftWindows.Client.WebExperience` | Appx | optional | No | Paquete opcional de aplicación de Windows: Windows Web Experience Pack. |
| 114 | Widgets Platform Runtime | `Microsoft.WidgetsPlatformRuntime` | Appx | optional | No | Paquete opcional de aplicación de Windows: Widgets Platform Runtime. |
| 115 | LG Monitor App | `LGElectronics.LGMonitorApp` | Appx | optional | No | Paquete opcional de aplicación de Windows: LG Monitor App. |
| 116 | HP AI Experience Center | `AD2F1837.HPAIExperienceCenter` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP AI Experience Center. |
| 117 | HP Connected Music | `AD2F1837.HPConnectedMusic` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Connected Music. |
| 118 | HP Connected Photo | `AD2F1837.HPConnectedPhotopoweredbySnapfish` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Connected Photo. |
| 119 | HP Desktop Support Utilities | `AD2F1837.HPDesktopSupportUtilities` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Desktop Support Utilities. |
| 120 | HP Easy Clean | `AD2F1837.HPEasyClean` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Easy Clean. |
| 121 | HP File Viewer | `AD2F1837.HPFileViewer` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP File Viewer. |
| 122 | HP JumpStarts | `AD2F1837.HPJumpStarts` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP JumpStarts. |
| 123 | HP PC Hardware Diagnostics | `AD2F1837.HPPCHardwareDiagnosticsWindows` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP PC Hardware Diagnostics. |
| 124 | HP Power Manager | `AD2F1837.HPPowerManager` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Power Manager. |
| 125 | HP Printer Control | `AD2F1837.HPPrinterControl` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Printer Control. |
| 126 | HP Privacy Settings | `AD2F1837.HPPrivacySettings` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Privacy Settings. |
| 127 | HP QuickDrop | `AD2F1837.HPQuickDrop` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP QuickDrop. |
| 128 | HP QuickTouch | `AD2F1837.HPQuickTouch` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP QuickTouch. |
| 129 | HP Registration | `AD2F1837.HPRegistration` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Registration. |
| 130 | HP Support Assistant | `AD2F1837.HPSupportAssistant` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Support Assistant. |
| 131 | HP Sure Shield AI | `AD2F1837.HPSureShieldAI` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Sure Shield AI. |
| 132 | HP System Information | `AD2F1837.HPSystemInformation` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP System Information. |
| 133 | HP Welcome | `AD2F1837.HPWelcome` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP Welcome. |
| 134 | HP WorkWell | `AD2F1837.HPWorkWell` | Appx | optional | No | Paquete opcional de aplicación de Windows: HP WorkWell. |
| 135 | myHP | `AD2F1837.myHP` | Appx | optional | No | Paquete opcional de aplicación de Windows: myHP. |
| 136 | Lenovo Vantage | `E046963F.LenovoCompanion` | Appx | optional | No | Paquete opcional de aplicación de Windows: Lenovo Vantage. |
| 137 | Lenovo Vantage Service | `LenovoCompanyLimited.LenovoVantageService` | Appx | optional | No | Paquete opcional de aplicación de Windows: Lenovo Vantage Service. |
| 138 | Dell SupportAssist | `DellInc.DellSupportAssistforPCs` | Appx | optional | No | Paquete opcional de aplicación de Windows: Dell SupportAssist. |
| 139 | Dell Digital Delivery Services | `DellInc.DellDigitalDelivery` | Appx | optional | No | Paquete opcional de aplicación de Windows: Dell Digital Delivery Services. |
| 140 | Dell Mobile Connect | `DellInc.DellMobileConnect` | Appx | optional | No | Paquete opcional de aplicación de Windows: Dell Mobile Connect. |

### Guía práctica de las 140 aplicaciones

La tabla anterior define la identidad y política que usa el código. Esta guía añade el contexto humano de la documentación inicial: qué es cada entrada, si normalmente se quitaría y qué función podría perderse. `SelectedByDefault` expresa la política del catálogo; no demuestra que la aplicación esté instalada.

#### Seguras (86)

##### Clipchamp

- **Identidad:** `Clipchamp.Clipchamp` · `Appx`.
- **Qué es:** editor de vídeo de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### 3D Builder

- **Identidad:** `Microsoft.3DBuilder` · `Appx`.
- **Qué es:** herramienta antigua para modelos e impresión 3D.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Cortana

- **Identidad:** `Microsoft.549981C3F5F10` · `Appx`.
- **Qué es:** el antiguo asistente de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Finance

- **Identidad:** `Microsoft.BingFinance` · `Appx`.
- **Qué es:** noticias y datos financieros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Food And Drink

- **Identidad:** `Microsoft.BingFoodAndDrink` · `Appx`.
- **Qué es:** recetas y contenido de comida.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Health And Fitness

- **Identidad:** `Microsoft.BingHealthAndFitness` · `Appx`.
- **Qué es:** contenido de salud y ejercicio.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing News

- **Identidad:** `Microsoft.BingNews` · `Appx`.
- **Qué es:** noticias.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Sports

- **Identidad:** `Microsoft.BingSports` · `Appx`.
- **Qué es:** noticias y resultados deportivos.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Translator

- **Identidad:** `Microsoft.BingTranslator` · `Appx`.
- **Qué es:** traducción.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Travel

- **Identidad:** `Microsoft.BingTravel` · `Appx`.
- **Qué es:** información de viajes.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bing Weather

- **Identidad:** `Microsoft.BingWeather` · `Appx`.
- **Qué es:** tiempo y previsión.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft Copilot

- **Identidad:** `XP9CXNGPPJ97XX` · `WinGet`.
- **Qué es:** la aplicación de Copilot.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Copilot+ AI Hub

- **Identidad:** `Microsoft.Windows.AIHub` · `Appx`.
- **Qué es:** centro de funciones de IA para equipos compatibles.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft PC Manager

- **Identidad:** `Microsoft.PCManager` · `Appx`.
- **Qué es:** herramientas de mantenimiento de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Get Started

- **Identidad:** `Microsoft.Getstarted` · `Appx`.
- **Qué es:** consejos y bienvenida de Windows.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Messaging

- **Identidad:** `Microsoft.Messaging` · `Appx`.
- **Qué es:** la antigua aplicación de mensajería.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### 3D Viewer

- **Identidad:** `Microsoft.Microsoft3DViewer` · `Appx`.
- **Qué es:** visor de modelos 3D.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft Journal

- **Identidad:** `Microsoft.MicrosoftJournal` · `Appx`.
- **Qué es:** notas escritas a mano.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Office Hub

- **Identidad:** `Microsoft.MicrosoftOfficeHub` · `Appx`.
- **Qué es:** accesos y promoción de Microsoft 365.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Power BI

- **Identidad:** `Microsoft.MicrosoftPowerBIForWindows` · `Appx`.
- **Qué es:** visualización de informes de Power BI.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Solitaire Collection

- **Identidad:** `Microsoft.MicrosoftSolitaireCollection` · `Appx`.
- **Qué es:** juegos de cartas de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Sticky Notes

- **Identidad:** `Microsoft.MicrosoftStickyNotes` · `Appx`.
- **Qué es:** Notas rápidas.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Mixed Reality Portal

- **Identidad:** `Microsoft.MixedReality.Portal` · `Appx`.
- **Qué es:** portal de realidad mixta.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Network Speed Test

- **Identidad:** `Microsoft.NetworkSpeedTest` · `Appx`.
- **Qué es:** prueba de velocidad de red.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft News

- **Identidad:** `Microsoft.News` · `Appx`.
- **Qué es:** noticias de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### OneNote

- **Identidad:** `Microsoft.Office.OneNote` · `Appx`.
- **Qué es:** notas de OneNote.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Sway

- **Identidad:** `Microsoft.Office.Sway` · `Appx`.
- **Qué es:** presentaciones/páginas de Sway.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### One Connect

- **Identidad:** `Microsoft.OneConnect` · `Appx`.
- **Qué es:** aplicación antigua de conectividad.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Print 3D

- **Identidad:** `Microsoft.Print3D` · `Appx`.
- **Qué es:** impresión 3D.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Power Automate

- **Identidad:** `Microsoft.PowerAutomateDesktop` · `Appx`.
- **Qué es:** automatización de tareas.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Skype (UWP)

- **Identidad:** `Microsoft.SkypeApp` · `Appx`.
- **Qué es:** versión antigua de Skype.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft To Do

- **Identidad:** `Microsoft.Todos` · `Appx`.
- **Qué es:** listas y tareas.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Dev Home

- **Identidad:** `Microsoft.Windows.DevHome` · `Appx`.
- **Qué es:** panel para desarrollo.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Alarms & Clock

- **Identidad:** `Microsoft.WindowsAlarms` · `Appx`.
- **Qué es:** alarmas, reloj y temporizadores.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Feedback Hub

- **Identidad:** `Microsoft.WindowsFeedbackHub` · `Appx`.
- **Qué es:** enviar comentarios a Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Windows Maps

- **Identidad:** `Microsoft.WindowsMaps` · `Appx`.
- **Qué es:** mapas.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Sound Recorder

- **Identidad:** `Microsoft.WindowsSoundRecorder` · `Appx`.
- **Qué es:** grabación de sonido.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Xbox Console Companion

- **Identidad:** `Microsoft.XboxApp` · `Appx`.
- **Qué es:** antigua app complementaria de Xbox.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Movies & TV

- **Identidad:** `Microsoft.ZuneVideo` · `Appx`.
- **Qué es:** reproductor de vídeo de Microsoft.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Family Safety

- **Identidad:** `MicrosoftCorporationII.MicrosoftFamily` · `Appx`.
- **Qué es:** controles familiares.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Quick Assist

- **Identidad:** `MicrosoftCorporationII.QuickAssist` · `Appx`.
- **Qué es:** asistencia remota.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft Teams (Old)

- **Identidad:** `MicrosoftTeams` · `Appx`.
- **Qué es:** versión antigua de Teams.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Microsoft Teams (New)

- **Identidad:** `MSTeams` · `Appx`.
- **Qué es:** aplicación de Teams.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### ACG Media Player

- **Identidad:** `ACGMediaPlayer` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Actipro Software

- **Identidad:** `ActiproSoftwareLLC` · `Appx`.
- **Qué es:** paquete/aplicación de terceros de Actipro.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Adobe Photoshop Express

- **Identidad:** `AdobeSystemsIncorporated.AdobePhotoshopExpress` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Amazon

- **Identidad:** `Amazon.com.Amazon` · `Appx`.
- **Qué es:** app de compras de Amazon.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Prime Video

- **Identidad:** `AmazonVideo.PrimeVideo` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Asphalt 8

- **Identidad:** `Asphalt8Airborne` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Autodesk SketchBook

- **Identidad:** `AutodeskSketchBook` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Caesars Slots

- **Identidad:** `CaesarsSlotsFreeCasino` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Cooking Fever

- **Identidad:** `COOKINGFEVER` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### CyberLink Media Suite

- **Identidad:** `CyberLinkMediaSuiteEssentials` · `Appx`.
- **Qué es:** herramientas multimedia de CyberLink.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Disney Magic Kingdoms

- **Identidad:** `DisneyMagicKingdoms` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Disney+

- **Identidad:** `Disney.37853FC22B2CE` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Drawboard PDF

- **Identidad:** `DrawboardPDF` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Duolingo

- **Identidad:** `Duolingo-LearnLanguagesforFree` · `Appx`.
- **Qué es:** aprendizaje de idiomas.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Eclipse Manager

- **Identidad:** `EclipseManager` · `Appx`.
- **Qué es:** aplicación de terceros llamada Eclipse Manager.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Facebook

- **Identidad:** `FACEBOOK.FACEBOOK` · `Appx`.
- **Qué es:** red social o contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### FarmVille 2

- **Identidad:** `FarmVille2CountryEscape` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Flipboard

- **Identidad:** `Flipboard` · `Appx`.
- **Qué es:** red social o contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Hidden City

- **Identidad:** `HiddenCity` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Hulu

- **Identidad:** `HULULLC.HULUPLUS` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### iHeartRadio

- **Identidad:** `iHeartRadio` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Instagram

- **Identidad:** `Facebook.Instagram` · `Appx`.
- **Qué es:** red social o contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Bubble Witch 3

- **Identidad:** `king.com.BubbleWitch3Saga` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Candy Crush Saga

- **Identidad:** `king.com.CandyCrushSaga` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Candy Crush Soda

- **Identidad:** `king.com.CandyCrushSodaSaga` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### LinkedIn

- **Identidad:** `LinkedInforWindows` · `Appx`.
- **Qué es:** red social o contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### March of Empires

- **Identidad:** `MarchofEmpires` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Netflix

- **Identidad:** `4DF9E0F8.Netflix` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### NYT Crossword

- **Identidad:** `NYTCrossword` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### One Calendar

- **Identidad:** `OneCalendar` · `Appx`.
- **Qué es:** calendario de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Pandora

- **Identidad:** `PandoraMediaInc` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Phototastic Collage

- **Identidad:** `PhototasticCollage` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### PicsArt

- **Identidad:** `PicsArt-PhotoStudio` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Polarr Photo Editor

- **Identidad:** `PolarrPhotoEditorAcademicEdition` · `Appx`.
- **Qué es:** aplicación “Polarr Photo Editor”.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Royal Revolt

- **Identidad:** `flaregamesGmbH.RoyalRevolt` · `Appx`.
- **Qué es:** juego o entretenimiento de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Live Wallpaper

- **Identidad:** `Sidia.LiveWallpaper` · `Appx`.
- **Qué es:** edición o creación de contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Sling TV

- **Identidad:** `SlingTV` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### Spotify

- **Identidad:** `SpotifyAB.SpotifyMusic` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### TikTok

- **Identidad:** `BytedancePte.Ltd.TikTok` · `Appx`.
- **Qué es:** red social o contenido de terceros.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### TuneIn Radio

- **Identidad:** `TuneInRadio` · `Appx`.
- **Qué es:** reproducción o streaming multimedia.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### WinZip

- **Identidad:** `WinZipUniversal` · `Appx`.
- **Qué es:** compresión y apertura de archivos.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `Sí`.

##### People

- **Identidad:** `Microsoft.People` · `Appx`.
- **Qué es:** contactos.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `No`.

##### Mail & Calendar

- **Identidad:** `Microsoft.windowscommunicationsapps` · `Appx`.
- **Qué es:** antiguas apps de correo y calendario.
- **Criterio práctico:** Sí, si no la usas. No es necesaria para el funcionamiento básico de Windows.
- **Qué se puede perder:** Bajo: pierdes principalmente esa aplicación y sus funciones.
- **Política actual:** `safe` · default `No`.

#### Opcionales (48)

##### Bing Search

- **Identidad:** `Microsoft.BingSearch` · `Appx`.
- **Qué es:** resultados web de Bing integrados en Windows.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Xbox Gaming App

- **Identidad:** `Microsoft.GamingApp` · `Appx`.
- **Qué es:** Xbox y Game Pass para PC.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes la app Xbox y acceso cómodo a Game Pass para PC.
- **Política actual:** `optional` · default `No`.

##### Microsoft 365 Companions

- **Identidad:** `Microsoft.M365Companions` · `Appx`.
- **Qué es:** pequeñas apps ligadas a Microsoft 365.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Paint 3D

- **Identidad:** `Microsoft.MSPaint` · `Appx`.
- **Qué es:** editor 3D de Microsoft.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### OneDrive

- **Identidad:** `Microsoft.OneDrive` · `WinGet`.
- **Qué es:** sincronización de archivos con OneDrive.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Comprueba antes si Escritorio, Documentos o Fotos están sincronizados: la sincronización se detendrá.
- **Política actual:** `optional` · default `No`.

##### Outlook for Windows

- **Identidad:** `Microsoft.OutlookForWindows` · `Appx`.
- **Qué es:** correo y calendario de Outlook.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Paint

- **Identidad:** `Microsoft.Paint` · `Appx`.
- **Qué es:** editor básico de imágenes/dibujo.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Necesitarás otra app para dibujo/edición básica.
- **Política actual:** `optional` · default `No`.

##### Remote Desktop

- **Identidad:** `Microsoft.RemoteDesktop` · `Appx`.
- **Qué es:** cliente de Escritorio remoto.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes ese cliente de conexión remota.
- **Política actual:** `optional` · default `No`.

##### Snipping Tool

- **Identidad:** `Microsoft.ScreenSketch` · `Appx`.
- **Qué es:** capturas y grabación de pantalla.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes la herramienta integrada de capturas y grabación de pantalla.
- **Política actual:** `optional` · default `No`.

##### Widgets Experience

- **Identidad:** `Microsoft.StartExperiencesApp` · `Appx`.
- **Qué es:** experiencia de Widgets.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Whiteboard

- **Identidad:** `Microsoft.Whiteboard` · `Appx`.
- **Qué es:** pizarra colaborativa.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Photos

- **Identidad:** `Microsoft.Windows.Photos` · `Appx`.
- **Qué es:** visor y editor de fotos.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Necesitarás otro visor de imágenes.
- **Política actual:** `optional` · default `No`.

##### Calculator

- **Identidad:** `Microsoft.WindowsCalculator` · `Appx`.
- **Qué es:** calculadora.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Necesitarás otra calculadora.
- **Política actual:** `optional` · default `No`.

##### Camera

- **Identidad:** `Microsoft.WindowsCamera` · `Appx`.
- **Qué es:** cámara/webcam.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes la aplicación integrada de cámara.
- **Política actual:** `optional` · default `No`.

##### Notepad

- **Identidad:** `Microsoft.WindowsNotepad` · `Appx`.
- **Qué es:** editor de texto simple.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Necesitarás otro editor de texto.
- **Política actual:** `optional` · default `No`.

##### Xbox Game Overlay

- **Identidad:** `Microsoft.XboxGameOverlay` · `Appx`.
- **Qué es:** parte de la superposición Xbox en juegos.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Puedes perder partes de Game Bar.
- **Política actual:** `optional` · default `No`.

##### Xbox Gaming Overlay

- **Identidad:** `Microsoft.XboxGamingOverlay` · `Appx`.
- **Qué es:** Xbox Game Bar.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Puedes perder Game Bar, capturas y widgets Xbox.
- **Política actual:** `optional` · default `No`.

##### Phone Link

- **Identidad:** `Microsoft.YourPhone` · `Appx`.
- **Qué es:** conexión del PC con el móvil.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes la integración con el móvil.
- **Política actual:** `optional` · default `No`.

##### Media Player

- **Identidad:** `Microsoft.ZuneMusic` · `Appx`.
- **Qué es:** reproductor multimedia.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Necesitarás otro reproductor multimedia.
- **Política actual:** `optional` · default `No`.

##### Cross Device Experience

- **Identidad:** `MicrosoftWindows.CrossDevice` · `Appx`.
- **Qué es:** funciones entre varios dispositivos.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Windows Web Experience Pack

- **Identidad:** `MicrosoftWindows.Client.WebExperience` · `Appx`.
- **Qué es:** componentes web usados por Widgets y otras partes de Windows.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Puede afectar Widgets y otras partes de Windows.
- **Política actual:** `optional` · default `No`.

##### Widgets Platform Runtime

- **Identidad:** `Microsoft.WidgetsPlatformRuntime` · `Appx`.
- **Qué es:** motor necesario para Widgets.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Los Widgets pueden dejar de funcionar.
- **Política actual:** `optional` · default `No`.

##### LG Monitor App

- **Identidad:** `LGElectronics.LGMonitorApp` · `Appx`.
- **Qué es:** utilidades para monitores LG.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP AI Experience Center

- **Identidad:** `AD2F1837.HPAIExperienceCenter` · `Appx`.
- **Qué es:** funciones de IA de HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Connected Music

- **Identidad:** `AD2F1837.HPConnectedMusic` · `Appx`.
- **Qué es:** antigua app multimedia de HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Connected Photo

- **Identidad:** `AD2F1837.HPConnectedPhotopoweredbySnapfish` · `Appx`.
- **Qué es:** antigua app de fotos de HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Desktop Support Utilities

- **Identidad:** `AD2F1837.HPDesktopSupportUtilities` · `Appx`.
- **Qué es:** utilidades de soporte HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Easy Clean

- **Identidad:** `AD2F1837.HPEasyClean` · `Appx`.
- **Qué es:** bloqueo temporal de entrada para poder limpiar el equipo.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP File Viewer

- **Identidad:** `AD2F1837.HPFileViewer` · `Appx`.
- **Qué es:** visor de archivos HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP JumpStarts

- **Identidad:** `AD2F1837.HPJumpStarts` · `Appx`.
- **Qué es:** bienvenida/promociones de HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP PC Hardware Diagnostics

- **Identidad:** `AD2F1837.HPPCHardwareDiagnosticsWindows` · `Appx`.
- **Qué es:** diagnóstico de hardware HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Power Manager

- **Identidad:** `AD2F1837.HPPowerManager` · `Appx`.
- **Qué es:** controles de batería/energía HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Puedes perder controles específicos de batería/carga HP.
- **Política actual:** `optional` · default `No`.

##### HP Printer Control

- **Identidad:** `AD2F1837.HPPrinterControl` · `Appx`.
- **Qué es:** controles de impresora HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Si usas impresora HP, puedes perder controles de esa app.
- **Política actual:** `optional` · default `No`.

##### HP Privacy Settings

- **Identidad:** `AD2F1837.HPPrivacySettings` · `Appx`.
- **Qué es:** ajustes de privacidad HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP QuickDrop

- **Identidad:** `AD2F1837.HPQuickDrop` · `Appx`.
- **Qué es:** transferencia rápida de archivos HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP QuickTouch

- **Identidad:** `AD2F1837.HPQuickTouch` · `Appx`.
- **Qué es:** funciones rápidas de algunos equipos HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Registration

- **Identidad:** `AD2F1837.HPRegistration` · `Appx`.
- **Qué es:** registro del equipo con HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Support Assistant

- **Identidad:** `AD2F1837.HPSupportAssistant` · `Appx`.
- **Qué es:** soporte, diagnóstico y actualizaciones HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes el flujo de soporte/actualizaciones de HP; Windows Update sigue funcionando.
- **Política actual:** `optional` · default `No`.

##### HP Sure Shield AI

- **Identidad:** `AD2F1837.HPSureShieldAI` · `Appx`.
- **Qué es:** funciones de seguridad HP compatibles.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP System Information

- **Identidad:** `AD2F1837.HPSystemInformation` · `Appx`.
- **Qué es:** información del sistema HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP Welcome

- **Identidad:** `AD2F1837.HPWelcome` · `Appx`.
- **Qué es:** pantalla de bienvenida HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### HP WorkWell

- **Identidad:** `AD2F1837.HPWorkWell` · `Appx`.
- **Qué es:** herramientas de bienestar HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### myHP

- **Identidad:** `AD2F1837.myHP` · `Appx`.
- **Qué es:** panel de funciones y soporte HP.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Lenovo Vantage

- **Identidad:** `E046963F.LenovoCompanion` · `Appx`.
- **Qué es:** ajustes, batería, firmware y soporte Lenovo.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Puedes perder controles de batería, carga, modos térmicos o actualizaciones de Lenovo.
- **Política actual:** `optional` · default `No`.

##### Lenovo Vantage Service

- **Identidad:** `LenovoCompanyLimited.LenovoVantageService` · `Appx`.
- **Qué es:** servicio necesario para varias funciones de Lenovo Vantage.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Lenovo Vantage puede dejar de funcionar correctamente.
- **Política actual:** `optional` · default `No`.

##### Dell SupportAssist

- **Identidad:** `DellInc.DellSupportAssistforPCs` · `Appx`.
- **Qué es:** soporte, diagnóstico y actualizaciones Dell.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Atención adicional:** Pierdes el soporte/diagnóstico/actualizador de Dell; Windows Update sigue funcionando.
- **Política actual:** `optional` · default `No`.

##### Dell Digital Delivery Services

- **Identidad:** `DellInc.DellDigitalDelivery` · `Appx`.
- **Qué es:** descarga de software incluido/comprado con Dell.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

##### Dell Mobile Connect

- **Identidad:** `DellInc.DellMobileConnect` · `Appx`.
- **Qué es:** conexión móvil-PC de Dell.
- **Criterio práctico:** Solo si sabes que no la necesitas. VSO7 no la selecciona automáticamente.
- **Qué se puede perder:** Medio: puedes perder una función de Windows o del fabricante que sí uses.
- **Política actual:** `optional` · default `No`.

#### No recomendadas (6)

##### Get Help

- **Identidad:** `Microsoft.GetHelp` · `Appx`.
- **Qué es:** soporte y ayuda de Windows.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Pierdes la aplicación integrada de soporte.
- **Política actual:** `unsafe` · default `No`.

##### Microsoft Store

- **Identidad:** `Microsoft.WindowsStore` · `Appx`.
- **Qué es:** tienda y actualización de aplicaciones.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Puede complicar bastante instalar y actualizar aplicaciones de Microsoft.
- **Política actual:** `unsafe` · default `No`.

##### Windows Terminal

- **Identidad:** `Microsoft.WindowsTerminal` · `Appx`.
- **Qué es:** terminal moderna de Windows.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Puedes perder la terminal moderna usada por PowerShell, CMD y herramientas de desarrollo.
- **Política actual:** `unsafe` · default `No`.

##### Xbox TCUI Framework

- **Identidad:** `Microsoft.Xbox.TCUI` · `Appx`.
- **Qué es:** parte del inicio de sesión e interfaz de Xbox usada por juegos.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Algunos juegos pueden perder diálogos o funciones Xbox.
- **Política actual:** `unsafe` · default `No`.

##### Xbox Identity Provider

- **Identidad:** `Microsoft.XboxIdentityProvider` · `Appx`.
- **Qué es:** inicio de sesión e identidad Xbox.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Puede romper inicio de sesión Xbox, Game Pass y juegos que usan esa identidad.
- **Política actual:** `unsafe` · default `No`.

##### Xbox Speech To Text

- **Identidad:** `Microsoft.XboxSpeechToTextOverlay` · `Appx`.
- **Qué es:** funciones de voz/texto de Xbox.
- **Criterio práctico:** Yo no la quitaría salvo que sepas exactamente qué depende de ella.
- **Qué se puede perder:** Alto: puede romper otras funciones o aplicaciones.
- **Atención adicional:** Puede romper funciones de voz/accesibilidad Xbox.
- **Política actual:** `unsafe` · default `No`.

## 17. Perfiles (`14 → 9`)

Los perfiles son JSON de datos, sin comandos ni scriptblocks. Se puede exportar la última selección, crear por IDs, importar/preview o importar/aplicar. La aplicación revalida IDs, aplicabilidad, alto riesgo, apps y Recovery. Un perfil válido puede no ser aplicable a otro PC. Las apps exigen `ELIMINAR APPS`.

## 18. Fondos e idioma

Fondos: Disabled, Plasma, Matrix Rain, Starfield, Rotating Galaxy, Tunnel, Kaleidoscope, Radio Waves, Rain Drops, Horizon, Fire, Flame Fire, Fireworks, Bouncing Balls, Spinning Donut, Spinning Shapes y Random. Random es default nuevo; la preferencia guardada prevalece. `Ctrl+F` congela/reanuda en prompts compatibles.

English es idioma inicial limpio. Español se guarda. Algunos textos heredados pueden seguir en un idioma sin cambiar lógica.

## 19. Mensajes frecuentes

- **No applicable pending items:** nada pendiente cumple policy/aplicabilidad; puede estar ya óptimo.
- **OK:** estado satisfecho, no acción pendiente.
- **Already applied:** Recovery compatible ya posee el cambio.
- **Recovery already owns target:** revisar/restaurar bundle si el estado difiere o es ambiguo.
- **Pending restart:** existe una señal estructurada; el mensaje debe indicar cuál.
- **PendingAppRestart:** configuración verificada, efecto pendiente de reiniciar app.
- **AdapterRestart:** corte breve posible.
- **Unknown:** VSO no adivina; excluye de automatización.

## 20. Mapa de código para una IA o mantenedor

| Área | Funciones |
|---|---|
| Principal | `Show-Menu` |
| Auto consola | `Get-VSO7ConsoleAutomaticAppRowsVSO`, `Get-VSO7ConsoleAutomaticPlanVSO`, `Show-VSO7ConsoleAutomaticVSO` |
| Recomendación | `Test-VSO7RecommendationAutoCandidateVSO`, `Get-VSO7RecommendedOptimizationPlanVSO` |
| Objetivos | `Select-VSO7RecommendedObjectiveVSO`, `Show-VSO7RecommendedOptimizationVSO` |
| Extrema | `Get-VSOExtremeTweaks`, `Show-ExtremeOptimizer` |
| GPU | `Show-VSO7GraphicsMenuVSO`, `Show-VSO7PerAppGraphicsMenuVSO`, `Show-VSO7GraphicsDiagnosticsVSO` |
| Windows | `Show-VSO7WindowsFeatures`, `Show-VSO7FeatureCategoryVSO`, `Show-VSO7GroupedWindowsChoicesVSO` |
| Apps | `Show-VSO7AppSelectorVSO`, `Show-VSO7ManualAppSelectorVSO` |
| Gaming | `Show-VSO7GamingSelector`, `Invoke-VSO7GamingSession` |
| Diagnóstico | `Show-VSO7AdvancedTuningDiagnostics`, `Show-VSO7LatencyHardwareLabVSO` |
| Herramientas | `Show-SpecificTools`, `Show-VSO7SystemTools` |
| Perfiles | `Show-VSO7ConfigurationProfilesVSO` |
| Seguridad/Recovery | `Initialize-VSO7SecureStateStorage`, `Get-VSO7RecoveryAuthKeyVSO` |

Una IA debe tratar FeatureId/AppId como identidad, distinguir selección/preview/preflight/apply/verify/recovery, consultar policy y primitivas JSON, no inferir rendimiento por el nombre, respetar reinicios/ownership/drift, y fallar cerrado ante evidencia desconocida.

## 21. Limitaciones actuales

- GUI no es interfaz pública soportada.
- El manual de apps marca 84 safe/default sin inventario; el automático sí filtra Appx detectadas.
- Algunas features seleccionables carecen de selector manual global y entran por recomendación/perfil.
- Diagnósticos dependen de Windows, firmware y drivers; unavailable no significa hardware roto.
- Apps, cachés y Special pueden no ser reversibles.
- Un restore point no sustituye backup de datos.

