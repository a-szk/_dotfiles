#!/bin/sh

sudo apt update
sudo apt -y install git

self_dir=$(cd $(dirname $0); pwd)
cd $self_dir/..

mkdir -p .config/nvim
mkdir -p .config/compton
mkdir -p .config/i3
mkdir -p .config/i3status
mkdir -p .nvim/bundle
git clone https://github.com/Shougo/neobundle.vim.git .nvim/bundle/neobundle.vim

ln -sf $self_dir/_bashrc .bashrc
ln -sf $self_dir/compton.conf .config/compton/compton.conf
ln -sf $self_dir/_vimrc .config/nvim/init.vim
ln -sf $self_dir/_bin bin
ln -sf $self_dir/_byobu .byobu
ln -sf $self_dir/i3-config .config/i3/config
ln -sf $self_dir/i3status.conf .config/i3status/config

sudo apt -y install neovim xsel tree colordiff compton feh clang-format-6.0 vlc ffmpeg byobu x11vnc i3* ttf-dejavu* fonts-ipafont net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc

echo ""
echo ""
echo "Modify i3status.conf for network!"
