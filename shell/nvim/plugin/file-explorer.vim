" NERDTREE

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" Attempt to Change cursor when nerdtree is focused
highlight! Cursor guibg=#ffffff guifg=#000000
set guicursor=n-v:block-Cursor

augroup NERDTreeCursor
				autocmd BufLeave NERD_tree* hi Cursor blend=0
				autocmd BufEnter NERD_tree* hi Cursor blend=100


let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" === NETRW ===

let g:netrw_banner = 0
let g:netrw_winsize=80
let g:netrw_liststyle=3
let g:netrw_browse_split=2
