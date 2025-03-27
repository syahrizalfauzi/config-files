return {
  "neovim/nvim-lspconfig",
  opts = {
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
