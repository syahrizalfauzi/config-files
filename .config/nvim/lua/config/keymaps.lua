-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map semicolon into command mode
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true, silent = false })

-- Map jk in insert mode to escape
vim.keymap.set({ "i" }, "jk", "<Esc>", { noremap = true, silent = false })

-- Map alt HJKL to movement in insert mode, remap move line to alt shift JK
vim.keymap.set({ "i" }, "<A-h>", "<Left>", { noremap = true, silent = false })
vim.keymap.set({ "i" }, "<A-j>", "<Down>", { noremap = true, silent = false })
vim.keymap.set({ "i" }, "<A-k>", "<Up>", { noremap = true, silent = false })
vim.keymap.set({ "i" }, "<A-l>", "<Right>", { noremap = true, silent = false })

vim.keymap.set({ "i" }, "<A-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set({ "i" }, "<A-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Vim-Tmux-Navigator
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})
