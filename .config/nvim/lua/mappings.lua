require "nvchad.mappings"

local map = vim.keymap.set
local cmp = require "cmp"
local neoscroll = require "neoscroll"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- move lines
-- map("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
-- map("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- copilot
-- map("i", "<C-l>", function()
--   require("github/copilot.vim").accept()
-- end, { desc = "Copilot accept" })

map("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

map("n", "<leader>ci", function()
  vim.api.nvim_feedkeys("ea", "n", false)
  vim.defer_fn(function()
    cmp.complete()
  end, 10)
end, {
  noremap = true,
  silent = true,
  desc = "Show code suggestion #2",
})

-- Tmux Navigate
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>NvimTmuxNavigatePrevious<CR>", { silent = true })

-- neoscroll
local scrollDuration = 100
local keymap = {
  ["<C-u>"] = function()
    neoscroll.ctrl_u { duration = scrollDuration }
  end,
  ["<C-d>"] = function()
    neoscroll.ctrl_d { duration = scrollDuration }
  end,
  ["<C-b>"] = function()
    neoscroll.ctrl_b { duration = scrollDuration }
  end,
  ["<C-f>"] = function()
    neoscroll.ctrl_f { duration = scrollDuration }
  end,
  ["<C-y>"] = function()
    neoscroll.scroll(-0.1, { move_cursor = false, duration = scrollDuration })
  end,
  ["<C-e>"] = function()
    neoscroll.scroll(0.1, { move_cursor = false, duration = scrollDuration })
  end,
}
for key, func in pairs(keymap) do
  vim.keymap.set({ "n", "v", "x" }, key, func)
end
