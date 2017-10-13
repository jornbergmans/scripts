#/bin/bash
IFS=$'\n'

while read line; do
    echo $line
    baseline=$(basename $line)
done < $1
