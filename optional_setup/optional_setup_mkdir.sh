#!/bin/sh
# this script can be called in duplicate
#

if [ "`whoami`" = "root" ]; then
  echo "Please run as a user, without sudo." 1>&2
  exit 1
fi

user=`whoami`

sudo mkdir -p $HOME/.config/compton; sudo chown $user:$user $HOME/.config; sudo chown $user:$user $HOME/.config/compton
sudo mkdir -p $HOME/.config/i3; sudo chown $user:$user $HOME/.config; sudo chown $user:$user $HOME/.config/i3
sudo mkdir -p $HOME/.config/i3status; sudo chown $user:$user $HOME/.config; sudo chown $user:$user $HOME/.config/i3status

exit 0
