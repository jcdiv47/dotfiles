return {
  -- Disable snacks dashboard (using dashboard-nvim instead)
  {
    "folke/snacks.nvim",
    opts = { dashboard = { enabled = false } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          {
            icon = " ",
            icon_hl = "DashboardShortCutIcon",
            desc = "Files",
            group = "Label",
            action = function() Snacks.picker.files() end,
            key = "f",
          },
          {
            icon = "󰱼 ",
            icon_hl = "DashboardShortCutIcon",
            desc = "Text",
            group = "DiagnosticHint",
            action = function() Snacks.picker.grep() end,
            key = "g",
          },
          {
            icon = " ",
            icon_hl = "DashboardShortCutIcon",
            desc = "Recent",
            group = "Number",
            action = function() Snacks.picker.recent() end,
            key = "r",
          },
          {
            icon = " ",
            icon_hl = "DashboardShortCutIcon",
            desc = "Oil",
            group = "Special",
            action = "Oil",
            key = "o",
          },
          {
            icon = "󰒲 ",
            icon_hl = "DashboardShortCutIcon",
            desc = "Update",
            group = "@property",
            action = "Lazy sync",
            key = "u",
          },
        },
        packages = { enable = true },
        project = {
          enable = true,
          limit = 8,
          icon = " ",
          label = " Projects",
          action = function(path)
            Snacks.picker.files({ cwd = path })
          end,
        },
        mru = {
          enable = true,
          limit = 10,
          icon = " ",
          label = " Recent",
          cwd_only = false,
        },
        footer = { "", "nvim12 - dashboard-nvim hyper" },
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function()
      local color1_bg = "#ff757f"
      local color2_bg = "#4fd6be"
      local color3_bg = "#7dcfff"
      local color4_bg = "#ff9e64"
      local color5_bg = "#7aa2f7"
      local color6_bg = "#c0caf5"
      local color_fg = "#1F2335"

      for i, bg in ipairs({ color1_bg, color2_bg, color3_bg, color4_bg, color5_bg, color6_bg }) do
        vim.api.nvim_set_hl(0, "Headline" .. i .. "Bg", { fg = color_fg, bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "Headline" .. i .. "Fg", { fg = bg, bold = true })
      end

      return {
        preset = "obsidian",
        callout = {
          readme = { raw = "[!readme]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo", category = "github" },
        },
        completions = { lsp = { enabled = true } },
        heading = {
          setext = false,
          sign = false,
          right_pad = 1,
          width = "block",
          icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
          backgrounds = { "Headline1Bg", "Headline2Bg", "Headline3Bg", "Headline4Bg", "Headline5Bg", "Headline6Bg" },
          foregrounds = { "Headline1Fg", "Headline2Fg", "Headline3Fg", "Headline4Fg", "Headline5Fg", "Headline6Fg" },
        },
        code = { sign = false, width = "block", right_pad = 1 },
        bullet = { enabled = true },
        dash = { enabled = false },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str) return " " .. str end,
          },
        },
        lualine_b = {
          { "branch", icon = { "", color = { fg = "#A6D4DE" } } },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          "diagnostics",
        },
        lualine_c = {
          { "filename", file_status = true, path = 3, shorting_target = 40 },
        },
        lualine_x = {},
        lualine_y = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "" end
              local names = {}
              for _, client in ipairs(clients) do
                names[#names + 1] = client.name
              end
              return " " .. table.concat(names, ",")
            end,
          },
          "progress",
        },
        lualine_z = { "location" },
      },
    },
  },
}
