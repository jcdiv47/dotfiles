return {
  'utilyre/barbecue.nvim',
  event = 'VeryLazy',
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    -- TODO: change hex colors to colors defined in colorscheme used for neovim
    theme = {
      -- normal = { bg = require('kickstart.plugins.tokyonight')[1].color_bg },
      -- normal = { bg = '#011628' },
      dirname = { fg = '#737aa2' },
      basename = { bold = true },
    },
    context_follow_icon_color = false,
  },
}
