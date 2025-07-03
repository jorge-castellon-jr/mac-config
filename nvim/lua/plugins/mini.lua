-- https://github.com/echasnovski/mini.nvim
return {
  {
    -- https://github.com/echasnovski/mini.ai
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
    end,
  },
  -- {
  --   -- https://github.com/echasnovski/mini.animate
  --   "echasnovski/mini.animate",
  --   version = false,
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.animate").setup {
  --       cursor = {
  --         enable = false,
  --       },
  --       scroll = {
  --         timing = function()
  --           return 5
  --         end,
  --       },
  --     }
  --   end,
  -- },
  {
    -- https://github.com/echasnovski/mini.surround
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },
  -- {
  --   -- https://github.com/echasnovski/mini.completion
  --   "echasnovski/mini.completion",
  --   version = false,
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.completion").setup()
  --   end,
  -- },
  {
    -- https://github.com/echasnovski/mini.cursorword
    "echasnovski/mini.cursorword",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    -- https://github.com/echasnovski/mini.indentscope
    "echasnovski/mini.indentscope",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup {
        draw = {
          delay = 0,
          animation = function()
            return 0
          end,
        },
        mappings = {
          object_scope_with_border = "ia",
        },
        options = {
          indent_at_cursor = false,
          try_as_border = true,
        },
      }
    end,
  },
}
