local base = require "custom.configs.base"
local on_attach = base.on_attach
local capabilities = base.capabilities

-- lsp api entrypoint
local lspconfig = vim.lsp.config

local servers = {
    "lua_ls",
    "tsserver",
    "bashls",
    "cmakelang",
    "rust_analyzer",
    "neocmake",
    "black",
    "arduino_language_server",
    "marksman",
    "glsl_analyzer",
    "clangd",
    "pyright",
    "zls",
    "ocamllsp",
    "vtsls",
    "gopls",
}

-- bulk enable
vim.lsp.enable(servers)

-- default configuration for *all* servers
lspconfig("*", {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            },
        },
    },
    root_markers = { ".git" },
})

lspconfig("pyright", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            venvPath = vim.fn.getcwd(),
            venv = ".venv",
        },
    },
})

lspconfig("clangd", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--clang-tidy",
        "--completion-style=detailed",
        "--background-index",
        "--offset-encoding=utf-16",
    },
})

local home = os.getenv "HOME"
local util = require "lspconfig.util" -- still valid for root_pattern()

lspconfig("racket_langserver", {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "racket" },
    root_dir = util.root_pattern("*.rkt", ".git"),
})

lspconfig("bearls", {
    cmd = { "bearls" }, -- or { vim.fn.expand("~/dev/bearls/build/bearls") } to skip installing
    filetypes = { "bear" },
    root_markers = { ".git" },
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        importPaths = {}, -- e.g. { "lib", "/abs/path/to/bear/std" }
        extraArgs = {},
        debounceMs = 30,
    },
})
vim.lsp.enable "bearls"
