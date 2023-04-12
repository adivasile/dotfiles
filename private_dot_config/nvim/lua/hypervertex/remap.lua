vim.g.mapleader = " "

-- Integrate system clipboard
vim.keymap.set("n", "<leader>p", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>cp", ":let @+=@%<CR>")
vim.keymap.set("n", "<leader>cf", ":let @+=expand(\"%:t:r\")<CR>")

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "<leader>v", ":vsplit<CR>") 
vim.keymap.set("n", "<leader>s", ":split<CR>") 
vim.keymap.set("n", "<leader>x", ":q<CR>") 
vim.keymap.set("n", "<leader>w", ":w<CR>") 

vim.keymap.set("n", "E", "$")
vim.keymap.set("n", "B", "^")
vim.keymap.set("i", "nn", "<ESC>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<M-x>", ":")
