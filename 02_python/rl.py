#!/usr/local/bin/python3

import subprocess as sp
import sys
import os
import datetime
# import json
# from pprint import pprint

if len(sys.argv) < 3:
    print("missing input")
    exit(1)

# Specify all inputs and outputs
vin = sys.argv[1]
ain = sys.argv[2]
outformat = sys.argv[3]
outfolder = sys.argv[4]

# specify variables used by our functions
basev = os.path.basename(vin)
now = datetime.datetime.now().strftime('%Y%m%d-%H%M')

vin_arguments = [
    '/usr/local/bin/ffprobe',
    '-v', 'error',
    '-hide_banner',
    '-show_entries', 'format=duration',
    '-of', 'default=noprint_wrappers=1:nokey=1',
    '-i', vin
]

ain_arguments = [
    '/usr/local/bin/ffprobe',
    '-v', 'error',
    '-hide_banner',
    '-show_entries', 'format=duration',
    '-of', 'default=noprint_wrappers=1:nokey=1',
    '-i', ain
]

outname = os.path.join(
    outfolder,
    "{}_{}.{}".format(
        os.path.splitext(basev)[0],
        now,
        outformat
    )
)

avmix = [
    '/usr/local/bin/ffmpeg', '-hide_banner',
    '-i', vin,
    '-i', ain,
    '-c:v', 'copy',
    '-c:a', 'copy',
    '-map', '0:0', '-map', '1:0',
    '-f', 'mov',
    outname
]

# return video and audio outputs as bytes, decode into float
# then round the float to nearest integer to compare vin to ain

vout = sp.check_output(
    vin_arguments
)
vint = round(float(vout.decode().strip()))

aout = sp.check_output(
    ain_arguments
)
aint = round(float(aout.decode().strip()))

if vint == aint:
    sp.run(avmix)
else:
    print("Length of video and audio files do not match!")
    print("Length of video file is " + str(vint) + " seconds")
    print("Length of audio file is " + str(aint) + " seconds")
