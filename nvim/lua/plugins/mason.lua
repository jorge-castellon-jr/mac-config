return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require "mason"

    -- import mason-lspconfig
    local mason_lspconfig = require "mason-lspconfig"

    local mason_tool_installer = require "mason-tool-installer"

    mason.setup()

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }
    mason_lspconfig.setup {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- typescript
        "vue-language-server",
        "typescript-language-server",
        "ts_ls",
        "js-debug-adapter",
        "tailwindcss-language-server",
        "emmet-language-server",

        -- web
        "html-lsp",
        "json-lsp",
        "css-lsp",
        "scss-lsp",

        --formatters
        "eslint-lsp",
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "stylua",
        "prettier",
        "eslint_d",
        "isort",
        "black",
      },
    }
  end,
}
