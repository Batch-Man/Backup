@Echo off
cls
Echo.
Echo. Run this as an ADMIN!!
Echo.
Echo. otherwise, this will not work as expected...
Echo.
:Top
Echo.
Echo. Please Select an Option below: [e.g: 1 or 2]
Echo.
Echo.	1. Add "Backup" to Right_Click_Menu
Echo.	2. Remove "Backup" From Right_Click_Menu
Echo.

Set /p "_Option=>"
Echo.
If NOT DEFINED _Option (Goto :Top)
If /i "%_Option%" == "1" (Goto :AddBackup)
If /i "%_Option%" == "2" (Goto :RemoveBackup)

:AddBackup
Reg Add HKEY_CLASSES_ROOT\Directory\Background\shell\Backup\command /t REG_EXPAND_SZ /d """"%~dp0Backup.bat""" """%%~1"""" /f
Echo.
Echo. Check by Right Click!
Pause
Goto :End

:RemoveBackup
Reg Delete HKEY_CLASSES_ROOT\Directory\Background\shell\Backup /f
Echo.
Echo. Removed from Right Click context menu...
pause
Goto :End

:End
exit /b