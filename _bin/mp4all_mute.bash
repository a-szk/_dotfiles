#!/bin/bash

if [ $# -ne 0 ]; then
  echo "argument error:\nusage:\nmp4conv_yu.sh" 1>&2
  exit 1
fi

mkdir -p conv
ls | grep -E "*.mp4" | xargs -IXXX -n 1 -P32 ffmpeg -i XXX -an -pix_fmt yuv420p conv/XXX
