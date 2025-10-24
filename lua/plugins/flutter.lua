-- Flutter plugin configuration for LazyVim
return {
  -- Add flutter-tools plugin
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false, -- Must load at startup to register DAP adapter
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional dependency
      "mfussenegger/nvim-dap", -- DAP integration
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          -- the border type to use for floating windows
          border = "rounded",
        },
        decorations = {
          statusline = {
            app_version = false,
          },
        },
        debugger = { -- integrate with nvim-dap
          enabled = true,
          run_via_dap = true, -- use dap for debugging
          exception_breakpoints = {},
          register_configurations = function(paths)
            local dap = require("dap")
            -- Configure the dart adapter
            dap.adapters.dart = {
              type = "executable",
              command = paths.flutter_bin,
              args = { "debug_adapter" },
            }
            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch Flutter Program",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
              {
                type = "dart",
                request = "attach",
                name = "Attach to Flutter Process",
              },
            }
          end,
        },
        fvm = false,
        flutter_path = "/Users/jeanpauljacquot/.puro/envs/default/flutter/bin/flutter",
        widget_guides = {
          enabled = true,
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit",
        },
        outline = {
          open_cmd = "30vnew",
        },
        lsp = {
          color = {
            enabled = false, -- Disable to avoid textDocument/documentColor errors
          },
          capabilities = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument = capabilities.textDocument or {}
            capabilities.textDocument.declaration = {
              dynamicRegistration = false,
              linkSupport = true,
            }
            return capabilities
          end,
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { buffer = bufnr, desc = "Flutter Outline" })
            vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { buffer = bufnr, desc = "Flutter Run" })
            vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { buffer = bufnr, desc = "Flutter Quit" })
            vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { buffer = bufnr, desc = "Flutter Restart" })
            vim.keymap.set("n", "<leader>FD", "<cmd>FlutterDevices<CR>", { buffer = bufnr, desc = "Flutter Devices" })
            -- Add keymap for declaration navigation
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
          end,
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