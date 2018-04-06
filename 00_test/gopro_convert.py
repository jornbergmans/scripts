#!/usr/bin/env python3

import subprocess as sp
import os
import time
import sys
import utils


def outnameBase(folder, file):
    outnameBase = os.path.join(
        outfolder,
        "{}_{}".format(
            os.path.basename(baseInFolder),
            os.path.splitext(baseInFile)[0],
        ))
    return outnameBase


if len(sys.argv) < 2:
    print("missing input")
    exit(1)

infolder = sys.argv[1]
outfolder = sys.argv[2]

for dirpath, dirnames, filenames in os.walk(infolder):
    # get the current time
    curtime = time.strftime("%H:%M:%S", time.gmtime())
    filteredFilenames = utils.filterHiddenFiles(filenames)

    for infiles in filteredFilenames:
        ffCommand = []
        fileBase, fileExt = os.path.splitext(infiles)
        if fileExt in ['.mov', '.mp4', '.avi']:
            infile = infiles
            infileFullPath = os.path.join(dirpath, infile)
            ffCommand.extend(['/usr/bin/env', 'ffmpeg',
                              '-i', infileFullPath,
                              '-c', 'copy',
                              '-timecode', curtime + ':00',
                              '-f', 'mov'])
            baseInFolder = os.path.basename(
                            os.path.split(dirpath)[0]
                            )
            baseInFile = os.path.splitext(infile)[0]
            print(dirpath)
            print(baseInFolder)
            print(baseInFile)
            outname = [outnameBase(baseInFolder, baseInFile)
                       + '.mov']
            # if not os.path.isdir(outfolder):
            #         os.makedirs(outfolder)
            #
            ffCommand.extend(outname)
            print(" ".join(ffCommand))
            # sp.run(ffCommand)

            # make the script wait 1 second before moving
            # to the next file to avoid timecode conflicts
            time.sleep(1)
