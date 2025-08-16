---@module 'lazy'
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>ra", vim.lsp.buf.rename, "[R]en[a]me")
        map("<leader>ca", require("fzf-lua").lsp_code_actions, "[C]ode [A]ction", { "n", "x" })
        map("gD", require("fzf-lua").lsp_definitions, "[G]oto [D]eclaration")

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          return client:supports_method(method, bufnr)
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if
          client
          and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- Native neovim LSP completion
        -- Will show the completion menu when you start typing via the TextChangedI autocmd
        -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
        --   vim.api.nvim_create_autocmd({ "TextChangedI" }, {
        --     buffer = event.buf,
        --     callback = function()
        --       vim.lsp.completion.get()
        --     end,
        --   })
        --
        --   -- Set popup menu color
        --   vim.api.nvim_set_hl(0, "Pmenu", { link = "@field" })
        --   vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { link = "rainbow4" })
        --   vim.api.nvim_set_hl(0, "Special", { link = "@function" })
        --
        --   vim.lsp.completion.enable(true, client.id, event.buf)
        -- end
      end,
    })

    -- Diagnostic Config
    vim.api.nvim_set_hl(0, "DiagnosticHint", { link = "@comment.hint" })
    vim.api.nvim_set_hl(0, "DiagnosticWarn", { link = "@comment.warning" })
    vim.api.nvim_set_hl(0, "DiagnosticError", { link = "@comment.error" })
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
      virtual_lines = true,
      -- virtual_text = {
      --   source = "if_many",
      --   spacing = 2,
      --   format = function(diagnostic)
      --     local diagnostic_message = {
      --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
      --       [vim.diagnostic.severity.WARN] = diagnostic.message,
      --       [vim.diagnostic.severity.INFO] = diagnostic.message,
      --       [vim.diagnostic.severity.HINT] = diagnostic.message,
      --     }
      --     return diagnostic_message[diagnostic.severity]
      --   end,
      -- },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      vtsls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                -- {
                --   name = "@vue/typescript-plugin",
                --   location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                --     .. "/node_modules/@vue/language-server",
                --   languages = { "vue" },
                --   configNamespace = "typescript",
                --   enableForWorkspaceTypeScriptVersions = true,
                -- },
              },
            },
          },
        },
      },
      html = {
        filetypes = { "html", "blade" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      "tailwindcss",
      "bashls",
      "blade-formatter",
      "cssls",
      "css_variables",
      "cssmodules_ls",
      "docker_compose_language_service",
      "dockerls",
      "eslint",
      "gofumpt",
      "goimports",
      "gopls",
      "hadolint",
      "html",
      "intelephense",
      "jsonls",
      "lua_ls",
      "marksman",
      "mmdc",
      "prettierd",
      "pretty-php",
      "pyright",
      "rust_analyzer",
      "shellcheck",
      "shfmt",
      "sqlfluff",
      "stylelint",
      "stylua",
      "vtsls",
      "vue-language-server",
      "yamlls",
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup({
      ensure_installed = {}, -- populates installs via mason-tool-installer
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
