-- Flutter plugin configuration for LazyVim
return {
  -- Add flutter-tools plugin
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional dependency
    },
    ft = "dart", -- only load on dart files
    config = function()
      require("flutter-tools").setup({
        ui = {
          -- the border type to use for floating windows
          -- possible values: single, double, rounded, solid, shadow, none
          border = "rounded",
        },
        decorations = {
          statusline = {
            -- set to true to be able to see when dart file are loading
            app_version = false,
          },
        },
        debugger = { -- integrate with nvim-dap
          enabled = false,
          run_via_dap = false, -- use dap instead of flutter run
        },
        fvm = false, -- use fvm if configured
        flutter_path = nil, -- optionally set the flutter path
        flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        widget_guides = {
          enabled = true,
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit", -- command to use to open the log buffer
        },
        outline = {
          open_cmd = "30vnew", -- command to use to open the outline buffer
        },
      })
    end,
  },

  -- add flutter syntax highlighting
  { "dart-lang/dart-vim-plugin", ft = "dart" },

  -- add dart treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dart",
      },
    },
  },
}