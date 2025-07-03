return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "folke/todo-comments.nvim",
  },
  opts = {
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  },
  cmd = "Trouble",
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle trouble list" },
    { "<leader>dt", "<cmd>TodoToggle<CR>",                 desc = "Toggle trouble list" }
  }
}
