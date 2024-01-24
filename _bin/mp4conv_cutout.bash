#!/bin/bash
# 動画の一部時間を切り抜く


if [ $# -ne 3 ]; then
  echo "argument error:\nusage:\nmp4conv_cutout.sh input.mp4 start_sec end_sec" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -ss $2 -to $3 -strict -2 -an -pix_fmt yuv420p conv/$1 -y
