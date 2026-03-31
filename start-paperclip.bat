@echo off
title Paperclip - AI Agent Platform
cd /d E:\Development\paperclip

echo Cleaning up old processes...
powershell -Command "Get-Process -Name postgres -ErrorAction SilentlyContinue | Stop-Process -Force" 2>nul
timeout /t 3 /nobreak >nul

echo Starting Paperclip...
echo.
echo Dashboard will open at http://localhost:3100
echo Press Ctrl+C to stop the server
echo.

:: Open browser after a delay (in background)
start /b "" powershell -WindowStyle Hidden -Command "Start-Sleep -Seconds 20; Start-Process 'http://localhost:3100'"

:: Start the server as the current user (non-admin)
node scripts/dev-runner.mjs watch
