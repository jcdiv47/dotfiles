local map = vim.keymap.set

map("i", "jj", "<Esc>")
map("i", "jk", "<Esc><cmd>w<cr>")

map("n", "<leader>bx", function()
  Snacks.bufdelete()
end, { desc = "Close current buffer" })

map("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open Oil" })
map("n", "<leader>rt", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Render Markdown" })
