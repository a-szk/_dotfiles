#!/bin/bash
# ディレクトリ内のすべての.mp4ファイルを1倍、2倍、4倍、8倍、16倍したものを自動生成する。

if [ $# -ne 1 ]; then
  echo "argument error:\nusage:\nmp4conv_x_all.sh number" 1>&2
  exit 1
fi

ls | grep -E "*.mp4" | xargs -IXXX -n 1 -P8 mp4conv_srt_x.sh $1 XXX
