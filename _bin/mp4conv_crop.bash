#!/bin/bash
# 動画の一部領域を切り抜く


if [ $# -ne 5 ]; then
  echo "argument error:\nusage:\$0 input.mp4 Resolution_X Resolution_Y LeftTop_X LeftTop_Y" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -vf crop=$2:$3:$4$5 -strict -2 -an -pix_fmt yuv420p conv/$1 -y
