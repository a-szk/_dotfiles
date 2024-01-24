#!/bin/bash
# 動画に画像をオーバーレイしてくっつける


if [ $# -ne 2 ]; then
  echo "argument error:" 1>&2
  exit 1
fi

mkdir -p conv
ffmpeg -i $1 -i $2 -filter_complex "[0:v][1:v] overlay=1000:370:enable='between(t,24,28)'" -strict -2 -an -pix_fmt yuv420p conv/$1 -y
