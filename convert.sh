#!/bin/bash

# Function to handle exit signal
cleanup() {
    echo -e "\nExiting..."
    exit 1
}
trap cleanup EXIT

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg could not be found"
    while true; do
        read -rep "Would you like to install ffmpeg? y/n: " -i "" ffmpegInstall
        if [ "$ffmpegInstall" == "y" ]; then
            sudo snap install ffmpeg
            break
            elif [ "$ffmpegInstall" == "n" ]; then
            exit
        else
            echo "Invalid input"
        fi
    done
fi

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
