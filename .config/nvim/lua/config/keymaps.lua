vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map vertical motion to allow movement in soft-wrapped lines
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true, silent = false })
vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true, silent = false })

-- Show lazy.nvim panel
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")

-- Map ctrl c to copy whole file
vim.keymap.set("n", "<C-c>", "ggVGy", { noremap = true, silent = false })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Map semicolon into command mode
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true, silent = false })

-- Map jk in insert mode to escape
vim.keymap.set({ "i" }, "jk", "<Esc>", { noremap = true, silent = false })

-- Map ctrl HJKL to movement in insert mode, remap move line to alt shift JK
-- IMPORTANT : make sure to remove C-k binding in lazyvim.plugins.lsp.keymaps (done in lua/plugins/nvim-lspconfig.lua)
vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("i", "<C-j>", "<down>")
vim.keymap.set("i", "<C-k>", "<up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Delete neovim 0.11.0 LSP default keymaps (replaced with fzf-lua)
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")

-- LSP Completion
vim.keymap.set("i", "<C-space>", function()
  vim.lsp.completion.get()
end)
-- vim.keymap.set("i", "<CR>", "pumvisible() ? '<C-y>' : '<CR>'", { expr = true })

-- Markdown Preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })

-- Copilot
vim.keymap.set("i", "<C-]>", 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  replace_keycodes = false,
  desc = "Accept Copilot suggestion",
})
vim.g.copilot_no_tab_map = true
