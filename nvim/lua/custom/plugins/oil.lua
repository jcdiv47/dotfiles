return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      keymaps = {
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['<C-s>'] = 'actions.select_vsplit',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        -- disable some conflicting keymaps
        ['<C-h>'] = false, -- 'actions.select_split',
        ['<C-t>'] = false, -- 'actions.select_tab',
        ['<C-l>'] = false, -- 'actions.refresh',
      },
    }
    local map = vim.keymap.set
    map('n', '<leader>o', '<cmd>:Oil<cr>', { desc = 'Open parent directory' })
  end,
}
