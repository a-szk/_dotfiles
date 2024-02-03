#!/bin/bash

if [ $# -ne 1 ]; then
  echo "argument error:\nusage:\nmp4conv_yu.sh" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -an -pix_fmt yuv420p conv/$1
