@echo off
REM start.bat — Shradha Hospital Django project launcher (Windows)

cd /d "%~dp0"
echo Current folder: %CD%
echo.

REM Activate virtual environment if present
if exist ".venv\Scripts\activate.bat" (
    echo Activating virtual environment...
    call ".venv\Scripts\activate.bat"
) else (
    echo No .venv detected, using system Python.
)

REM Set path to your Django package parent (adjust if different)
set "PKG_PARENT=%CD%\ShradhaHMS_Full"

REM Add parent folder to Python path
set "PYTHONPATH=%PKG_PARENT%;%PYTHONPATH%"
echo PYTHONPATH set to: %PYTHONPATH%

REM Set Django settings module
set "DJANGO_SETTINGS_MODULE=ShradhaHMS.settings"
echo DJANGO_SETTINGS_MODULE=%DJANGO_SETTINGS_MODULE%

REM Optional: show which python will run (for debugging)
python -c "import sys; print('Python executable:', sys.executable)"

REM Ensure waitress is installed
python - <<PYCHECK
import pkgutil, sys
if pkgutil.find_loader('waitress') is None:
    sys.exit(1)
PYCHECK
if %ERRORLEVEL% NEQ 0 (
    echo Installing waitress...
    python -m pip install waitress
)

REM Start Django WSGI app using Waitress
echo Starting ShradhaHMS on port 8000...
waitress-serve --port=8000 ShradhaHMS.wsgi:application

pause
