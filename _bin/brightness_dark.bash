#!/bin/bash

if [ $# -ne 0 ]; then
  xrandr --output eDP-1 --brightness $1
  exit 1
else
  xrandr --output eDP-1 --brightness 0.2
  exit 1
fi


