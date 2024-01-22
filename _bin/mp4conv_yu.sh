#!/bin/sh
# ディレクトリ内のすべての.mp4ファイルをwinでも見られるフォーマットに変換する

if [ $# -ne 0 ]; then
  echo "argument error:\nusage:\nmp4conv_yu.sh" 1>&2
  exit 1
fi

mkdir conv
ls | grep -E "*.mp4" | xargs -IXXX -n 1 -P32 ffmpeg -i XXX -acodec copy -pix_fmt yuv420p conv/XXX
