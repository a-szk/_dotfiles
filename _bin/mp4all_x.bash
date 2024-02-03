#!/bin/bash
# ディレクトリ内のすべての.mp4ファイルをx倍速にする。字幕はつかない

if [ $# -ne 1 ]; then
  echo "argument error:\nusage:\nmp4convx.sh speed" 1>&2
  exit 1
fi

mkdir -p conv
ls | grep -E "*.mp4" | xargs -IXXX -n 1 -P8 ffmpeg -i XXX -vf setpts=PTS/$1 -af atempo=$1 -pix_fmt yuv420p conv/XXX
