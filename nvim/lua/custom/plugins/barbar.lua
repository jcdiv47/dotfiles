return {
  'romgrk/barbar.nvim',
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require('barbar').setup {
      icons = {
        modified = { button = '●' },
        pinned = { button = '', filename = true },
      },
      preset = 'powerline',
      sidebar_filetypes = {
        ['neo-tree'] = { event = 'BufWinLeave', text = 'neo-tree', align = 'left' },
      },
    }
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map('n', '<tab>', '<cmd>BufferNext<cr>', opts)
    map('n', '<S-tab>', '<cmd>BufferPrevious<cr>', opts)
    map('n', '<A-,>', '<cmd>BufferMovePrevious<cr>', opts)
    map('n', '<A-.>', '<cmd>BufferMoveNext<cr>', opts)
    map('n', '<A-p>', '<cmd>BufferPin<cr>', opts)
    map('n', '<leader>x', '<cmd>BufferClose<cr>', opts)
    map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts) -- Magic buffer-picking mode
  end,
}
