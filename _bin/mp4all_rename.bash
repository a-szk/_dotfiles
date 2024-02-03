#!/bin/bash

if [ $# -ne 0 ]; then
  echo "argument error:\nusage:\nmp4conv_x_all.sh" 1>&2
  exit 1
fi


files=(`ls -F | grep -v /`)
mp4lists=""
for filename in "${files[@]}"; do
  extension="${filename##*.}"
  if [ "${extension,,}" == "mp4" ]; then
    mp4lists="${mp4lists}\n${filename}"
  fi
done

if [ "${mp4lists}" == "" ]; then
    exit 1
fi
mkdir -p conv
echo -e "${mp4lists}" | grep -v '^$' | xargs -n1 -P32 -IXXX cp -f XXX conv/XXX
cd conv

function to_lower_ext() {
  filename="$1"
  extension="${filename##*.}"
  if [ "$extension" != "${extension,,}" ]; then
    new_filename="${filename%.*}.${extension,,}"
    mv "$filename" "$new_filename"
  fi
}

export -f to_lower_ext
ls | xargs -n1 -P32 -IXXX bash -c 'to_lower_ext XXX'
