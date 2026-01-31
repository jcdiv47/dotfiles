-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use jj to escape
vim.keymap.set("i", "jj", "<ESC>")
-- Use jk to escape and save
vim.keymap.set("i", "jk", "<ESC><cmd>w<CR>")

vim.keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Close current [B]uffer" }) -- close current buffer
