#!/bin/bash

#define variables
source_server_dir=/nfs/eii-a/repository/deployment/server/
target_server_home=/opt/eii-m-a
target_server_dir="$target_server_home/repository/deployment/server/"
log_file="$target_server_home/carbon-rsync-logs.txt"
lock_mark="$target_server_home/depsync-lock"


#delete the lock on exit
trap "/bin/rm -rf $lock_mark" EXIT


#start log trace
echo ================================================== >> $log_file;
echo $(date +'%d.%m.%Y %H:%M:%S') >> $log_file


#keep a lock to stop parallel runs
if mkdir "$lock_mark"; then
  echo "Locking succeeded" >> $log_file
else
  echo "Lock failed - exit" >> $log_file
  exit 1
fi


#sync folders
echo Syncing $target_server_dir;
#target <--> source
/bin/rsync --delete -arv $target_server_dir $source_server_dir >> $log_file
echo ================================================== >> $log_file;
#end log trace


/bin/chown -R eii-a /opt/eii-m-a
