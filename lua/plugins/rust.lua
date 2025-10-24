return {
  -- Rustaceanvim - A highly configured rust plugin
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- automatically set inlay hints (type hints)
          autoSetHints = true,
          -- whether to show hover actions inside the hover window
          hover_with_actions = true,
          -- whether to show `run` and `debug` targets
          runnables = {
            -- whether to use telescope for selecting runnables
            telescope = true,
          },
          debuggables = {
            -- whether to use telescope for selecting debuggables
            telescope = true,
          },
          -- whether to enable codelens support
          codelens = {
            -- whether to enable the codelens
            enable = true,
          },
          -- settings for showing the crate graph based on graphviz and the dot
          crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local crates
            -- default: true
            full = true,

            -- List of backends found on: https://graphviz.org/docs/outputs/
            -- Is used for input validation and autocompletion
            -- Last updated: 2021-08-26
            enabled_graphviz_backends = {
              "bmp",
              "cgimage",
              "cmap",
              "cmapx",
              "cmapx_np",
              "dot",
              "dot_json",
              "eps",
              "exr",
              "fig",
              "gif",
              "gtk",
              "ico",
              "cmapx_p",
              "imap",
              "jp2",
              "jpg",
              "jpeg",
              "jpe",
              "pdf",
              "pic",
              "pct",
              "pict",
              "plain",
              "plain-ext",
              "png",
              "pov",
              "ps",
              "ps2",
              "psd",
              "sgi",
              "svg",
              "svgz",
              "tga",
              "tiff",
              "tif",
              "tk",
              "vml",
              "vmlz",
              "wbmp",
              "webp",
              "xlib",
              "x11",
            },
          },
        },
        -- All the opts to send to nvim-lspconfig
        -- these override the defaults set by rustaceanvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          -- standalone file support
          standalone = true,
          -- on_attach function, runs when LSP attaches to a buffer
          on_attach = function(client, bufnr)
            -- Enable hover actions
            vim.keymap.set("n", "<C-space>", function()
              vim.cmd.RustLsp({'hover', 'actions'})
            end, { desc = "Rust hover actions", buffer = bufnr })

            -- Enable code action groups
            vim.keymap.set("n", "<Leader>a", function()
              vim.cmd.RustLsp('codeAction')
            end, { desc = "Rust code actions", buffer = bufnr })

            -- Run code
            vim.keymap.set("n", "<Leader>rr", function()
              vim.cmd.RustLsp('runnables')
            end, { desc = "Rust run", buffer = bufnr })

            -- Debug code
            vim.keymap.set("n", "<Leader>rd", function()
              vim.cmd.RustLsp('debuggables')
            end, { desc = "Rust debug", buffer = bufnr })

            -- Run tests
            vim.keymap.set("n", "<Leader>rt", function()
              vim.cmd.RustLsp('testables')
            end, { desc = "Rust test", buffer = bufnr })

            -- Expand macro
            vim.keymap.set("n", "<Leader>rm", function()
              vim.cmd.RustLsp('expandMacro')
            end, { desc = "Rust expand macro", buffer = bufnr })

            -- Open cargo.toml
            vim.keymap.set("n", "<Leader>rc", function()
              vim.cmd('edit Cargo.toml')
            end, { desc = "Open Cargo.toml", buffer = bufnr })

            -- Open parent directory
            vim.keymap.set("n", "<Leader>rp", function()
              vim.cmd('edit %:p:h:h/Cargo.toml')
            end, { desc = "Open parent Cargo.toml", buffer = bufnr })

            -- Quick brace insertions for French keyboards
            vim.keymap.set("i", "<C-b>", "{<Left>", { desc = "Insert curly braces", buffer = bufnr })
            vim.keymap.set("i", "<C-s>", "[<Left>", { desc = "Insert square brackets", buffer = bufnr })
            vim.keymap.set("i", "<C-p>", "(<Left>", { desc = "Insert parentheses", buffer = bufnr })

            -- Alternative bracket insertions
            vim.keymap.set("i", "<M-5>", "{}<Left>", { desc = "Insert curly braces (Alt+5)", buffer = bufnr })
            vim.keymap.set("i", "<M-}>", "}<Left>", { desc = "Close curly brace", buffer = bufnr })
            vim.keymap.set("i", "<M-{>", "{<Left>", { desc = "Open curly brace", buffer = bufnr })
          end,
          -- these override the defaults set by rustaceanvim
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              -- enable clippy diagnostics on save
              checkOnSave = {
                command = "clippy",
              },
              -- enable inlay hints
              inlayHints = {
                locationLinks = false,
                bindingModeHints = {
                  enable = true,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                discriminantHints = {
                  enable = true,
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                  excludeNameParameterHints = false,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
              -- enable completion
              completion = {
                addCallParentheses = true,
                addCallArgumentSnippets = true,
                autoimport = {
                  enable = true,
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      }
    end,
  },

  -- Additional Rust tools
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },

  }