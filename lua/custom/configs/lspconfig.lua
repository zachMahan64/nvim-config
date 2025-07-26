local base = require "custom.configs.base" -- changed here
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require "lspconfig"

local servers = {
  "lua_ls",
  "tsserver",
  --"pyright", --manual set-up
  "bashls",
  "cmakelang",
  "clangd",
  "rust_analyzer",
  "neocmake",
  "black",
  --"asm_lsp", --good, but doesn't work w/ b16 so disable it for now
}
vim.lsp.enable(servers)
-- override Pyright setup after the bulk enable to add custom config
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      venvPath = vim.fn.getcwd(),
      venv = ".venv",
      pythonVersion = "3.11",
    },
  },
}
