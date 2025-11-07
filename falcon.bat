@echo off
:loop
set /a a+=1
echo %a% running
echo kill
taskkill /F /T /IM ClassMClient.exe
cls
taskkill /F /T /IM ClassMService.exe
cls
taskkill /F /T /IM ClassMMoniter.exe
cls
goto loop