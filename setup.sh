#!/bin/sh
# this script can be called in duplicate

if [ "`whoami`" = "root" ]; then
  echo "Please run as a user, without sudo." 1>&2
  exit 1
fi

self_dir=$(cd $(dirname $0); pwd)
cd $HOME

sudo apt update
sudo apt -y install git vim neovim xsel tree colordiff compton feh vlc ffmpeg byobu x11vnc i3* ttf-dejavu* fonts-ipafont pm-utils net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc clang-format-12

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/compton
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/i3status
mkdir -p $HOME/.nvim/bundle
mkdir -p $HOME/.vim/bundle
mkdir -p $HOME/bin

# vim, nvim
if [ ! -e $HOME/.nvim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME/.nvim/bundle/neobundle.vim
fi
if [ ! -e $HOME/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi

echo "";echo "";echo ""

now=`date '+%Y%m%d_%H_%M'`
bak_dir="$self_dir/.backup/bak_$now"

MoveWithBackUp()
{
    if [ -e $3/$2 ];then
        mkdir -p $bak_dir
        cp -rfL $3/$2 $bak_dir/$1
        echo "Original config was moved to ~/_dotfiles/.backup/bak_$now/$1"
        rm -rf $3/$2
    fi
    ln -sf $self_dir/$1 $3/$2
}

MoveShellsWithBackUp()
{
    output=""
    for file in $(ls -1 $self_dir/$1); do
        if [ -e $3/$2/$file ];then
            mkdir -p $bak_dir/$1
            cp -rfL $3/$2/$file $bak_dir/$1/$file
            rm -rf $3/$2/$file
            output="$output, $file"
        fi
        ln -sf $self_dir/$1/$file $3/$2/$file
    done
    if [ -z "$output" ];then
        echo "Original $2 files are moved to ~/_dotfiles/.backup/bak_$now/$1/"
    fi
}

MoveWithBackUp          _bashrc          .bashrc         $HOME
MoveWithBackUp          _compton.conf    compton.conf    $HOME/.config/compton
MoveWithBackUp          _vimrc           init.vim        $HOME/.config/nvim
MoveWithBackUp          _vimrc           .vimrc          $HOME
MoveWithBackUp          _byobu           .byobu          $HOME
MoveWithBackUp          _tmux.conf       .tmux.conf      $HOME
MoveWithBackUp          _i3-config       config          $HOME/.config/i3
MoveWithBackUp          _i3status.conf   config          $HOME/.config/i3status
MoveShellsWithBackUp    _bin             bin             $HOME

# for clang-format.vim
cd /usr/bin
sudo ln -sf clang-format-12 clang-format

# for vim, nvim by root
sudo mkdir -p /root/.config/nvim
sudo mkdir -p /root/.nvim/
sudo mkdir -p /root/.vim
sudo ln -sf $self_dir/_vimrc /root/.config/nvim/init.vim
sudo ln -sf $self_dir/_vimrc /root/.vimrc
sudo ln -sf $HOME/.nvim/bundle /root/.nvim/bundle
sudo ln -sf $HOME/.vim/bundle /root/.vim/bundle

echo ""
echo ""
echo "Modify i3status.conf for network!"

exit 0
