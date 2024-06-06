return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup {
      settings = {
        save_on_toggle = true,
      },
    }
    -- REQUIRED

    -- Use Telescope as UI
    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- custom keymaps
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
      local fname = vim.api.nvim_buf_get_name(0)
      local msg = string.format('added file %s to harpoon', fname)
      vim.notify(msg, vim.log.levels.INFO)
    end, { desc = 'Add current buffer file to the list in harpoon' })

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
      local fname = vim.api.nvim_buf_get_name(0)
      local msg = string.format('removed file %s from harpoon', fname)
      vim.notify(msg, vim.log.levels.INFO)
    end, { desc = 'Remove current buffle file from the list in harpoon' })

    vim.keymap.set('n', '<leader>hf', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}
