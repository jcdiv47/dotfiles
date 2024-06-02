return {
  'willothy/nvim-cokeline',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'stevearc/resession.nvim', -- Optional, for persistent history
  },
  config = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    local yellow = vim.g.terminal_color_3

    -- TODO: add keymap for closing currently focused buffer
    -- don't forget to remove the one in keymaps.lua
    require('cokeline').setup {
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
        end,
        bg = get_hex('ColorColumn', 'bg'),
      },
      sidebar = {
        filetype = { 'NvimTree', 'neo-tree' },
        components = {
          {
            text = function(buf)
              return buf.filetype
            end,
            fg = yellow,
            bg = function()
              return get_hex('NvimTreeNormal', 'bg')
            end,
            bold = true,
          },
        },
      },
      components = {

        {
          text = function(buffer)
            return ' ' .. buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = get_hex('Comment', 'fg'),
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. ' '
          end,
          underline = function(buffer)
            return buffer.is_hovered and not buffer.is_focused
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          italic = function(buffer)
            return buffer.is_focused
          end,
        },
        {
          text = ' ' .. '',
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
        },
      },
    }
    local map = vim.api.nvim_set_keymap
    map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    map('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { desc = 'switch buffer forward', silent = true })
    map('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { desc = 'switch buffer backward', silent = true })
  end,
}
