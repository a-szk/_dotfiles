#!/bin/sh

tmux ls | grep -v "(attached)" | cut -d":" -f1 | xargs -n1 -P16 -IXXX tmux kill-session -t XXX

