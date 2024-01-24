#!/bin/bash
# this script can be called in duplicate
#

if [ "`whoami`" = "root" ]; then
  echo "$0: Please run as a user, without sudo." 1>&2
  exit 1
fi

