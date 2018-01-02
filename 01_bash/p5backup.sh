#!/bin/bash

# where does your archiware install live
aw_path="/usr/local/sw"
# where do you want to backup index and log files to?
backup_path="/home/admin/swbackup"

# check to see if nsd is already running, if it is lets throw a flag
nr="0"
# our flag
pgnsd=$(pgrep nsd)
if [[ -z $pgnsd ]]; then
  echo "No P5 processes found."
  nr="1"
fi

# lets check and make sure no jobs are running
# we set a variable i to count the running jobs, and interrupt the script if there are more than 0 jobs still running
i="0"

# if P5 is running
if [[ $nr != 1 ]]; then
# get all the P5 jobs
  jobs_str=$($aw_path/bin/nsdchat -c Job names | tr ' ' '\n')

# figure out which are running and which are stopped. We only care about running jobs.
# we will increment i by 1 for each running job
  printf '%s\n' "$jobs_str" | while IFS='' read -r line || [[ -n "$line" ]]; do
    job="$line"
    status=$($aw_path/bin/nsdchat -c Job $job status | grep "running")
    if [[ $status != "" ]]; then
      i=$(echo "$i+1" | bc)
    fi
  done
fi

# if there is a running job, don't stop the service
if [[ $i -ge 1 ]]; then
  echo "There are $i jobs running, can't shut down service."
  exit 1
# if we can shut down P5, lets do it
elif [[ $nr -eq 1 && $i -eq 0 ]]; then
  echo "P5 service stopped, moving to backup"
elif [[ $i -eq 0 ]]; then
  echo "Shutting down P5 service"
 /usr/local/sw/stop-server
fi

# We check to see if there is already a valid previous backup. If there is, move it to keep it safe
echo "Checking if there is an existing backup"
  if [[ -d "$backup_path"/sw/config ]]; then
    echo "Existing backup found, moving old backup"
   mkdir -p "$backup_path"/sw_old
   mv "$backup_path"/sw "$backup_path"/sw_old/
  fi
# Lets make a backup of the files now, first we make a stamp so we know how long it took
  time_start=$(date +%s)
# Then we start the actual backup copy
# [R]ecursive to copy the full tree, [f]orced override, and symbolic [L]inks are followed
  echo "Making backup copy of index files"
    cp -RfL "$aw_path"/config/index "$backup_path"/sw/
    cp -RfL "$aw_path"/config/index /THOR/p5backup/sw/
  echo "Index files copied"

  echo "Making backup copy of config files"
    cp -RfL "$aw_path"/config/customerconfig "$backup_path"/sw/
    cp -RfL "$aw_path"/config/customerconfig /THOR/p5backup/sw/
  echo "Config files copied"

  echo "Making backup copy of log files"
    cp -RfL "$aw_path"/log "$backup_path"/sw/
    cp -RfL "$aw_path"/log /THOR/p5backup/sw/
  echo "Log files copied"
time_stop=$(date +%s)
# Then we let you know how long it took
backup_time=$(echo "$time_stop-$time_start" | bc)
echo "Backup complete. Copy took" $backup_time "seconds"

# Last, we start up the server
/usr/local/sw/start-server
