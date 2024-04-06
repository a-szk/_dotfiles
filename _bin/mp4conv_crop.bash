#!/bin/bash
# 動画の一部領域を切り抜く

function usage() {
    echo -en "\033[1;33mUsage:\033[m\n"
    echo -en "   $(basename $0) input.mp4 Resolution_X Resolution_Y LeftTop_X LeftTop_Y\n"
}

function example() {
    echo -en "\n"
    echo -en "\033[1;33mExample:\033[m\n"
    echo -en "   $(basename $0) 1280x720.mp4 800 600 240 60\n"
    echo -en "   -> Crop the center 800x600 area from 1280x720.mp4\n"
}

while getopts h OPT
do
    case $OPT in
        h) usage;example;exit 1;
    esac
done

if [ $# -ne 5 ]; then
    echo -en "\033[1;33mArgument Error!\033[m\n"
    usage
    exit 1
fi

mkdir -p conv
ffmpeg -i $1 -vf crop=w=$2:h=$3:x=$4:y=$5 -strict -2 -acodec copy conv/$1 -y
