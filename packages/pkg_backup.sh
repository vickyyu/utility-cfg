#!/bin/bash

PKG_BACKUP_PATH=~/nonnn-cfg/packages

## Backup package list

backup () {
    DATE=$(date +%y%m%d%H%M)
    mkdir $PKG_BACKUP_PATH/$DATE

    dpkg --get-selections > $PKG_BACKUP_PATH/$DATE/Package.list
    sudo cp -R /etc/apt/sources.list* $PKG_BACKUP_PATH/$DATE/
    sudo apt-key exportall > $PKG_BACKUP_PATH/$DATE/Repo.keys
    # rsync --progress /home/`whoami` /path/to/user/profile/backup/here
}

##  Reinstall now

restore () {
    RESTORE_DATE=$1

    ls $1

    if [ $? != 0 ];then
	echo "Can not find restore date $RESTORE_DATE"
	return 1
    fi

    # rsync --progress /path/to/user/profile/backup/here /home/`whoami`
    sudo apt-key add $PKG_BACKUP_PATH/$RESTORE_DATE/Repo.keys
    sudo cp -R $PKG_BACKUP_PATH/$RESTORE_DATE/sources.list* /etc/apt/
    sudo apt-get update
    sudo apt-get install dselect
    sudo dpkg --set-selections < $PKG_BACKUP_PATH/$RESTORE_DATE/Package.list
    sudo dselect
}

main () {
    case "$1" in
	backup)
	    backup
	    ;;
	restore)
	    restore $2
	    ;;
	*)
	    echo "pkg_backup [backup|restore DATE]"
	    echo "Valid DATE are:"
	    echo "$(ls -l $PKG_BACKUP_PATH)"
	    ;;
    esac
}

main $@
