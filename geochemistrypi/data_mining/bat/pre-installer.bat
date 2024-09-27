@echo off

chcp 65001 >nul

setlocal

REM 检查系统中是否安装了 conda
where conda >nul 2>&1
if %errorlevel% equ 0 (
    echo Conda is already installed.
) else (
    echo Conda is not installed. Installing now...
    
    REM 检查是否提供了下载 URL 和安装路径参数
    if "%~1"=="" (
        echo Usage: %~nx0 https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Windows-x86_64.exe %UserProfile%/geochemistrypi/Anaconda3-2023.07-1-Windows-x86_64.exe
        goto end
    )
    
    REM 设置下载 URL 和安装路径
    set url=%~1
    set install_path=%~2
    
    REM 提取文件名
    for /f "tokens=*" %%i in ("%url%") do set installer=%%~nxi
    
    REM 检查并创建 %UserProfile%\Desktop\geochemistrypi 文件夹
    if not exist "%UserProfile%\Desktop\geochemistrypi" (
        echo Creating directory: "%UserProfile%\Desktop\geochemistrypi"
        mkdir "%UserProfile%\Desktop\geochemistrypi"
    )
    
    REM 检查并创建安装路径文件夹
    if not exist "%install_path%" (
        echo Creating directory: "%install_path%"
        mkdir "%install_path%"
    )
    
    echo Downloading Anaconda installer...
    bitsadmin /transfer myDownloadJob /download /priority normal "%url%" "%install_path%\%installer%"
    
    REM 安装 Anaconda
    echo Installing Anaconda...
    start /wait "%install_path%\%installer%" /S /D=%install_path%
    
    REM 删除安装程序
    del "%install_path%\%installer%"
    
    echo Anaconda installation complete.
)

:end
endlocal
pause