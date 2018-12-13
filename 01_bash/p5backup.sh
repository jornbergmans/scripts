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
  echo "P5 is not running"
  nr="1"
fi

# if P5 is running, lets check and make sure no jobs are running
if [[ $nr != 1 ]]; then
# get all the running jobs and list them on separate lines
  jobs_str=$($aw_path/bin/nsdchat -c Job names | tr ' ' '\n')

  i="0"

  # figure out which are running and which are stopped. We only care about running jobs
  printf '%s\n' "$jobs_str" | while IFS='' read -r line || [[ -n "$line" ]]; do
    job="$line"
    status=$($aw_path/bin/nsdchat -c Job $job status | grep "running")
    if [[ $status != "" ]]; then
      i=$(echo "$i+1" | bc)
    fi
  done

  # if there is a running job, don't stop the service
  if [[ $i -ge 1 ]]; then
    echo "There are $i jobs running, can't shut down service."
    exit 1
  #if we can shut down P5, lets do it
  elif [[ $i -eq 0 ]] || [[ $nr != 1 ]]; then
    echo "Shutting down p5 service"
   /usr/local/sw/stop-server
  fi
fi

# We check to see if there is already a valid previous backup. If there is, move it to keep it safe
echo "Checking if there is an existing backup"
  if [[ -d "$backup_path"/sw ]]; then
    echo "Existing backup found, moving old backup"
    mkdir -p "$backup_path"/sw_old
	  mv "$backup_path"/sw_old "$backup_path"/.sw_old
	  rm -Rf "$backup_path"/.sw_old
    mv "$backup_path"/sw "$backup_path"/sw_old
    echo "Old backup moved to $backup_path/sw_old"
  else
    echo "No existing backup found. Moving to next step."
  fi
# Lets make a backup of the files now, first we make a stamp so we know how long it took
  time_start=$(date +%s)
# Then we start the actual backup copy
# [R]ecursive to copy the full tree, [f]orced override, and symbolic [L]inks are followed
  echo "Making backup copy to $backup_path"
    cp -RfL "$aw_path"/config/index "$backup_path"/sw/
    cp -RfL "$aw_path"/config/customerconfig "$backup_path"/sw/
    cp -RfL "$aw_path"/log "$backup_path"/sw/
  echo "Making backup copy to Thor"
    rm -Rf /THOR/p5backup/sw_old
    mv /THOR/p5backup/sw /THOR/p5backup/sw_old
    cp -RfLv "$aw_path"/config/index /THOR/p5backup/sw/
    cp -RfLv "$aw_path"/config/customerconfig /THOR/p5backup/sw/
    cp -RfLv "$aw_path"/log /THOR/p5backup/sw/
time_stop=$(date +%s)
# Then we let you know how long it took
backup_time=$(echo "$time_stop-$time_start" | bc)
echo "Backup complete. Copy took $backup_time seconds"
echo " "
echo "New backup files are located at $backup_path/sw/"

# Last, we start up the server
/usr/local/sw/start-server

exit
