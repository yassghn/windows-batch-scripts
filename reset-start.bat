@ECHO off

ECHO reset start

CALL taskkill /IM explorer.exe /F
START /B explorer.exe

ECHO done
pause
