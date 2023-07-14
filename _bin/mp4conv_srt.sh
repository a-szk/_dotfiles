#!/bin/sh
# .mp4ファイルに字幕が付いたものを自動生成する

if [ $# -ne 2 ]; then
  echo "argument error:\nusage:\nmp4conv_srt.sh string input.mp4" 1>&2
  exit 1
fi

mkdir -p conv
echo "1\n00:00:00,000 --> 00:99:99,000\n$2">conv/tmp.srt
ffmpeg -i $1 -vf "subtitles=conv/tmp.srt:force_style='FontSize=42,Alignment=2'" -strict -2 -an -pix_fmt yuv420p conv/$1
rm conv/tmp.srt
