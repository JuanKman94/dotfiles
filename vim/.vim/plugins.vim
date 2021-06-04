filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Traverse the system tree with style, press `-`!
Plugin 'tpope/vim-vinegar'

" Git commands
Plugin 'tpope/vim-fugitive'

" Directory tree
Plugin 'scrooloose/nerdtree'

" plugin from http://vim-scripts.org/vim/scripts.html, useful when writing vim
" scripts
" Plugin 'L9'

" HTML snippets - Tutorial: https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
Plugin 'mattn/emmet-vim'

" Ctrl+P plugin
Plugin 'ctrlpvim/ctrlp.vim'

" themes
Plugin 'whatyouhide/vim-gotham'

" filetype support
Plugin 'kchmck/vim-coffee-script'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on " required
