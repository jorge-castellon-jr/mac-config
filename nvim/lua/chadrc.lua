-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  -- transparency = true,
  hl_override = {
    -- Pmenu = { bg = "white" },
    Visual = {
      -- bg = { "white", -50 },
      -- reverse = true,
    },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  tabufline = {
    lazyload = false,
    order = { "buffers", "tabs", "btns", "treeOffset" },
  },

  statusline = {
    separator_style = "round",
  },

  telescope = {
    style = "bordered",
  },

  lsp = {
    signature = false,
  },
}

M.term = {
  float = {
    relative = "editor",
    row = 0.075,
    col = 0.1,
    width = 0.8,
    height = 0.8,
  },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  > Restore Session", keys = "SPC sr", cmd = "SessionRestore" },
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

return M
