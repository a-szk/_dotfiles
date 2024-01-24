#!/bin/bash
# .mp4ファイルの高さを指定値にする


if [ $# -ne 2 ]; then
  echo "argument error:\nusage:\nmp4conv_srt_x.sh height" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -vf scale=-1:$2 -strict -2 -an -pix_fmt yuv420p conv/$1 -y

