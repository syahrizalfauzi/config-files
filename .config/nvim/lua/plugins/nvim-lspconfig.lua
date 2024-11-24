return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "kevinhwang91/nvim-ufo" },
  },
  config = function()
    require "configs.lspconfig"
  end,
}
