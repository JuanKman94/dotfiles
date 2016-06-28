#!/bin/bash
echo "The script requires sudo to copy global configuration files..."

cp -rv .vim/ .vimrc .config/ .bash_profile .bashrc .Xresources $HOME
touch $HOME/.bash_private
sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/
git clone https://github.com/vundleVim/Vundle.vim.git ~/vim/bundle/Vundle.vim
vim +PluginInstall +qall
