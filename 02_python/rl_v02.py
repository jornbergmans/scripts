#!/usr/local/bin/python3

import subprocess as sp
import sys
import os
import datetime
import json
from pprint import pprint

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

json_arguments = [
    '/usr/local/bin/ffprobe',
    '-v', 'error',
    '-hide_banner',
    '-show_streams',
    '-show_format',
    '-print_format', 'json',
]

ain_json = [
    json_arguments,
    '-i', ain
]

vin_json = [
    json_arguments,
    '-i', vin
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
# then round the float to nearest integer.
# I specifically need full int values to compare v and a len

# vout = sp.check_output(
#     vin_json
# )
# vint = round(float(vout.decode().strip()))

vout = json.loads(
        vin_json
    )
# aout = sp.check_output(
#     ain_json
# )
# aint = round(float(aout.decode().strip()))

aout = json.loads(
        ain_json
    )

streams_list = vout.get("streams")
for stream in streams_list:
    print(stream.get('codec_type'), stream.get('duration'))

pprint(vout.get("format").get("duration"))
pprint(aout.get("format").get("duration"))

if vout == aout:
    sp.run(avmix)
else:
    print("Length of video and audio files do not match!")
