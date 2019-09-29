#!/bin/bash
set -eu

MOUNT_PATH="/media/usbstick"
USER_ID=1000
GROUP_ID=1000

mountDrive() {
if [[ $# -eq 1 && -n "$1" ]];
then 	
	sudo mkdir -vp "$MOUNT_PATH"
	echo "Mounting vFat USB device: $1"
	lsblk "$1"; FOUND=$?
	echo "lblk of $1 returned exit code: $FOUND"
	if [ $FOUND -eq 0 ];
	then	
		echo "Found device $1"
		sudo mount -v -t vfat "$1" "$MOUNT_PATH" -o rw,uid="$USER_ID",gid="$GROUP_ID"
		MOUNTPOINT=$(findmnt "$1")
		echo "Mounted as: $MOUNTPOINT"
	else
		echo "Could not find device $1"
	fi
else
	echo "1 argument is required: [device] (i.e /dev/sdd1)"		
fi
}

unmountDrive(){
if [[ $# -eq 1 && -n "$1" ]];
then 	
	MOUNTPOINT=$(findmnt "$1")
	echo "Found mountpoint: $MOUNTPOINT"
	sudo umount -v "$1"
else
	echo "1 argument is required: [device] (i.e /dev/sdd1)"		
fi
}

showHelp() {
	echo -e "Usage:\n -d [device] \n -m (Mount device) \n -u (Unmount device)"
}



ARGS_PASSED=false
while getopts ":d:mu" opt
do
	case $opt in
		d ) DEVNAME="$OPTARG";;
		m ) mountDrive "$DEVNAME";;
		u ) unmountDrive "$DEVNAME";;
		* ) showHelp;;
	esac
	ARGS_PASSED=true
done
if [ $ARGS_PASSED = false ]; then showHelp; fi
