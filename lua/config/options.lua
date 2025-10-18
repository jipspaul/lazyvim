-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set dark mode as default
vim.o.background = "dark"

-- Terminal exit shortcut
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { noremap = true, silent = true })
