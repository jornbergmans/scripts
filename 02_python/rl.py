#!/usr/local/bin/python3
"""Script to combine audio and video files of the same length.

Checks input files for length up to 6 decimals using ffprobe,
then combines those two input files to a video,
and transcodes to x264 if necessary
"""

import subprocess as sp
import sys
import os
import datetime

if len(sys.argv) < 3:
    print("missing input")
    exit(1)

vin = sys.argv[1]
ain = sys.argv[2]
outformat = sys.argv[3]
outfolder = sys.argv[4]

basev = os.path.basename(vin)
now = datetime.datetime.now().strftime('%Y%m%d-%H%M')

probe_header = [
    '/usr/local/bin/ffprobe',
    '-v', 'error',
    '-hide_banner',
]
probe_arguments = [
    '-show_entries', 'format=duration',
    '-of', 'default=noprint_wrappers=1:nokey=1',
]

if outformat == "mov":
    outext = "mov"
else:
    outext = "mp4"

outname = os.path.join(
    outfolder,
    "{}_{}.{}".format(
        os.path.splitext(basev)[0],
        now,
        outext
    )
)
outlog = os.path.join(
    outfolder,
    "{}_{}.{}".format(
        os.path.splitext(basev)[0],
        now,
        'log'
    )
)

ff_header = [
    '/usr/local/bin/ffmpeg', '-hide_banner',
    '-loglevel', 'warning',
    '-y',
    '-i', vin,
    '-i', ain,
    '-map', '0:0', '-map', '1:0',
]

ff_master = [
    '-c:v', 'copy',
    '-c:a', 'copy',
    '-f', 'mov',
    outname
]

ff_ref = [
    '-c:v', 'libx264',
    '-c:a', 'aac',
    '-b:v', outformat + 'k',
    '-b:a', '160k',
    '-pix_fmt', 'yuv420p',
    '-profile:v', 'high',
    '-level', '41',
    '-vf', 'scale=trunc(iw/2)*2:trunc(ih/2)*2',
    '-f', 'mp4',
    outname
]

if __name__ == "__main__":

    vprobe = []
    vprobe.extend(probe_header)
    vprobe.extend(['-i', vin])
    vprobe.extend(probe_arguments)
    vout = sp.check_output(
        vprobe
    )
    vint = vout.decode()

    aprobe = []
    aprobe.extend(probe_header)
    aprobe.extend(['-i', ain])
    aprobe.extend(probe_arguments)
    aout = sp.check_output(
        aprobe
    )
    aint = aout.decode()

    ff_command = []
    ff_command.extend(ff_header)

    if outformat == "mov":
        ff_command.extend(ff_master)
    else:
        ff_command.extend(ff_ref)

    # test prints
    # print('audioint', aint)
    # print('vidint', vint)
    # print(" ".join(ff_command))

    if vint == aint:
        if not os.path.isdir(outfolder):
                os.makedirs(outfolder)
        logfile = open(outlog, 'w')
        if outformat == "mov":
            print("Creating Master file")
            sp.run(ff_command)
        elif outformat != "mov":
            print("Creating reference file")
            sp.run(ff_command)
        logfile.write(" ".join(ff_command))
        print("Done! Created file at ", outname)
    else:
        print("Length of video and audio files do not match!")
        print("Length of video file is " + str(vint) + " seconds")
        print("Length of audio file is " + str(aint) + " seconds")
