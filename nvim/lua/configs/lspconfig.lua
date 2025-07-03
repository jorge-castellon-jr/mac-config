local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local servers = { "html", "cssls", "tailwindcss", "eslint" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.emmet_language_server.setup {
  filetype = { "html", "javascriptreact", "typescriptreact", "vue" },
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

local function get_typescript_lib_path(root_dir)
  local global_ts = vim.fn.expand "$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/lib/node_modules/typescript/lib"
  local project_ts = ""
  local function check_dir(path)
    project_ts = lspconfig.util.path.join(path, "node_modules", "typescript", "lib")
    if lspconfig.util.path.exists(project_ts) then
      return path
    end
  end
  if lspconfig.util.search_ancestors(root_dir, check_dir) then
    return project_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetype = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_lib_path(new_root_dir)
  end,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}
