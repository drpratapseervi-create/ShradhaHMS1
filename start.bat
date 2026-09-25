@echo off
title Shradha HMS Server (Shradha Hospital)
echo ======================================
echo   STARTING SHRADHA HMS SERVER
echo ======================================
echo.
REM Go to project root (where this bat file is)
cd /d "%~dp0"

REM Move to folder where manage.py exists
cd ShradhaHMS_Full
echo Current directory:
cd
echo.

REM Activate virtual environment
if exist ".venv_new\Scripts\activate.bat" (
    echo Activating virtual environment...
    call ".venv_new\Scripts\activate.bat"
) else (
    echo ERROR: Virtual environment not found!
    pause
    exit /b
)

REM Stop any server already on port 8000 (old waitress/runserver) so two don't compete
powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'python.exe' -and ($_.CommandLine -like '*port=8000*' -or $_.CommandLine -like '*runserver*') } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"

echo Starting HMS server on http://127.0.0.1:8000
echo DO NOT CLOSE THIS WINDOW
echo.

REM Open Chrome automatically once the server is up
start "" cmd /c "timeout /t 3 /nobreak >nul && start chrome http://127.0.0.1:8000"
REM runserver auto-reloads on code changes; 0.0.0.0 keeps it reachable from other PCs on the LAN
python manage.py runserver 0.0.0.0:8000
pause