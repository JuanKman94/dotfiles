#!/bin/bash
echo "The script requires sudo to copy global configuration files..."

while [ "$1" != "" ]; do
    case $1 in
        f | --fonts)
            shift
            bash ./install-terminus-font.sh # run installation script
            ;;
        *)
            ;;
    esac
    shift
done

# Copy these files to homedir
cp -ur .xinitrc \
    .vim/ \
    .vimrc \
    .config/ \
    .bash_profile \
    .bashrc \
    .Xresources \
    bin/ \
    $HOME

source $HOME/.bash_profile
touch $HOME/.bash_private

sudo cp 00-keyboard.conf /etc/X11/Xsession.d/
mkdir -p $HOME/.vim/bundle

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/vundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
