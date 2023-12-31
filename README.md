
# Backup
## Description
This program can backup your PC Folders to Your FTP server easily.

Author: Kvc

## Usage
Call Backup <Path>

**Example**
`call Backup "D:\MyPrograms"`

### Installing the application
You can get the app from our GitHub page. Once you have downloaded this, you should have four files: Backup.bat, RunAS admin.bat, Settings.txt and 7za.exe (the last one in the files\ folder, as it is a dependency). The main application is backup.bat, and the RunAS batch file allows you to create a shortcut via the explorer shell. The Settings.txt file is where you will store the FTP server settings. Also, the FTP application uses 7zip to compress your backup before sending it to your FTP server. If 7zip is installed already, you can remove the portable one.
 
### Initializing our settings
 
Now, in the settings file you will find the following:
 
<!-- wp:code -->
<pre class="wp-block-code"><code># All Lines after '#' are comments

_FTPid=xxx
_Port=xxx
_User=xxx
_Password=xxx

_RemoteBackupPath=/_Backup


# Do not touch these settings...
_Mode=Binary</code></pre>
<!-- /wp:code -->

The settings are pretty straightforward for you to fill in. You will have to to specify the FTPid (or IP address), the FTP Port, the Username and Password, and the folder the backups will be placed in on your FTP server. Once you have filled those in, you are ready to proceed with the next steps. 

Article- https://batch-man.com/easy-ftp-backup-with-batch-application/

Video- https://www.youtube.com/watch?v=pkmjEXsQOyo&ab_channel=BatchMan
