" === TERMINAL ===

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert
autocmd BufWinEnter,WinEnter term://* startinsert

let g:floaterm_borderchars = "─│─│┌┐╯╰"

