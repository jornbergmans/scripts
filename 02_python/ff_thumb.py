#!/usr/bin/env python3

# import sys
import os

ffprobeString = [
    '/usr/bin/env', 'ffprobe',
    '-hide_banner', '-loglevel panic', '-pretty',
    '-select_streams', 'v:0',
    '-show_entries', 'stream=nb_frames',
    '-of', 'default=noprint_wrappers=1:nokey=1',
]

ffInString = [
    '/usr/bin/env', 'ffmpeg',
    '-hide_banner',
    '-loglevel', 'error',
]

ffScreenGrabs = [
    '-vf', 'fps="1/$inRate",scale="320:-1"',
]

ffThumbCreation = [
    '-pattern_type', 'glob',
    '-frames', '1',
    '-vf', 'tile=4x$tileHeight:margin=4:padding=4',
]

inVid = input("Please input video file")
inRate = input("Please specify desired thumbnail interval in seconds")

vidBase = os.path.basename(inVid)
grabDir = os.path.join(vidBase, '.ff_thumb')
grabOut = os.path.join(
    grabDir, "{}.{}".png
)
ffGrabCom = []
ffGrabCom.extend(ffInString)
ffGrabCom.extend('-i', inVid,)
ffGrabCom.extend(ffScreenGrabs)


ffThumbCom = []
ffThumbCom.extend('-y', '-i', grabOut)
