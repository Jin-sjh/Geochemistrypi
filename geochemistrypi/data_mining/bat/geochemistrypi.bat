::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFC9cRQqJDGq+OpEZ++Pv4Pq7pUgSV+o6dYbIzqaXMOkv6EzqSZE9zzRTm8Rs
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
::cxY6rQJ7JhzQF1fEqQJgZk0aHGQ=
::ZQ05rAF9IBncCkqN+0xwdVs0
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
::Zh4grVQjdCyDJGyX8VAjFC9cRQqJDGq+OpEZ++Pv4Pq7pUgSV+o6dYbIzqaXMOkv7UDrdp4o23NJjNkVHBIWewquDg==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off

chcp 65001 >nul

set current_dir = "%~dp0"

call "%~dp0\bin\Geochemistrypi\geochemistrypi\data_mining\bat\pre-installer.bat"

call "%~dp0\bin\Geochemistrypi\geochemistrypi\data_mining\bat\setup_env.bat"

echo Geochemistrypi is loading ......

setlocal enabledelayedexpansion

set ENVIRONMENT_NAME=GeoUI


call conda activate %ENVIRONMENT_NAME%

@REM for /f "delims=" %%a in ('where python') do (
@REM     if "%%a" == "%CONDA_PREFIX%\python.exe" (
@REM         set PYTHON_EXE=%%a
@REM         goto :found
@REM     )
@REM )
@REM :found
@REM echo The path of python.exe in the %ENVIRONMENT_NAME% environment is:
@REM echo %PYTHON_EXE%


python .\bin\Geochemistrypi\geochemistrypi\start_cli_pipeline.py
if %errorlevel% neq 0 (
    echo Error: Failed to run Launcher.py script.
    pause
    exit /b %errorlevel%
)

echo Launcher executed successfully.

endlocal
pause

