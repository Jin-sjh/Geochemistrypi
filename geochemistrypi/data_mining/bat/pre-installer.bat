@echo off

chcp 65001 >nul

setlocal enabledelayedexpansion

REM 检查系统中是否安装了 conda
where conda >nul 2>&1
if %errorlevel% equ 0 (
    echo Conda is already installed.
    goto end
) else (
    echo Conda is not installed. Installing now...
    
    REM 检查是否提供了下载 URL 参数
    if "%~1"=="" (
        echo Usage: %~nx0 
        echo Example: %~nx0 https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Windows-x86_64.exe
    )
    
    REM 设置下载 URL
    REM set url=%~1
    REM set url=https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Windows-x86_64.exe
    set url=https://repo.anaconda.com/miniconda/Miniconda3-py39_24.11.1-0-Windows-x86_64.exe

    REM 如果没有提供安装路径参数，则设置为当前脚本所在目录下的conda文件夹
    if "%~2"=="" (
        set install_path=%~dp0geoconda
    ) else (
        set install_path=%~2
    )
    
    set installer=Miniconda3-py39_24.11.1-0-Windows-x86_64.exe

    REM 检查并创建安装路径文件夹
    if not exist "%install_path%" (
        echo Creating directory: !install_path!
        mkdir !install_path!
    )
    echo url: !url!
    echo installer:  %installer%
    echo Downloading Anaconda installer...
    bitsadmin /transfer Download_conda  /download /priority FOREGROUND  !url!  !install_path!\!installer!
    
    REM 安装 Anaconda
    echo Installing Anaconda...
    start /wait !install_path!\!installer!   /D=!install_path!
    
    REM 删除安装程序
    del !install_path!\!installer!
    
    echo Anaconda installation complete.
)

:end
endlocal
pause