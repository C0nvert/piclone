# piclone
Cloning and Compressing SD Card Image

### Download Script
`wget https://raw.githubusercontent.com/C0nvert/piclone/master/system_backup.sh
`
### Check for Drive Name
`lsblk`
If name equals proceed "mmcblk0" if not edit system_backup.sh
### Make it executable
`chmod +x system_backup.sh`

### Create root Crontab
`sudo crontab -e`
#### Add this Line
`0 0 * * * /pathtofile/system_backup.sh`
### Override deafults by supplying command line arguments
`system_baskup.sh <path to backup save> <number of days retention>`
