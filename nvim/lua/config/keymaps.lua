-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<ESC>") -- Use jj to escape
vim.keymap.set("i", "jk", "<ESC><cmd>w<CR>") -- Use jk to escape and save

vim.keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Close current [B]uffer" }) -- close current buffer

--  ==== Copy and paste/yank ====
vim.keymap.set("n", "x", '"_x') -- Delete single character without copying into register
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', {
  desc = "Yank to system clipboard (+)",
})
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', {
  desc = "Paste from system clipboard (+)",
})
