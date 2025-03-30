return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }
  end,
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      intelephense = {
        settings = {
          intelephense = {
            format = {
              enable = false, -- Disable Intelephense formatting
            },
          },
        },
      },
    },
    setup = {
      intelephense = function(_, opts)
        opts.on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
        end
      end,
    },
  },
}
