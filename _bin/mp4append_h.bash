#!/bin/bash
# 動画を横に並べてくっつける
# mp4append_h.sh 【入力ファイル左】 【入力ファイル右】 【出力ファイル】

if [ $# -ne 3 ]; then
  echo "argument error:\nusage:\nmp4append_h.sh input_left.mp4 input_right.mp4 output.mp4" 1>&2
  exit 1
fi

ffmpeg -i $1 -i $2 -filter_complex "hstack" -strict -2 -pix_fmt yuv420p $3
