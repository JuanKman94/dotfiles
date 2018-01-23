" ---- Split management ----
set splitbelow          " When HSplit, add screen below
set splitright          " When VSplit, add screen to the right

" Dealing with splitscreen, Alt + <key> to move between screens
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" Store current session on file
nmap <c-s> :mksession! ~/.vim/prev_session <cr>

" Restore previoues session
nmap <c-a> :source ~/.vim/prev_session <cr>

set wildmenu    " Cool autocompletion menu
set showcmd     " Always show status
set cursorline  " Underline current line
set nobackup    " No backup ~ files



" ---- FileType ----
filetype plugin on
autocmd BufNewFile,BufRead *.vue set filetype=javascript " Treat vue file as js
autocmd BufNewFile *.vue 0r ~/.vim/skel/skel.vue " Insert skeleton when new file



" ---- Visuals ----

"set noruler
"set laststatus=2
"set statusline=%f\ >\ %l,%c\ %y%r\ %=%L\ lines\ [%p%%]
set rulerformat=%24(%y%=\ %l,%c\ [%p%%]%)

" Add colors!
syntax on

" Change tab key behavior
set shiftwidth=4
set tabstop=4




" ---- Folding ----
set foldmethod=indent
set foldlevelstart=7




" ---- Behavior ----

" Fix backspace on XTerm
set backspace=indent,eol,start		" allow backspacing over everything in insert mode

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif
fixdel

" ViM features
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search -- find matches as you type
set hlsearch		" Highlight search
set number			" Let's activate line numbers
set relativenumber	" And relative line numbers

" Redraw screen and run nohlsearch when pressing <CTRL-l>
nnoremap <silent> <c-l> :nohl<cr><c-l>

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"



" ---- Vundle ----
set nocompatible	" Be iMproved, required -- Latest vim settings/options
source ~/.vim/plugins.vim
set t_Co=256
colorscheme dracula	" this is installed via Vundle

" ---- Emmet ----
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/snippets.json')), "\n"))




" ---- Laracasts: Vim mastery ----

let mapleader = ','   " The default <Leader> is '\', but ',' seems better





" ------ Visuals ------

set linespace=14      " gVim specific: Change lineheight
set t_CO=256          " Use 256 colors. Useful in terminal Vim





" ------ Mappings ------

" Make it easy to edit Vimrc file
nmap <Leader>ev :tabedit $MYVIMRC<cr>
" '' <Leader> key by default is '\', you can customize it
" '' <cr> <= Carriage Return

" List buffers <= :ls
nmap <Leader>l :ls<cr>

" Open a new tab
nmap <Leader>t :tabnew 

" Open a new Horizontal split window
nmap <Leader>s :split 

" Open a new Vertically split window
nmap <Leader>v :vsplit 





" ------ Plugins ------

" // CtrlP

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Check for variable names, tags 'n' shite
nmap <Leader>r :CtrlPBufTag<cr>

" Most Recently Used files
nmap <Leader>m :CtrlPMRUFiles<cr>

" Enable CtrlPBufTag
"let g:ctrlp_extensions = [ 'buffertag' ]

" Ignore some shite
let g:ctrlp_working_path_mode = 0

" Ignore some more shite
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" How results are displayed
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'

let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = 'ag %s -l --hidden -g ""'  " -- Use silver searcher to look through files


" // NERDTree

" Make NERDTree easier to toggle
nmap <Leader>n :NERDTreeToggle<cr>

let NERDTreeHijackNetrw = 0



" ------ Auto-commands ------

" Automatically source Vimrc file on save
"augroup
"  " Clear out the group, this way we don't replicate
"  autocmd!
"  autocmd BufWritePost .vimrc source %
"augroup END

" Codes & Cheats
"
""" Mappings
" zz                <= Center the screen on cursor
" <c-^>             <= Return to previous location
" <c-[>             <= Go to function definition (requires ctags)
" -                 <= Run vinegar (requires vinegar plugin)
"
" To remove annoying '^M' character:
" :%s/<Ctrl-V><Ctrl-M>/\r/g
