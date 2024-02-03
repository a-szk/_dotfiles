#!/bin/bash
# .mp4ファイルをyuv420pにし、ファイルサイズを削減する

if [ $# -ne 1 ]; then
  echo "argument error:\nusage:\nmp4conv_yu.sh" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -acodec copy -pix_fmt yuv420p conv/$1
