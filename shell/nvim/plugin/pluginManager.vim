highlight! Cursor guibg=#ffffff guifg=#000000
set guicursor=n-v:block-Cursor

augroup PlugWindowCursor
				autocmd BufLeave plug* hi Cursor blend=0
				autocmd BufEnter plug* hi Cursor blend=100


