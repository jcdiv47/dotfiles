-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'brenoprata10/nvim-highlight-colors',
    lazy = false,
    opts = {},
  },

  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split' },
    },
  },
}
