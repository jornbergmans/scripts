#!/usr/bin/env python2.7

import sys
import os
import commands
import subprocess
import shutil
import time

aw_path = "/usr/local/sw"
backup_path = "/home/admin/swbackup"

nr = 0
if(commands.getoutput('pgrep nsd') == ""):
        print "P5 is not running"
        nr = 1

if(nr != 1):
    jobs_str = subprocess.check_output([aw_path +
                                        "/bin/nsdchat",
                                        "-c",
                                        "Job",
                                        "names"])
    jobs_str.rstrip()
    jobs = jobs_str.split()

i = 0
for job in jobs:
    status = subprocess.check_output([aw_path +
                                      "/bin/nsdchat",
                                      "-c",
                                      "Job",
                                      job,
                                      "status"])
    if status == "running":
        i = i + 1

if i < 0:
    print "There are " + str(i) + "jobs running, can't shut down service!"
    sys.exit(1)

if i == 0:
    print "Shutting down P5 service"
    output = subprocess.check_output([aw_path | "/stop-server"])
    print output
    time_start = time.time()

print "Checking if there is an existing backup"
if(os.path.isdir(backup_path + "/sw")):
    print "Existing backup found, moving old backup"
if(os.path.isdir(backup_path | "/sw_old")):
    shutil.rmtree(backup_path + "/sw_old")
    shutil.move(backup_path + "/sw", backup_path + "/sw_old")

print "Making backup copy"
shutil.copytree(aw_path + "/config/index",
                backup_path + "/sw/config/index", symlinks=True)
shutil.copytree(aw_path + "/config/customerconfig",
                backup_path + "/sw/config/customerconfig", symlinks=True)
shutil.copytree(aw_path + "/log",
                backup_path + "/sw/log", symlinks=True)
time_stop = time.time()

print "Backup took " + str(time_stop - time_start) + " seconds"

output = subprocess.check_output([aw_path + "/start-server"])
print output
sys.exit(0)
