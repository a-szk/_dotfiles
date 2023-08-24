#!/bin/sh

# this script can be called in duplicate


self_dir=$(cd $(dirname $0); pwd)
cd $HOME

mkdir -p .config/nvim
mkdir -p .config/compton
mkdir -p .nvim/bundle
mkdir -p bin


ln -sf $self_dir/_bashrc .bashrc
ln -sf $self_dir/_compton.conf .config/compton/compton.conf
ln -sf $self_dir/_vimrc .config/nvim/init.vim
rm -rf .byobu
ln -sf $self_dir/_byobu .byobu
ln -sf $self_dir/_tmux.conf .tmux.conf
ls $self_dir/_bin | xargs -n1 -IXXX ln -sf $self_dir/_bin/XXX bin/XXX

sudo apt update
sudo apt -y install git neovim xsel tree colordiff compton feh vlc ffmpeg byobu x11vnc pm-utils net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc clang-format-12

# nvim
if [ ! -e .nvim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git .nvim/bundle/neobundle.vim
fi

# for clang-format.vim
cd /usr/bin
sudo ln -sf clang-format-12 clang-format

# for nvim by root
sudo mkdir -p /root/.config/nvim
sudo mkdir -p /root/.nvim/
sudo ln -sf $self_dir/_vimrc /root/.config/nvim/init.vim
sudo ln -sf $HOME/.nvim/bundle /root/.nvim/bundle

