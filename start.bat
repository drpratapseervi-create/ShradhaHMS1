@echo off
title Shradha HMS Server (Shradha Hospital)
echo ======================================
echo   STARTING SHRADHA HMS SERVER
echo ======================================
echo.
REM Go to project root (where this bat file is)
cd /d "%~dp0"
REM Activate virtual environment
if exist ".venv_new\Scripts\activate.bat" (
    echo Activating virtual environment...
    call ".venv_new\Scripts\activate.bat"
) else (
    echo ERROR: Virtual environment not found!
    pause
    exit /b
)
REM Move to folder where manage.py exists
cd ShradhaHMS_Full
echo Current directory:
cd
echo.
REM Ensure waitress is installed (Windows-safe)
python -m pip install --quiet waitress
echo Starting HMS server on http://127.0.0.1:8000
echo DO NOT CLOSE THIS WINDOW
echo.
REM Open Chrome automatically once the server is up
start "" cmd /c "timeout /t 3 /nobreak >nul && start chrome http://127.0.0.1:8000"
python -m waitress --port=8000 ShradhaHMS.wsgi:application
pause