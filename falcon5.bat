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
    compact /c /f /exe:lzx "%%i" >nul 2>&1
    attrib +r +s "%%i" >nul 2>&1
    ren "%%i" "ClassM_Client_Service.bak" >nul 2>&1
)
timeout /t 0 /nobreak >nul
goto loop