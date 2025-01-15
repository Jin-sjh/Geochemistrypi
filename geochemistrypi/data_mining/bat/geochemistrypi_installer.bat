::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDFdQjimOXixEroM1LnEvb/Ruh9IAqw2e4C7
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVsEAlPMbAs=
::ZQ05rAF9IAHYFVzEqQIXLRRXRAGPNXiuFKwM4Yg=
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWGOuwX0VKQlARDumPX+7Zg==
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDFdQjimOXixEroM1O/+4OmPp0AUR/YtYZ/S5b2AM/QS5knhZ9gozn86
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "current_dir=%~dp0"

where conda >nul 2>&1
if %errorlevel% equ 0 (
    echo Conda is already installed.
    goto :end
) else (
    echo Conda is not installed. Installing now...
)
    
if "%~1"=="" (
        echo  Install Software: %~nx0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_24.9.2-0-Windows-x86_64.exe
    )
    
    set url=https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_24.9.2-0-Windows-x86_64.exe

    if "%~2"=="" (
        set "install_path=%current_dir%"
    ) else (
        set "install_path=%~2"
    )

    set installer=Miniconda3-py39_24.9.2-0-Windows-x86_64.exe

    if not exist "!install_path!" (
        echo Creating directory: !install_path!
        mkdir "!install_path!"
    )
    echo URL: !url!
    echo Installer: !installer!
    echo Downloading Anaconda installer...
    bitsadmin  /transfer Download_conda  /download /priority FOREGROUND "!url!" "!install_path!\!installer!"
    
    echo Installing Anaconda...
    start /wait "" "!install_path!\!installer!" /D=!install_path!
    
    del "!install_path!\!installer!"
    
    echo Anaconda installation complete.
    goto :end
)


:end
set ENVIRONMENTNAME=GeoUI

where activate >nul 2>&1
if %errorlevel% neq 0 (
    echo activate is not installed or not in the PATH.
    exit /b 1
) else (
    echo Activate is available.
    for /f "tokens=*" %%i in ('where activate') do set "ActivatePATH=%%i"
    echo ActivatePATH is !ActivatePATH!
)

call conda info --envs | findstr /C:!ENVIRONMENTNAME!  >nul
if %errorlevel% equ 0 (
    echo Environment !ENVIRONMENTNAME! already exists.
    call conda activate GeoUI
    goto :NEXT
) else (
    echo Environment !ENVIRONMENTNAME! does not exist. Creating...
    :INSTALL
    call conda create -n !ENVIRONMENTNAME! python=3.9 -y
    if %errorlevel% neq 0 (
        echo Error: Failed to create conda environment.
	goto :INSTALL
        exit /b 1
    )
)

call conda activate !ENVIRONMENTNAME!
if %errorlevel% equ 0 (
    echo Environment !ENVIRONMENTNAME! activated successfully.
) else (
    echo Error: Failed to activate conda environment.
    pause
    exit /b %errorlevel%
)

echo Online installation is underway...
pip install geochemistrypi
if %errorlevel% equ 0 (
    echo geochemistrypi installed successfully.
) else (
    echo Error: Failed to install geochemistrypi.
    pause
    exit /b %errorlevel%
)

pip install tkinterdnd2
if %errorlevel% equ 0 (
    echo tkinterdnd2 installed successfully.
) else (
    echo Error: Failed to install tkinterdnd2.
    pause
    exit /b %errorlevel%
)

python -c "import geochemistrypi"
if %errorlevel% equ 0 (
    echo geochemistrypi is installed.
) else (
    echo Error: geochemistrypi is not installed.
    pause
    exit /b %errorlevel%
)

python -c "import tkinterdnd2"
if %errorlevel% equ 0 (
    echo tkinterdnd2 is installed.
) else (
    echo Error: tkinterdnd2 is not installed.
    pause
    exit /b %errorlevel%
)

pause

:NEXT

cls

for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

echo %ESC%[32mGeochemistrypi is loading ......

echo %ESC%[0m

call conda activate !ENVIRONMENTNAME!
call pip install "geochemistrypi==0.7.0"
cls
call geochemistrypi data-mining  --desktop
if %errorlevel% neq 0 (
    echo Error: Failed to run Launcher script.
    pause
    exit /b %errorlevel%
)
echo Launcher executed successfully.
endlocal
pause