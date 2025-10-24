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

-- macOS AZERTY keyboard Option key mappings for brackets and symbols
-- Control combinations for reliable bracket insertion
vim.keymap.set("i", "<C-b>", "{}<Left>", { desc = "Insert curly braces pair" })
vim.keymap.set("i", "<C-s>", "[]<Left>", { desc = "Insert square brackets pair" })
vim.keymap.set("i", "<C-p>", "()<Left>", { desc = "Insert parentheses pair" })

-- Single bracket insertions
vim.keymap.set("i", "<C-M-b>", "{", { desc = "Insert left curly brace" })
vim.keymap.set("i", "<C-M-8>", "}", { desc = "Insert right curly brace" })

-- Option key mappings for AZERTY layout
vim.keymap.set("i", "<M-5>", "{}<Left>", { desc = "Insert curly braces (opt+5)" })
vim.keymap.set("i", "<M-(>", "{", { desc = "Insert left brace (opt+()" })
vim.keymap.set("i", "<M-)>", "}", { desc = "Insert right brace (opt+))" })

-- Simplified French keyboard mappings
-- Control combinations are most reliable
vim.keymap.set("i", "<C-b>", "{}<Left>", { desc = "Insert curly braces pair" })
vim.keymap.set("i", "<C-s>", "[]<Left>", { desc = "Insert square brackets pair" })
vim.keymap.set("i", "<C-p>", "()<Left>", { desc = "Insert parentheses pair" })

-- Leader-based insertions in normal mode
vim.keymap.set("n", "<leader>i{", "i{}<Esc>i", { desc = "Insert curly braces" })
vim.keymap.set("n", "<leader>i[", "i[]<Esc>i", { desc = "Insert square brackets" })
vim.keymap.set("n", "<leader>i(", "i()<Esc>i", { desc = "Insert parentheses" })

-- Basic Option key mappings
vim.keymap.set("i", "<M-5>", "{}<Left>", { desc = "Insert curly braces (opt+5)" })
vim.keymap.set("i", "<M-(>", "{", { desc = "Insert left brace (opt+()" })
vim.keymap.set("i", "<M-)>", "}", { desc = "Insert right brace (opt+))" })

-- French keyboard character fallbacks
vim.keymap.set("i", "»", "{}<Left>", { desc = "Insert curly braces" })
vim.keymap.set("i", "÷", "}", { desc = "Insert right brace" })
vim.keymap.set("i", "å", "[]<Left>", { desc = "Insert square brackets" })
vim.keymap.set("i", "˚", "]", { desc = "Insert right bracket" })
vim.keymap.set("i", "Û", "[]<Left>", { desc = "Insert square brackets" })
vim.keymap.set("i", "ˆ", "[", { desc = "Insert left bracket" })
vim.keymap.set("i", "ÿ", "]", { desc = "Insert right bracket" })

-- Debug keycodes - this will show you what keys Neovim sees
vim.keymap.set("i", "<F1>", function()
  local char = vim.fn.getchar()
  print("Keycode received:", char, "Character:", string.char(char))
  return ""
end, { desc = "Debug keycode (press F1 then a key)" })

-- Alternative bracket insertions using Function keys
vim.keymap.set("i", "<F2>", "{}<Left>", { desc = "Insert curly braces (F2)" })
vim.keymap.set("i", "<F3>", "[]<Left>", { desc = "Insert square brackets (F3)" })
vim.keymap.set("i", "<F4>", "()<Left>", { desc = "Insert parentheses (F4)" })

-- Try different Meta notations for French keyboards
vim.keymap.set("i", "<A-5>", "[]<Left>", { desc = "Insert square brackets (Alt+5)" })
vim.keymap.set("i", "<D-5>", "[]<Left>", { desc = "Insert square brackets (Cmd+5)" })

-- Bracket insertion commands
vim.api.nvim_create_user_command("InsertBraces", function()
  vim.api.nvim_put({ "{}" }, "c", false, true)
  vim.cmd("normal! h")
end, { desc = "Insert {}" })

vim.api.nvim_create_user_command("InsertBrackets", function()
  vim.api.nvim_put({ "[]" }, "c", false, true)
  vim.cmd("normal! h")
end, { desc = "Insert []" })

vim.api.nvim_create_user_command("InsertParens", function()
  vim.api.nvim_put({ "()" }, "c", false, true)
  vim.cmd("normal! h")
end, { desc = "Insert ()" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>cd", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>ci", function()
  vim.lsp.buf.hover()
end, { desc = "Show documentation under cursor" })
