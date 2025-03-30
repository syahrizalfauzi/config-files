-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map semicolon into command mode
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true, silent = false })

-- Map jk in insert mode to escape
vim.keymap.set({ "i" }, "jk", "<Esc>", { noremap = true, silent = false })

-- Map ctrl HJKL to movement in insert mode, remap move line to alt shift JK
-- IMPORTANT : make sure to remove C-k binding in lazyvim.plugins.lsp.keymaps (done in lua/plugins/nvim-lspconfig.lua)
vim.keymap.set({ "i" }, "<C-h>", "<left>")
vim.keymap.set({ "i" }, "<C-j>", "<down>")
vim.keymap.set({ "i" }, "<C-k>", "<up>")
vim.keymap.set({ "i" }, "<C-l>", "<Right>")

-- Vim-Tmux-Navigator
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})
