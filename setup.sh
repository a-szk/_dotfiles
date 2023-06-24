#!/bin/sh

self_dir=$(cd $(dirname $0); pwd)
cd $self_dir/..

sudo apt -y install git

mkdir -p .config/nvim
mkdir -p .config/compton
mkdir -p .config/i3
mkdir -p .config/i3status
mkdir -p .vim/bundle
mkdir -p .nvim/bundle
ln -sf $self_dir/_bashrc .bashrc
ln -sf $self_dir/_vimrc .vimrc
ln -sf $self_dir/compton.conf .config/compton/compton.conf
ln -sf $self_dir/_vimrc .config/nvim/init.vim
ln -sf $self_dir/i3-config .config/i3/config
ln -sf $self_dir/i3status.conf .config/i3status/config
git clone https://github.com/Shougo/neobundle.vim.git .vim/bundle/neobundle.vim
git clone https://github.com/Shougo/neobundle.vim.git .nvim/bundle/neobundle.vim

sudo apt -y install vim neovim compton i3 xsel tree colordiff feh

