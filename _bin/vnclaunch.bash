#!/bin/bash

killall -9 x11vnc
x11vnc -display :1 -rfbport 5900 -nopw -auth guess -noxdamage -nomodtweak -clear_all


