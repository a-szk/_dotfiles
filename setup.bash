#!/bin/bash
# this script can be called in duplicate

if [ "`whoami`" = "root" ]; then
  echo "$0: Please run as a user, without sudo." 1>&2
  exit 1
fi

user=`whoami`
self_dir=$(cd $(dirname $0); pwd)
optional_dir=$self_dir/optional_setup
cd $HOME

DrawLine()
{
    col=`tput cols`
    width=`seq 3 $col`
    for i in $width; do
        echo -en "\033[1;33m-\033[m"
    done
    echo ""
    return 0
}

sudo ls 1>/dev/null

echo ""
DrawLine
echo -en "\033[1;33mAPT Install\033[m"
echo ""
echo ""

sudo apt update
sudo apt -y install git vim neovim xsel rename tree colordiff vlc ffmpeg byobu x11vnc pm-utils net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc nload htop sysstat
source $optional_dir/optional_setup_apt_install.bash

sudo mkdir -p $HOME/.config/nvim; sudo chown $user:$user $HOME/.config; sudo chown $user:$user $HOME/.config/nvim
sudo mkdir -p $HOME/.nvim/bundle; sudo chown $user:$user $HOME/.nvim; sudo chown $user:$user $HOME/.nvim/bundle
sudo mkdir -p $HOME/.vim/bundle; sudo chown $user:$user $HOME/.vim; sudo chown $user:$user $HOME/.vim/bundle
sudo mkdir -p $HOME/bin; sudo chown $user:$user $HOME/bin

source $optional_dir/optional_setup_mkdir.bash

# vim, nvim
if [ ! -e $HOME/.nvim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME/.nvim/bundle/neobundle.vim
fi
if [ ! -e $HOME/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim

fi

echo ""
DrawLine
echo -en "\033[1;33mLink FileSystem\033[m"
echo ""
echo ""

now=`date '+%Y%m%d_%H-%M'`
bak_dir="$self_dir/backup/bak_$now"

MoveWithBackUp()
{
    if [ -e $3/$2 ];then
        mkdir -p $bak_dir
        cp -rfL $3/$2 $bak_dir/$1
        echo "Original config was moved to ~/_dotfiles/backup/bak_$now/$1"
        sudo rm -rf $3/$2
    fi
    ln -sf $self_dir/$1 $3/$2
    sudo chown $user:$user $3/$2
    return 0
}

MoveShellsWithBackUp()
{
    output=""
    for file in $(ls -1 $self_dir/$1); do
        if [ -e $3/$2/$file ];then
            mkdir -p $bak_dir/$1
            cp -rfL $3/$2/$file $bak_dir/$1/$file
            sudo rm -rf $3/$2/$file
            output="$output, $file"
        fi
        ln -sf $self_dir/$1/$file $3/$2/$file
        sudo chown $user:$user $3/$2/$file
    done
    if [ -n "$output" ];then
        echo "Original $2 files are moved to ~/_dotfiles/backup/bak_$now/$1/"
    fi
    return 0
}

MoveWithBackUp          _bashrc          .bashrc         $HOME
MoveWithBackUp          _vimrc           init.vim        $HOME/.config/nvim
MoveWithBackUp          _vimrc           .vimrc          $HOME
MoveWithBackUp          _byobu           .byobu          $HOME
MoveWithBackUp          _tmux.conf       .tmux.conf      $HOME
MoveShellsWithBackUp    _bin             bin             $HOME

source $optional_dir/optional_setup_add_link.bash $self_dir $now $bak_dir


# for clang-format.vim
source $optional_dir/optional_setup_after_install.bash

# for vim, nvim by root
sudo mkdir -p /root/.config/nvim
sudo mkdir -p /root/.nvim/
sudo mkdir -p /root/.vim
sudo ln -sf $self_dir/_vimrc /root/.config/nvim/init.vim
sudo ln -sf $self_dir/_vimrc /root/.vimrc
sudo ln -sf $HOME/.nvim/bundle /root/.nvim/bundle
sudo ln -sf $HOME/.vim/bundle /root/.vim/bundle

echo ""
DrawLine
echo -en "\033[1;33mSetup Finished\033[m"
echo ""
echo ""

source $optional_dir/optional_setup_exit.bash

echo ""
DrawLine

exit 0

