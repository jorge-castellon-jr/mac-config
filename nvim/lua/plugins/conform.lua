return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        vue = { "prettier" },
        jsx = { "prettier" },
        tsx = { "prettier" },
        ["javascript.jsx"] = { "prettier" },
        ["typescript.jsx"] = { "prettier" },
        javascript = { "prettier" },
        js = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        typescriptreact = { "prettier" },
        python = { "isort", "black" },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }
  end,
}
