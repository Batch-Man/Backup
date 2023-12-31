@Echo off
cls

Cd /D "Src"

Echo.
Echo. ================================================================
Echo.
Echo. Before Backing up you folder, make sure that your FTP server is
Echo. up and running. You can use FileZilla to verify that fact.
Echo.
Echo. ================================================================
:Top
Echo.
Echo. Enter the Path of the Folder to Backup:
Set /p "_Path=>"
IF Not defined _Path (Goto :Top)
IF NOT Exist "%_Path%" (Goto :Top)
Call Backup "%_Path%"
pause
exit