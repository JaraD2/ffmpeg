#!/bin/bash

# Function to handle exit signal
cleanup() {
    echo "Exiting..."
    exit 1
}
trap cleanup EXIT

mapfile -t Inputs < <(ls ./inputs)

read -rep "Specify output filetype? " -i "" filetype
echo "${filetype}"

read -r -p "Press enter to start converting ${#Inputs[@]} files"

for Input in "${Inputs[@]}";
do (
        echo "started"
        inputFileName=${Input%.*}
        echo "Converting ${inputFileName} to ${filetype}"
        ffmpeg -i "./inputs/${Input}" "./outputs/${inputFileName}.${filetype}" -loglevel error  -stats
        echo "done"
    )
done && echo "All done"
