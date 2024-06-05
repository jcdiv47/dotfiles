return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local lualine = require 'lualine'

    local config = {
      options = {
        theme = 'powerline',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', file_status = true, path = 3 } },
        lualine_x = { 'encoding', 'filesize', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_right {
      -- LSP component
      function()
        local msg = 'No Active LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return ' LSP:' .. client.name
          end
        end
        return msg
      end,
      color = { gui = 'bold' },
    }

    lualine.setup(config)
  end,
}
