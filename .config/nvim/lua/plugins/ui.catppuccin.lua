---@module 'lazy'
---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        cmp = true,
        gitsigns = true,
        harpoon = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
