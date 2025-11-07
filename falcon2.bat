@echo off
setlocal enabledelayedexpansion
set count=0

:loop
set /a count+=1
echo === 검색 및 종료 실행 횟수: !count!/100 ===
echo.

echo === 프로세스 검색 및 종료 ===
for %%i in (ClassM monitor client) do (
    echo [검색] %%i ...
    tasklist | findstr /i "%%i"
    if !errorlevel! equ 0 (
        echo [종료] %%i 프로세스 종료 중...
        taskkill /F /IM *%%i*.exe >nul 2>&1
        wmic process where "name like '%%%%i%%%'" delete >nul 2>&1
        powershell -Command "Get-Process *%%i* -ErrorAction SilentlyContinue | Stop-Process -Force" >nul 2>&1
    )
)

echo.
echo === 파일 삭제 ===
for %%i in (classm monitor moniter client) do (
    echo [파일 검색] %%i ...
    for /f "delims=" %%f in ('dir /s /b C:\*%%i*.exe 2^>nul') do (
        echo [삭제] %%f
        del /f /q "%%f" >nul 2>&1
    )
)

echo.
echo === 레지스트리 삭제 ===
for %%i in (classm monitor moniter client) do (
    echo [레지스트리 검색] %%i ...
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v *%%i* /f >nul 2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v *%%i* /f >nul 2>&1
)

echo.
echo ========================================
timeout /t 5 /nobreak >nul

if !count! lss 100 (
    cls
    goto loop
) else (
    echo === 100회 검색 및 종료 완료 CSMS ===
    pause
    exit
)