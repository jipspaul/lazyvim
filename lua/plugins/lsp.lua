return {
  -- Configure none-ls for formatting and linting
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- Formatters
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.prettierd,

        -- Linters
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.shellcheck,

        -- Code actions (auto-fix)
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.shellcheck,
      })

      -- Enable auto-format on save
      opts.on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      return opts
    end,
  },

  -- Configure LSP capabilities for better auto-fix support
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {},
      setup = {
        -- Ensure ESLint is properly set up for auto-fix
        eslint = function(_, opts)
          opts.settings = {
            format = { enable = true },
            codeAction = {
              disableRuleComment = { enable = true },
              showDocumentation = { enable = true }
            }
          }
        end,
      },
    },
  },

  -- Ensure formatters and linters are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",
        "prettierd",
        "stylua",
        "black",
        "shfmt",
        "isort",

        -- Linters
        "eslint",
        "flake8",
        "shellcheck",

        -- LSP servers
        "lua_ls",
        "pyright",
        "tsserver",
        "jsonls",
        "yamlls",
      },
    },
  },
}