#!/bin/bash
# .mp4ファイルをx倍したものを自動生成する。1倍速以外の場合は速度に関する字幕が付く

if [ $# -ne 2 ]; then
  echo "argument error:\nusage:\nmp4conv_srt_x.sh speed input.mp4" 2>&2
  exit 1
fi

mkdir -p conv_x$1
if [ $1 == "1" ]; then
  ffmpeg -i $2 -vf "setpts=PTS/$1" -strict -2 -pix_fmt yuv420p conv_x$1/x$1_$2
else
  echo "1\n00:00:00,000 --> 00:99:99,000\nx$1">conv_x$1/tmp$2.srt
  ffmpeg -i $2 -vf "setpts=PTS/$1,subtitles=conv_x$1/tmp$2.srt:force_style='FontSize=42,Alignment=2'" -strict -2 -acodec copy -pix_fmt yuv420p conv_x$1/x$1_$2
  rm conv_x$1/tmp$2.srt
fi
