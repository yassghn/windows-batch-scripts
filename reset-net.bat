@echo off

echo RESET NET
 
echo reseting net...
 
netsh winsock reset
netsh int ip reset
netsh advfirewall reset
ipconfig /flushdns
ipconfig /release
REM ipconfig /renew *Wi-Fi*
 
echo disabling network adapter...
 
netsh interface set interface "Wi-Fi" disable
 
echo enabling network adapter...
 
netsh interface set interface "Wi-Fi" enable
 
echo done

pause
