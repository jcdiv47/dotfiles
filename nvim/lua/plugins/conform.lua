return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      json = { "jq" },
    },
  },
}
