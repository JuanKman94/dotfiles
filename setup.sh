#!/bin/bash

cp -rv .vim/ .vimrc .config/ .bash_profile .bashrc .Xresources $HOME
touch $HOME/.bash_private
cp 00-keyboard.conf /etc/X11/xorg.conf.d/
