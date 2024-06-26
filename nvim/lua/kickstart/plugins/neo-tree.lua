-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    -- { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    { '<leader>e', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    source_selector = {
      winbar = true,
    },
    filesystem = {
      window = {
        mappings = {
          -- ['\\'] = 'close_window',
          ['<leader>e'] = 'close_window',
          ['<tab>'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
        },
      },
    },
  },
}
