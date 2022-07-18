let mapleader = ','   " The default <Leader> is '\', but ',' seems better

"""""" Mappings

" Make it easy to edit Vimrc file
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Dealing with splitscreen, Alt + <key> to move between screens
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Redraw screen and run nohlsearch when pressing <CTRL-l>
nnoremap <silent> <c-l> :nohl<cr><c-l>

" Open tag under cursor in a new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" Store current session on file
nmap <Leader>z :mksession! ~/.vim/sessions/

" Restore previous session
nmap <Leader>Z :source ~/.vim/sessions/
" Open a new tab
nmap <Leader>t :tabnew 

" Open a new Horizontal split window
nmap <Leader>s :split 

" Open a new Vertically split window
nmap <Leader>v :vsplit 

""" plugins

" Make NERDTree easier to toggle
let NERDTreeHijackNetrw = 0
nmap <Leader>n :NERDTreeToggle<cr>


"""""" Settings

set wildmenu    " Cool autocompletion menu
set showcmd     " Always show status
set cursorline  " Underline current line
set nobackup    " No backup ~ files
set noundofile
set splitbelow  " When HSplit, add screen below
set splitright  " When VSplit, add screen to the right
set modeline
set modelines=3
set shiftwidth=4 " tab behavior
set tabstop=4 " tab behavior
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search -- find matches as you type
set hlsearch		" Highlight search
set number			" Let's activate line numbers
set relativenumber	" And relative line numbers
" set grepprg=rg\ --vimgrep\ $*
set grepformat='%f:%l:%c%m'

" ---- Visuals ----

"set noruler
"set laststatus=2
set statusline=%f\ >\ %l,%c\ %y%r\ %=%L\ lines\ [%p%%]
set rulerformat=%24(%y%=\ %l,%c\ [%p%%]%)

set diffopt=vertical

colorscheme tron256


" ---- Folding ----
set foldmethod=indent
set foldlevelstart=7
nnoremap z1 :set foldlevel=0<CR>
nnoremap z2 :set foldlevel=1<CR>
nnoremap z3 :set foldlevel=2<CR>
nnoremap z4 :set foldlevel=3<CR>

"highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" ---- FileType ----
autocmd BufNewFile,BufRead *.ts set filetype=javascript " Treat TypeScriptX file as js
autocmd BufNewFile,BufRead *.tsx set filetype=javascript " Treat TypeScriptX file as js
autocmd BufNewFile,BufRead *.vue set filetype=javascript " Treat vue file as js
autocmd BufNewFile,BufRead *.scss set filetype=css " Treat scss file as css
" autocmd BufNewFile,BufRead *.blade.php set filetype=html " Treat blade files as html
" autocmd BufNewFile,BufRead *.ftl set filetype=html " Treat FreeMarker's files as html


""""""" neovim
lua <<EOF
local packer_plugins = require('plugins')

--[[
# LSP: how to use it

Ensure you have `solargraph` installed for the project's ruby version

    $ gem install solargraph solargraph-standardrb

Some of the LSP features and their key mappings are listed here.
But there are many more. See `:help LSP` for the full list.

Key map 	Action
<c-x> <c-o> -- Complete
g d         -- Jump to definition
K           -- Show hover documentation
g r         -- Open quickfix with all references to method
r n         -- Rename method and update references

@see https://blog.backtick.consulting/neovims-built-in-lsp-with-ruby-and-rails/
--]]

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_bindings = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = lsp_bindings,
	flags = {
	  debounce_text_changes = 150,
	}
  }
end
EOF


nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
