@echo off
rem Runs download-figma-assets.ps1 using the PowerShell that ships with Windows.
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0download-figma-assets.ps1"
pause
