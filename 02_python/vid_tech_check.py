#!/usr/local/bin/python3

# ffprobe output json
# output framerate
# output framesize
# output codec
#
# input framerate
# input framesize - SD, HD, UHD, 2k, 4k, Scope
# input codec
#
# If framesize, framerate or codec output is not equal to input,
# then flag a warning (to log file?)
# flag file (rename to _fpserr or _fsizerr or _coderr?)


import sys
import json
v_in = sys.argv[1]

json_arguments = [
    '/usr/bin/env', 'fprobe',
    '-v', 'error',
    '-hide_banner',
    '-show_streams',
    '-show_format',
    '-print_format', 'json',
]

v_in_json = [
    json_arguments,
    '-i', v_in
]

v_out = json.loads(
        v_in_json
    )

print(v_out)
