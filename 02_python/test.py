import os
import sys
import utils

vinFolder = sys.argv[1]

print(str(vinFolder))

for dirpath, dirnames, filenames in os.walk(vinFolder):
    filteredVidList = utils.filterHiddenFiles(filenames)
    for filename in filteredVidList:
        if filename.endswith('mov'):
            print(str(filename))
