@Echo off
Setlocal EnableDelayedExpansion

Set path=%path%;%_path%;%~dp0;%~dp0Files;%cd%;%cd%\Files;

REM THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY
REM KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
REM WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
REM AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
REM HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
REM WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
REM DEALINGS IN THE SOFTWARE.

REM This program is distributed under the following license: (SELECT A LICENSE)

REM ================================================================================
REM GNU General Public License (GPL) - https://opensource.org/licenses/gpl-license
REM ================================================================================

REM ================= ABOUT THE PROGRAM =================
REM This program is created by Kvc at '29-01-2022 - 17:33'
REM This program can backup your folder to FTP server.
REM For More Visit: www.batch-man.com


REM Setting version information...
Set _ver=20231231

REM Checking for various parameters of the function...
for %%A in ("--help" "-h" "-help") do (if /i "%%A" == "%~1" (goto :help))
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-?" (goto :help)
If /i "%~1" == "" (goto :help)

If /i "%~1" == "ver" (Echo.%_ver%&Goto :End)

REM Saving parameters to variables...
Set _1=%~1

REM Starting Main Program...
:Main

REM Reading the Settings...
If NOT Exist "%~dp0Settings.txt" (Echo. Settings File missing.... &&Goto :End)

For /f "usebackq eol=# delims== tokens=1,2*" %%A in ("%~dp0Settings.txt") do (set "%%~A=%%~B")

REM verifying, if the FTP server can be Pinged...
ping -n 1 !_FTPid! -w 10 2>nul >nul && (echo FTP SERVER is LIVE...) || (echo FTP SERVER NOT ACTIVE... & Pause)

REM Just in case, if the backup.bat is not in the same folder
REM and called from PATH location instead
If /i "!_1!" NEQ "" (Pushd "!_1!") ELSE (Goto :End)

REM Zipping current folder
For %%I in (.) do set _ZipName=%%~nxI
Set _Time=%time::=%
Set _Date=%Date:/=%
Set _Date=%_Date:-=%
Set _version=%_Date% - %_Time%

7za.exe a "%temp%\%_ZipName% - %_version%.zip" "!_1!/*"

REM Generating a ftp script...
(
Echo.open !_FTPid! !_Port!
Echo.!_User!
Echo.!_Password!
Echo.mkdir "!_RemoteBackupPath!"
Echo.mkdir "!_RemoteBackupPath!/!_ZipName!"
Echo.cd "!_RemoteBackupPath!/!_ZipName!"
Echo.!_Mode!
Echo.put "!temp!\!_ZipName! - !_version!.zip"
Echo.bye
) >"%temp%\Script.ftp"

ftp -s:"%temp%\Script.ftp"

Del /f /q "%temp%\%_ZipName% - %_version%.zip" >nul 2>nul
Del /f /q "%temp%\Script.ftp" >nul 2>nul

Goto :End


:End
Goto :EOF

:Help
Echo.
Echo. This function will backup your PC Folders to FTP server.
Echo. CREDITS: Backup %_ver% by Kvc
echo.
echo. Syntax: call Backup ^<Path^>
echo. Syntax: call Backup [help , /? , -h , -help]
echo. Syntax: call Backup ver
echo.
echo. Where:-
echo.
echo. ver		: Displays version of program
echo. help		: Displays help for the program
echo. Path		: Location Path of the Folder on HDD
Echo.
Echo. Example: Call Backup "D:\MyPrograms"
Echo. Example: Call Backup ver
Echo. Example: Call Backup [/? , -h , -help , help]
Echo.
Echo.
Echo. PLUGINS REQUIRED FOR THIS PROJECT:
Echo. 7za.exe
Echo.
Echo. www.batch-man.com
Echo. #batch-man
Goto :End

