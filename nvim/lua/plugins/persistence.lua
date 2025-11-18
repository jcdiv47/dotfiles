return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  config = function()
    require("persistence").setup({
      vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
      end, { desc = "Restore the session for the current directory" }), -- Restore the session for the current directory
      vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load({ last = true })
      end, { desc = "Restore the last session" }), -- Restore the last session
      vim.keymap.set("n", "<leader>qS", function()
        require("persistence").select()
      end, { desc = "Select a session to load" }), -- Select a session to load
      vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
      end, { desc = "Stop Persistence" }), -- Stop Persistence => session won't be saved on exit
    })
  end,
}
