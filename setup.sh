#!/bin/sh

# this script can be called in duplicate

sudo apt update
sudo apt -y install git

self_dir=$(cd $(dirname $0); pwd)
cd $self_dir/..

mkdir -p .config/nvim
mkdir -p .config/compton
mkdir -p .config/i3
mkdir -p .config/i3status
mkdir -p .nvim/bundle
mkdir -p bin

if [[ ! e .nvim/bundle/neobundle.vim]]; then
    git clone https://github.com/Shougo/neobundle.vim.git .nvim/bundle/neobundle.vim
fi

ln -sf $self_dir/_bashrc .bashrc
ln -sf $self_dir/_tmux.conf .tmux.conf
ln -sf $self_dir/compton.conf .config/compton/compton.conf
ln -sf $self_dir/_vimrc .config/nvim/init.vim
ln -sf $self_dir/_byobu .byobu
ln -sf $self_dir/i3-config .config/i3/config
ln -sf $self_dir/i3status.conf .config/i3status/config
ls $self_dir/_bin | xargs -n1 -IXXX ln -sf $self_dir/_bin/XXX bin/XXX

sudo apt -y install neovim xsel tree colordiff compton feh vlc ffmpeg byobu x11vnc i3* ttf-dejavu* fonts-ipafont pm-utils net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc clang-format-12

# for clang-format.vim
cd /usr/bin
sudo ln -sf clang-format-12 clang-format

# for nvim by root
sudo mkdir -p /root/.config/nvim
sudo mkdir -p /root/.nvim/
sudo ln -sf $self_dir/_vimrc /root/.config/nvim/init.vim
sudo ln -sf $self_dir/.nvim/bundle /root/.nvim/bundle

echo ""
echo ""
echo "Modify i3status.conf for network!"
