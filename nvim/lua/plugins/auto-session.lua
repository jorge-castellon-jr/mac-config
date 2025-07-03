return {
  "rmagatti/auto-session",
  lazy = false,
  -- event = "VeryLazy",
  config = function()
    local auto_session = require "auto-session"

    auto_session.setup()

    local map = vim.keymap.set
    map("n", "<leader>sr", "<cmd>SessionRestore<cr>", { desc = "Sessions Restore Session" })
    map("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
  end,
}
