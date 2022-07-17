-- === GENERAL ===

vim.opt.tgc = true
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.tabstop = 2
vim.opt.mouse='va'
vim.opt.splitright=true
vim.opt.ttyfast = true
vim.cmd("set clipboard+=unnamedplus")
vim.opt.laststatus = 3

-- === VIM PLUG ===

vim.cmd([[
call plug#begin()
				Plug 'kyazdani42/nvim-web-devicons' " font icons
				Plug 'preservim/nerdtree' " file tree
				Plug 'https://github.com/preservim/tagbar' " tagbar for code navigation
				Plug 'feline-nvim/feline.nvim' " status line
				" Plug 'prettier/vim-prettier' " pretifier - not working

				" completion:
				Plug 'neovim/nvim-lspconfig'
				Plug 'hrsh7th/cmp-nvim-lsp'
				Plug 'hrsh7th/cmp-buffer'
				Plug 'hrsh7th/cmp-path'
				Plug 'hrsh7th/cmp-cmdline'
				Plug 'hrsh7th/nvim-cmp'
				Plug 'tpope/vim-commentary' " For Commenting gcc & gc
call plug#end()
]])

