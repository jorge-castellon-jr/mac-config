-- Update your autocomplete.lua with this balanced configuration

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"

      -- Create a context-aware sorting system
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          -- Context-aware comparator that handles both scenarios
          function(entry1, entry2)
            local kind1 = entry1:get_kind()
            local kind2 = entry2:get_kind()

            -- Check if we're in a "property access" context (after a dot)
            -- We can determine this by checking if the completion is from LSP and has certain kinds
            local is_property_access = entry1.context
              and entry1.context.cursor_before_line
              and entry1.context.cursor_before_line:match "[%w_]+%s*$" == nil

            if is_property_access then
              -- After a dot, prioritize fields, properties and methods (from LSP)
              if (kind1 == 5 or kind1 == 10 or kind1 == 2) and entry1.source.name == "nvim_lsp" then
                if not (kind2 == 5 or kind2 == 10 or kind2 == 2) or entry2.source.name ~= "nvim_lsp" then
                  return true
                end
              elseif (kind2 == 5 or kind2 == 10 or kind2 == 2) and entry2.source.name == "nvim_lsp" then
                return false
              end
            else
              -- In normal context, prioritize variables (kind 6)
              if kind1 == 6 then
                if kind2 ~= 6 then
                  return true
                end
              elseif kind2 == 6 then
                return false
              end
            end
          end,

          -- Standard comparators as fallback
          cmp.config.compare.locality,
          cmp.config.compare.recently_used,
          cmp.config.compare.score,
          cmp.config.compare.offset,
          cmp.config.compare.order,
        },
      }

      -- Configure sources with appropriate priorities
      opts.sources = cmp.config.sources {
        { name = "supermaven" },
        {
          name = "buffer",
          priority = 1100,
          keyword_length = 1,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                  bufs[#bufs + 1] = buf
                end
              end
              return bufs
            end,
            indexing_threshold = 1000,
          },
        },
        { name = "nvim_lsp", priority = 1000 },
        { name = "path", priority = 500 },
        { name = "nvim_lua", priority = 500 },
        { name = "luasnip", priority = 250 },
      }

      -- Configure completion behavior
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
        keyword_length = 1,
      }

      -- Better UI
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      -- Experimental features
      opts.experimental = {
        ghost_text = true,
      }

      -- More flexible matching
      opts.matching = {
        disallow_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
      }

      local lspkind = require "lspkind"
      opts.formatting = {
        format = lspkind.cmp_format {
          mode = "symbol", -- show only symbol annotations
          maxwidth = {
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- menu = function() return math.floor(0.45 * vim.o.columns) end,
            menu = 50, -- leading text (labelDetails)
            abbr = 50, -- actual suggestion item
          },
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(entry, vim_item)
            -- ...
            return vim_item
          end,
        },
      }

      return opts
    end,

    dependencies = {
      { "onsails/lspkind.nvim" },

      {
        "hrsh7th/cmp-buffer",
        {
          "hrsh7th/cmp-cmdline",
          event = { "CmdLineEnter" },
          opts = { history = true, updateevents = "CmdlineEnter,CmdlineChanged" },
          config = function()
            local cmp = require "cmp"

            cmp.setup.cmdline("/", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = "buffer" },
              },
            })

            cmp.setup.cmdline(":", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = "path" },
              }, {
                {
                  name = "cmdline",
                  option = {
                    ignore_cmds = { "Man", "!" },
                  },
                },
              }),
            })
          end,
        },
      },
    },
  },
}
