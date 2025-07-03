vim.keymap.set("n", "_", "<cmd>NvimTreeToggle<cr>", { desc = "Tree Open tree view" })
return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  opts = function()
    local tree = require "nvchad.configs.nvimtree"

    tree.view.relativenumber = true
    tree.view.side = "right"
    -- tree.view.width = 100
    tree.filters.exclude = { ".env", ".dev.vars", "node_modules", ".nuxt" }

    return tree
  end,
}
