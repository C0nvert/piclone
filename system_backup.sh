#!/bin/bash
#
# Automate Raspberry Pi Backups
#
# Based Kristofer Källsbo 2017 www.hackviking.com
# Modified by C0nvert
#
# Usage: system_backup.sh {path} {days of retention}
#
# Below you can set the default values if no command line args are sent.
# The script will name the backup files {$HOSTNAME}.{YYYYmmdd}.img
# When the script deletes backups older then the specified retention
# it will only delete files with it's own $HOSTNAME.
#

# Declare vars and set standard values
backup_path=/media/wdcloud-private/Raspberry_Pi_Image_Backups
retention_days=3

# Check that we are root!
if [[ ! $(whoami) =~ "root" ]]; then
echo ""
echo "**********************************"
echo "*** This needs to run as root! ***"
echo "**********************************"
echo ""
exit
fi

# Check to see if we got command line args
if [ ! -z $1 ]; then
   backup_path=$1
fi

if [ ! -z $2 ]; then
   retention_days=$2
fi

# Create trigger to force file system consistency check if image is restored
touch /boot/forcefsck

# Perform backup and compress it
dd bs=1M if=/dev/mmcblk0 | gzip > $backup_path/$HOSTNAME.$(date +%Y%m%d).img.gz

# Remove fsck trigger
rm /boot/forcefsck

# Delete old backups
find $backup_path/$HOSTNAME.*.img.gz -mtime +$retention_days -type f -delete 
