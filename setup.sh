#!/bin/sh
# this script can be called in duplicate

self_dir=$(cd $(dirname $0); pwd)
cd $HOME

sudo apt update
sudo apt -y install git vim neovim xsel tree colordiff compton feh vlc ffmpeg byobu x11vnc i3* ttf-dejavu* fonts-ipafont pm-utils net-tools indicator-cpufreq python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 exfat-fuse exfat-utils openssh-server fcitx-mozc clang-format-12

mkdir -p $HOME.config/nvim
mkdir -p $HOME.config/compton
mkdir -p $HOME.config/i3
mkdir -p $HOME.config/i3status
mkdir -p $HOME.nvim/bundle
mkdir -p $HOME.vim/bundle
mkdir -p $HOME/bin

# vim, nvim
if [ ! -e $HOME.nvim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME.nvim/bundle/neobundle.vim
fi
if [ ! -e $HOME.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim.git $HOME.vim/bundle/neobundle.vim
fi

ln -sf $self_dir/_bashrc $HOME.bashrc
ln -sf $self_dir/_compton.conf $HOME.config/compton/compton.conf
ln -sf $self_dir/_vimrc $HOME.config/nvim/init.vim
ln -sf $self_dir/_vimrc .$HOMEvimrc
rm -rf $HOME.byobu
ln -sf $self_dir/_byobu $HOME.byobu
ln -sf $self_dir/_tmux.conf $HOME.tmux.conf
ln -sf $self_dir/_i3-config $HOME.config/i3/config
ln -sf $self_dir/_i3status.conf $HOME.config/i3status/config
ls $self_dir/_bin | xargs -n1 -IXXX ln -sf $self_dir/_bin/XXX $HOME/bin/XXX

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
