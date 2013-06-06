#!/bin/bash

set -e

inpDir="img"
suffix="small"
quality="60"
maxDimW=400

find "$inpDir" -type f -not -name "*.$suffix.*" | \
while read inpPath; do
    inpFile=$(basename "$inpPath")
    inpFileExt="${inpFile##*.}"
    inpFileBase="${inpFile%.*}"
    outPath="$inpDir/$inpFileBase.$suffix.$inpFileExt"
    [ -e "$outPath" ] && continue
    echo "$inpPath"
    dims=$(identify "$inpPath" | sed -r 's/^.* ([0-9]+)x([0-9]+) .*$/\1 \2/g')
    oldDimW=$(echo $dims | awk '{print $1}')
    oldDimH=$(echo $dims | awk '{print $2}')
    if [ $oldDimW -gt $maxDimW ]; then
        scale="($maxDimW/$oldDimW.0)"
        newDimW=$(python -c "print '%d' % ($oldDimW * $scale)")
        newDimH=$(python -c "print '%d' % ($oldDimH * $scale)")
    	convert -resize ${newDimW}x${newDimH} -quality $quality "$inpPath" "$outPath"
    else
        cp "$inpPath" "$outPath"
    fi
done
