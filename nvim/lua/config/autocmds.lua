vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("nvim12_transparency", { clear = true }),
  desc = "Re-apply transparency after colorscheme changes",
  callback = function()
    local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
    if vim.fn.filereadable(transparency_file) == 1 then
      vim.cmd.source(transparency_file)
    end
  end,
})
