#!/bin/bash

if [ $# -ne 1 ]; then
  echo "argument error:\nusage:\nmp4conv_yu.sh" 1>&2
  exit 1
fi

filename="$1"
extension="${filename##*.}"
if [ "$extension" != "${extension,,}" ]; then
  new_filename="${filename%.*}.${extension,,}"
  mv "$filename" "$new_filename"
fi
