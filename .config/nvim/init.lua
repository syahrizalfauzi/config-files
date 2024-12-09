vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
-- vim.g.rg_command = 'rg --hidden --glob "!.git/*" --glob "!node_modules/*"'

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.wo.relativenumber = true

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.g.tmux_navigator_no_wrap = 1
-- Set the cursor style and blink options
vim.o.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h14"
  vim.opt.linespace = 4
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_cursor_animation_length = 0.025
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_scroll_animation_length = 0.2

  -- macos only
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_transparency = 0.65
  vim.g.transparency = 0.65
  vim.g.neovide_input_macos_option_key_is_meta = "both"
end

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })

vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { link = "Conditional" })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { link = "String" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { link = "Directory" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { link = "Conditional" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { link = "DiagnosticOk" })
-- Windows only
-- vim.o.shell = "powershell"
-- vim.o.shellcmdflag =
--   "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""
