return {
  'willothy/nvim-cokeline',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'stevearc/resession.nvim', -- Optional, for persistent history
  },
  config = function()
    local is_picking_focus = require('cokeline.mappings').is_picking_focus
    local is_picking_close = require('cokeline.mappings').is_picking_close
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    local red = vim.g.terminal_color_1
    local yellow = vim.g.terminal_color_3

    -- TODO: add keymap for closing currently focused buffer
    -- don't forget to remove the one in keymaps.lua
    require('cokeline').setup {
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
        end,
        bg = function()
          return get_hex('ColorColumn', 'bg')
        end,
      },

      components = {
        {
          text = function(buffer)
            return (buffer.index ~= 1) and '▏' or ''
          end,
        },
        {
          text = '  ',
        },
        {
          text = function(buffer)
            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or buffer.devicon.icon
          end,
          fg = function(buffer)
            return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
          end,
          italic = function()
            return (is_picking_focus() or is_picking_close())
          end,
          bold = function()
            return (is_picking_focus() or is_picking_close())
          end,
        },
        -- {
        --   text = ' ',
        -- },
        {
          text = function(buffer)
            return buffer.filename .. '  '
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
        },
        {
          text = '',
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
        },
        {
          text = '  ',
        },
      },
      pick = {
        -- Whether to use the filename's first letter first before
        -- picking a letter from the valid letters list in order.
        -- default: `true`
        ---@type boolean
        use_filename = true,

        -- The list of letters that are valid as pick letters. Sorted by
        -- keyboard reachability by default, but may require tweaking for
        -- non-QWERTY keyboard layouts.
        -- default: `'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP'`
        -- TODO: change it for Colemak-DH layout
        ---@type string
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP',
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
    }
    local map = vim.api.nvim_set_keymap
    map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    map('n', '<leader>sp', '<Plug>(cokeline-switch-prev)', { desc = '[S]witch buffer backward', silent = true })
    map('n', '<leader>sn', '<Plug>(cokeline-switch-next)', { desc = '[S]witch buffer forward', silent = true })
    map('n', '<leader>pf', '<Plug>(cokeline-pick-focus)', { desc = '[F]ocus a buffer by its `[P]ick_letter`', silent = true })
    map('n', '<leader>pc', '<Plug>(cokeline-pick-close)', { desc = '[C]lose a buffer by its `[P]ick_letter`', silent = true })
    vim.keymap.set('n', '<leader>bp', function()
      require('cokeline.mappings').pick 'focus'
    end, { desc = 'Pick a buffer to focus' })
  end,
}
