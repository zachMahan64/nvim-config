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
    --"clangd", --manual set-up
    "rust_analyzer",
    "neocmake",
    "black",
    "arduino_language_server",
    "marksman",
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
        },
    },
}
vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            },
        },
    },
    root_markers = { ".git" },
})

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--clang-tidy", -- enable clang-tidy
        "--clang-tidy-checks=*,-llvm-*", -- example: all checks except LLVM
        --"--header-insertion=never", -- optional: avoid auto-inserting headers
        "--completion-style=detailed", -- nicer completion
        "--background-index", -- enable background indexing
        "--offset-encoding=utf-16", -- fix offset errors in some setups
    },
}
-- not working as of 20250824
lspconfig.racket_langserver.setup {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "racket" },
    root_dir = lspconfig.util.root_pattern("*.rkt", ".git"),
}
