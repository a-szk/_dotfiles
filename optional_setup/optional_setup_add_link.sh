#!/bin/sh
# this script can be called in duplicate
#

if [ $# -ne 3 ]; then
  echo "invalid arguments of $SH_COMMAND" 1>&2
  exit 1
fi

if [ "`whoami`" = "root" ]; then
  echo "$0: Please run as a user, without sudo." 1>&2
  exit 1
fi

user=`whoami`

self_dir=$1
now=$2
bak_dir=$3

optional_self_dir=$self_dir/optional_setup
optional_bak_dir=$bak_dir/optional

MoveOptionalWithBackUp()
{
    if [ -e $3/$2 ];then
        mkdir -p $optional_bak_dir
        cp -rfL $3/$2 $optional_bak_dir/$1
        echo "Original config was moved to ~/_dotfiles/backup/bak_$now/optional/$1"
        sudo rm -rf $3/$2
    fi
    ln -sf $optional_self_dir/$1 $3/$2
    sudo chown $user:$user $3/$2
    return 0
}

MoveOptionalShellsWithBackUp()
{
    output=""
    for file in $(ls -1 $optional_self_dir/$1); do
        if [ -e $3/$2/$file ];then
            mkdir -p $optional_bak_dir/$1
            cp -rfL $3/$2/$file $optional_bak_dir/$1/$file
            sudo rm -rf $3/$2/$file
            output="$output, $file"
        fi
        ln -sf $optional_self_dir/$1/$file $3/$2/$file
        sudo chown $user:$user $3/$2/$file
    done
    if [ -n "$output" ];then
        echo "Original $2 files are moved to ~/_dotfiles/backup/bak_$now/optional/$1/"
    fi
    return 0
}

MoveOptionalWithBackUp          _compton.conf    compton.conf    $HOME/.config/compton
MoveOptionalWithBackUp          _i3-config       config          $HOME/.config/i3
MoveOptionalWithBackUp          _i3status.conf   config          $HOME/.config/i3status
MoveOptionalShellsWithBackUp    _bin             bin             $HOME

exit 0
