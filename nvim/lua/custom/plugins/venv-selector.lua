return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  lazy = false,
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  config = function()
    require('venv-selector').setup {
      settings = {
        options = {
          enable_default_searches = true,
          notify_user_on_venv_activation = false, -- notifies user on activation of the virtual env
          search_timeout = 5, -- if a search takes longer than this many seconds, stop it and alert the user
          enable_cached_venvs = false, -- automatically activates the venv you used last time in a directory
        },
        search = {
          miniforge = {
            command = "fd 'bin/python$' ~/miniforge3/envs --full-path --color never -E /proc -I -a -L",
          },
          venv_0 = {
            command = "fd 'venv/bin/python$' . --full-path --color never -E /proc -I -a -L",
          },
          venv_1 = {
            command = "fd '.venv/bin/python$' . --full-path --color never -E /proc -I -a -L",
          },
        },
      },
    }
    -- FIXME: command not found
    vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>')
  end,
}
