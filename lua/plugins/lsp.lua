return {
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
        "eslint_d",
        "flake8",
        "shellcheck",

        -- LSP servers
        "lua-language-server",
        "pyright",
        "typescript-language-server",
        "json-lsp",
        "yaml-language-server",
      },
    },
  },

  -- Install debug adapters through mason
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = {
        "debugpy", -- Python
        "js-debug-adapter", -- JavaScript/TypeScript
        "delve", -- Go
      },
      automatic_installation = true,
      automatic_setup = true,
    },
  }
}