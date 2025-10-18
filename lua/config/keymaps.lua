-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Auto-fix keymaps
vim.keymap.set("n", "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions (auto-fix)" })

vim.keymap.set("n", "<leader>cA", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.fixAll.eslint" },
    },
  })
end, { desc = "Auto-fix all ESLint issues" })

-- Code action bindings for macOS users
vim.keymap.set("n", "<D-.>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions (cmd+.)" })

-- Code action bindings for macOS users
vim.keymap.set("n", "<D-;>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions (cmd+;)" })

-- Ctrl+; for code actions
vim.keymap.set("n", "<C-;>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions (ctrl+;)" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>cd", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostics" })
