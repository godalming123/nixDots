" === GENERAL ===

set tgc " better coloring
set number
set autoindent
set nocompatible
set showmatch
set tabstop=2
set mouse=v
set mouse=a
set splitright
set ttyfast
set clipboard+=unnamedplus

"let g:clipboard = {
"  'name': 'wlClpiboard',
"	'copy': {
"					'+': ['wl-paste'],
"					'*': ['wl-paste'],
"  },
"	'paste': {
"          '+': ['wl-paste', ''],
"					'*': ['wl-paste', ''],
"  },
"	'cache_enabled' : 1
"}

" === VIM PLUG ===

call plug#begin()
				Plug 'kyazdani42/nvim-web-devicons' " font icons
				Plug 'preservim/nerdtree' " file tree
				Plug 'https://github.com/preservim/tagbar' " tagbar for code navigation
				Plug 'feline-nvim/feline.nvim' " status line

				" completion:
				Plug 'neovim/nvim-lspconfig'
				Plug 'hrsh7th/cmp-nvim-lsp'
				Plug 'hrsh7th/cmp-buffer'
				Plug 'hrsh7th/cmp-path'
				Plug 'hrsh7th/cmp-cmdline'
				Plug 'hrsh7th/nvim-cmp'
				Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
call plug#end()


