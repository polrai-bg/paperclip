@echo off
title Paperclip - AI Agent Platform
cd /d E:\Development\paperclip

echo Cleaning up old processes...
powershell -Command "Get-Process -Name postgres -ErrorAction SilentlyContinue | Stop-Process -Force" 2>/dev/null
timeout /t 3 /nobreak >/dev/null

echo Starting PostgreSQL...
"E:\Development\paperclip\node_modules\.pnpm\@embedded-postgres+windows-x64@18.1.0-beta.16\node_modules\@embedded-postgres\windows-x64\native\bin\pg_ctl.exe" start -D "C:\Users\POLR AI\.paperclip\instances\default\db" -o "-p 54329 -k \"\"" -l "C:\Users\POLR AI\.paperclip\instances\default\logs\pg.log"
timeout /t 3 /nobreak >/dev/null

echo Starting Paperclip...
echo.
echo Dashboard will open at http://localhost:3100
echo Press Ctrl+C to stop the server
echo.

:: Open browser after a delay (in background)
start /b "" powershell -WindowStyle Hidden -Command "Start-Sleep -Seconds 20; Start-Process 'http://localhost:3100'"

:: Start the server with DATABASE_URL pointing to our manually-started postgres
set DATABASE_URL=postgres://paperclip:paperclip@127.0.0.1:54329/paperclip
node scripts/dev-runner.mjs watch
