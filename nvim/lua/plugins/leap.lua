local map = vim.keymap.set
map("n", "f", "<Plug>(leap-forward)")
map("n", "F", "<Plug>(leap-backward)")

return {
  "ggandor/leap.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local leap = require "leap"
    -- leap.add_default_mappings()
    leap.opts.case_sensitive = false
  end,
}
