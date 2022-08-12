-- === GENERAL ===

local vim = vim -- if I define vim here I only get one undefined global vim instead of 13

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
-- vim.opt.laststatus = 3

-- === VIM PLUG ===

vim.cmd([[
call plug#begin()
        Plug 'nvim-lua/plenary.nvim' " random dependencys yay!
				Plug 'nvim-telescope/telescope.nvim' " search fuzzy finder
				Plug 'kyazdani42/nvim-web-devicons' " font icons
				Plug 'preservim/nerdtree' " file tree
				Plug 'https://github.com/preservim/tagbar' " tagbar for code navigation
				Plug 'feline-nvim/feline.nvim' " status line
				Plug 'lewis6991/gitsigns.nvim' " git things
				Plug 'ziontee113/icon-picker.nvim' " icon picker
				Plug 'stevearc/dressing.nvim' " custom vim ui
				" Plug 'prettier/vim-prettier' " pretifier - not working
				Plug 'shaunsingh/nord.nvim' " nord theme
	      Plug 'voldikss/vim-floaterm' " popup terminal
	      Plug 'Pocco81/AutoSave.nvim' " autosave

				" completion:
				Plug 'neovim/nvim-lspconfig'
				Plug 'hrsh7th/cmp-nvim-lsp'
				Plug 'hrsh7th/cmp-buffer'
				Plug 'hrsh7th/cmp-path'
				Plug 'hrsh7th/cmp-cmdline'
				Plug 'hrsh7th/nvim-cmp'
				Plug 'tpope/vim-commentary' " For Commenting gcc & gc
				" Plug 'hrsh7th/vim-vsnip'
        " Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()
]])

