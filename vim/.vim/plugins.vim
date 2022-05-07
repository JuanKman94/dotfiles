filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Traverse the system tree with style, press `-`!
Plugin 'tpope/vim-vinegar'

" Directory tree
Plugin 'scrooloose/nerdtree'

" HTML snippets - Tutorial: https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
Plugin 'mattn/emmet-vim'

" Ctrl+P plugin
" Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

filetype plugin indent on " required
