@echo off
setlocal
cd /d "%~dp0"
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%PS%" (
  echo [ERROR] Windows PowerShell was not found.
  pause
  exit /b 1
)

"%PS%" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Tools\VSO7_STARTUP_GATE.ps1" -Root "%~dp0." -Mode CLI
if errorlevel 1 (
  echo.
  echo [ERROR] VSO7 did not start because the startup gate failed.
  echo         Review the STARTUP GATE error shown above.
  pause
  exit /b 1
)

"%PS%" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0VSO7.ps1"
set "VSO7_EXIT=%ERRORLEVEL%"
if not "%VSO7_EXIT%"=="0" (
  echo.
  echo [ERROR] VSO7 exited with code %VSO7_EXIT%.
  echo         This window will remain open so you can read the error above.
  pause
)
exit /b %VSO7_EXIT%
