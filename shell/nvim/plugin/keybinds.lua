-- === KEYBINDS ===

local opts = { noremap = false, silent = true }
vim.keymap.set("n", "T", "<cmd>TagbarOpenAutoClose<cr>",opts)
vim.keymap.set("n", "<C-n>", "<cmd>NERDTreeFocus<cr>",opts)
vim.keymap.set("n", "<C-t>", "<cmd>vsplit <bar> terminal <cr>",opts)
vim.keymap.set("n", "I", "<cmd>PickEverythingInsert<cr>", opts)
vim.keymap.set("n", "<C-s>", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "H", "<cmd>Telescope help_tags<cr>", opts)
-- move between panes to left/bottom/top/right
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
