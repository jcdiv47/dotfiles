return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local obsidian = require 'obsidian'
    obsidian.setup {
      workspaces = {
        {
          name = 'test',
          path = '~/test-obsidian',
        },
      },
      wiki_link_func = 'prepend_note_path',
      markdown_link_func = 'prepend_note_path',
    }
  end,
}
