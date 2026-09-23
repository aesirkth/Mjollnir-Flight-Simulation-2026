@echo off
cd /d "%~dp0"

echo ======================================
echo Setting up MatRocketCAD environment
echo ======================================


set FREECAD_URL=https://github.com/FreeCAD/FreeCAD/releases/download/1.0.2/FreeCAD_1.0.2-conda-Windows-x86_64-py311.7z
set FREECAD_ARCHIVE=Core\MatRocketCAD\freecad.7z
set FREECAD_TARGET=Core\MatRocketCAD
set FREECAD_DIR=%FREECAD_TARGET%\FreeCAD_1.0.2-conda-Windows-x86_64-py311
set SEVENZIP=Core\MatRocketCAD\7za920\7za.exe


REM Create target folder if missing
if not exist %FREECAD_TARGET% (
    mkdir %FREECAD_TARGET%
)

REM Download FreeCAD if missing
if not exist %FREECAD_ARCHIVE% (
    echo Downloading FreeCAD...
    powershell -Command "Invoke-WebRequest -Uri '%FREECAD_URL%' -OutFile '%FREECAD_ARCHIVE%'"
)



REM Extract FreeCAD
if not exist %FREECAD_TARGET%\FreeCAD (
    echo Extracting FreeCAD...
    %SEVENZIP% x %FREECAD_ARCHIVE% -o%FREECAD_TARGET%
)


REM Check installation
if not exist %FREECAD_DIR%\bin\python.exe (
    echo ERROR: FreeCAD extraction failed.
    pause
    exit /b
)

REM Install dependencies
set PYTHON=%FREECAD_DIR%\bin\python.exe

echo Installing Python dependencies...
%PYTHON% -m pip install --upgrade pip
%PYTHON% -m pip install -r requirements.txt

echo.
echo Setup complete!
pause