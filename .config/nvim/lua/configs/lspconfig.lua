-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local ufo = require "ufo"

local servers =
  { "html", "cssls", "ts_ls", "gopls", "intelephense", "angularls", "bashls", "rust_analyzer", "tailwindcss" }
local nvlsp = require "nvchad.configs.lspconfig"

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

for _, lsp in ipairs(servers) do
  -- for UFO (fold)
  local capabilities = nvlsp.capabilities
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
ufo.setup()

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,

-- }
--
_G.organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)

    -- Map Ctrl+Shift+O to organize imports
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<C-S-o>",
      "<cmd>lua organize_imports()<CR>",
      { noremap = true, silent = true }
    )
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

local ok, mason_registry = pcall(require, "mason-registry")
if not ok then
  vim.notify "mason-registry could not be loaded"
  return
end

local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()

local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  table.concat({ angularls_path, vim.uv.cwd() }, ","),
  "--ngProbeLocations",
  table.concat({ angularls_path .. "/node_modules/@angular/language-server", vim.uv.cwd() }, ","),
}

lspconfig.angularls.setup {
  cmd = cmd,
  on_new_config = function(new_config)
    new_config.cmd = cmd
  end,
  root_dir = util.root_pattern "angular.json",
}
