require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "v" }, "<leader>q", "<cmd>qall<cr>", { desc = "CMD Quit all" })
map("i", "jf", "<ESC>")

-- terminal
map({ "n", "t" }, "<leader>ti", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm", cmd = "NVCHAD_TERM_NAME=float $SHELL" }
end)
map("t", "<D-Esc>", [[<C-\><C-n>]], { noremap = true }) -- exit insert mode to copy text
map("t", "<esc>", function()
  local term = require "nvchad.term"

  vim.api.nvim_command 'let g:term_name = system("echo $NVCHAD_TERM_NAME")'
  local term_name = vim.trim(vim.g.term_name)

  -- If term is custom float
  if term_name == "float" then
    term.toggle { pos = "float", id = "floatTerm" }
    return
  end

  -- List of terminal commands to exempt from the Escape toggle
  local exempt_terminals = {
    "lazygit",
  }

  local buf_name = vim.api.nvim_buf_get_name(0)
  -- Check if this terminal should be exempted
  for _, cmd in ipairs(exempt_terminals) do
    if buf_name:match(cmd) then
      -- Just send an Escape keypress instead of toggling
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
      return
    end
  end

  -- just quit if it gets here
  vim.cmd "quit"
end)

-- Saving document
map({ "n", "i" }, "<leader>;", "<ESC><cmd>w<cr>")
map({ "n", "i" }, "<D-s>", "<ESC><cmd>w<cr>")
map("n", "<leader>j", "<ESC><cmd>w<cr>")
map("i", ";;", "<ESC><cmd>w<cr>")

map("n", "<leader>oi", "<cmd> OrganizeImports <CR>", { desc = "Organize Imports" })

-- Center line
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "gd", "gdzz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- LSP stuff
map({ "n", "v" }, "<leader>ls", "<cmd>LspRestart<CR>")
map("n", "<leader>k", vim.lsp.buf.hover)
map("n", "<leader>rr", vim.lsp.buf.references)

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Tabs Create new tab" })
map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Tabs Go to next tab" })
map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Tabs Go to previous tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Tabs Close tab" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Split Vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split Split Horizontal" })
map("n", "<leader>sx", "<C-w>q", { desc = "Split Close Split Window" })

-- Lazy
map("n", "<leader>lz", "<cmd> Lazy <cr>", { desc = "Lazy Open Lazy" })

-- Search
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { desc = "Find Word" })

-- Debugging
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue the debugger" })

-- screenshot
map("v", "<leader>sc", "<cmd>CodeSnap<cr>", { desc = "Screenshot Save selected code snapshot into clipboard" })
map("v", "<leader>ss", "<cmd>CodeSnapSave<cr>", { desc = "Screenshot Save selected code snapshot in ~/Pictures" })
map(
  "v",
  "<leader>shc",
  "<cmd>CodeSnapHighlight<cr>",
  { desc = "Screenshot Save and highlight selected code snapshot into clipboard" }
)
map(
  "v",
  "<leader>shs",
  "<cmd>CodeSnapSaveHighlight<cr>",
  { desc = "Screenshot Save and highlight selected code snapshot in ~/Pictures" }
)
map(
  "v",
  "<leader>sa",
  "<cmd>CodeSnapASCII<cr>",
  { desc = "Screenshot Save selected code ASCII snapshot into clipboard" }
)

map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>")
