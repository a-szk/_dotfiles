#!/bin/bash
# ディレクトリ内のすべての.mp4ファイルを1倍、2倍、4倍、8倍、16倍したものを自動生成する。

if [ $# -ne 0 ]; then
  echo "argument error:\nusage:\nmp4conv_x_all.sh" 1>&2
  exit 1
fi

echo "1\n2\n4\n8\n16" | xargs -IXXX -n 1 -P5 mp4conv_x_all.sh XXX

