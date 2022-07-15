" === GENERAL ===

set number
set nocompatible
set showmatch
set tabstop=2
" set cc=5

" === NETRW ===

let g:netrw_banner = 0
let g:netrw_winsize=80
let g:netrw_liststyle=3
let g:netrw_browse_split=2

" === VIM PLUG ===

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

" === VIM TREE ===

lua << EOF
require("nvim-tree").setup()
EOF

" === DEV ICONS ===

lua << EOF
require'nvim-web-devicons'.setup {
 override = {

 };
 default = true;
}
EOF
