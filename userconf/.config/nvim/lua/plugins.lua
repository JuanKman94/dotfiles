-- Run :PackerSync if this file changes
--
-- @see https://github.com/wbthomason/packer.nvim#quickstart
vim.cmd  [[packadd packer.nvim]]

return require('packer').startup(function()
	-- plugin manager
	use 'wbthomason/packer.nvim'

	-- traverse the system tree with style, press `-`!
	use 'tpope/vim-vinegar'

	-- directory tree
	use 'scrooloose/nerdtree'

	-- HTML snippets - Tutorial: https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
	use 'mattn/emmet-vim'

	-- color previews
	use 'ap/vim-css-color'

	-- lsp support
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
end)
