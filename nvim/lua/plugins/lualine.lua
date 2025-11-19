-- Copied from https://github.com/Sin-cy/dotfiles/blob/cfa210f245e54ab0e3956fcb6c1e9da872d5de92/nvim/.config/nvim/lua/sethy/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    local colors = {
      color0 = "#092236",
      color1 = "#ff5874",
      color2 = "#c3ccdc",
      color3 = "#1c1e26",
      color6 = "#a1aab8",
      color7 = "#828697",
      color8 = "#ae81ff",
      color9 = "#154c79",
    }
    local my_lualine_theme = {
      replace = {
        a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
        b = { fg = colors.color2, bg = colors.color3 },
      },
      inactive = {
        a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
        b = { fg = colors.color6, bg = colors.color3 },
        c = { fg = colors.color6, bg = colors.color3 },
      },
      normal = {
        a = { fg = colors.color2, bg = colors.color9, gui = "bold" },
        b = { fg = colors.color2, bg = mocha.base },
        c = { fg = colors.color2, bg = mocha.base },
      },
      visual = {
        a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
        b = { fg = colors.color2, bg = mocha.base },
        c = { fg = colors.color2, bg = mocha.base },
      },
      insert = {
        a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
        b = { fg = colors.color2, bg = mocha.base },
        c = { fg = colors.color2, bg = mocha.base },
      },
      terminal = {
        a = { fg = colors.color0, bg = colors.color6, gui = "bold" },
        b = { fg = colors.color2, bg = mocha.base },
        c = { fg = colors.color2, bg = mocha.base },
      },
      command = {
        a = { fg = colors.color0, bg = colors.color6, gui = "bold" },
        b = { fg = colors.color2, bg = mocha.base },
        c = { fg = colors.color2, bg = mocha.base },
      },
    }

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
      end,
    }

    local branch = { "branch", icon = { "", color = { fg = "#A6D4DE" } } }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      -- cond = hide_in_width,
    }

    local tabs = {
      "tabs",
      tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
      max_length = vim.o.columns / 3, -- Maximum width of tabs component.
      -- Note:
      -- It can also be a function that returns
      -- the value of `max_length` dynamically.
      mode = 0, -- 0: Shows tab_nr
      tabs_color = {
        -- Same values as the general color option can be used here.
        active = "lualine_a_normal", -- Color for active tab.
        inactive = "lualine_b_normal", -- Color for inactive tab.
      },
    }

    local filename = {
      "filename",
      file_status = true,
      path = 3, -- 3: Absolute path, with tilde as the home directory
      shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      color = { bg = mocha.base },
    }

    local lsp_status = {
      "lsp_status",
      symbols = {
        spinner = { "", "", "", "", "", "" },
      },
    }

    lualine.setup({
      icons_enabled = true,
      options = {
        theme = my_lualine_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff, "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = { lsp_status, "progress" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_y = { filename },
        lualine_z = { tabs },
      },
    })
  end,
}
