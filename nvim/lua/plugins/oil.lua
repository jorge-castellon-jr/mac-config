vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Oil Open parent Directory" })

return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      -- is_hidden_file = function (name,bufnr)
      --   return vim.startswith(name,"node_modules")
      -- end
    },
    win_options = {
      wrap = true,
    },
    float = {
      padding = 10,
      preview_split = "right",
    },
    keymaps = {
      ["<esc>"] = "actions.close",
      ["q"] = "actions.close",
      ["?"] = "actions.show_help",
      ["<S-tab>"] = "actions.parent",
      ["<tab>"] = "actions.select",
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
