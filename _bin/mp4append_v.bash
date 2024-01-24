#!/bin/bash
# 動画を縦に並べてくっつける
# mp4append_h.sh 【入力ファイル上】 【入力ファイル下】 【出力ファイル】

if [ $# -ne 3 ]; then
  echo "argument error:\nusage:\nmp4append_v.sh input_top.mp4 input_bottom.mp4 output.mp4" 1>&2
  exit 1
fi

ffmpeg -i $1 -i $2 -filter_complex "vstack" -strict -2 -an -pix_fmt yuv420p $3
