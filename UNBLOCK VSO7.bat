@echo off
setlocal
cd /d "%~dp0"
set "VSO7_ROOT=%~dp0"
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%PS%" (
  echo [ERROR] Windows PowerShell was not found.
  pause
  exit /b 1
)

echo Unblocking the PowerShell scripts included with VSO7...
"%PS%" -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$root=$env:VSO7_ROOT; foreach($file in @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.ps1' -ErrorAction Stop)){ Unblock-File -LiteralPath $file.FullName -ErrorAction Stop }"
if errorlevel 1 (
  echo.
  echo [ERROR] One or more PowerShell scripts could not be unblocked.
  pause
  exit /b 1
)

echo.
echo [OK] The PowerShell scripts were unblocked. You can now run START VSO7.bat.
pause
exit /b 0
