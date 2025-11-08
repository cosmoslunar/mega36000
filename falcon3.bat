@echo off
:loop
taskkill -F -IM ClassM_Client_Service.exe -T
goto loop
