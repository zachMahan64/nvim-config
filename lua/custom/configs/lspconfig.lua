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
    "java_language_server",
    "clangd",
    "pyright",
    "java_language_server",
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

-- ---------------------------
-- PYRIGHT (custom setup)
-- ---------------------------
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

-- ---------------------------
-- CLANGD (custom setup)
-- ---------------------------
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

-- ---------------------------
-- JAVA LANGUAGE SERVER
-- ---------------------------
local home = os.getenv "HOME"
local util = require "lspconfig.util" -- still valid for root_pattern()

lspconfig("java_language_server", {
    cmd = { home .. "/.local/share/nvim/mason/bin/java-language-server" },
    root_dir = util.root_pattern("pom.xml", "build.gradle", ".git"),
    handlers = {
        ["client/registerCapability"] = function() end, -- ignore dynamic registration warnings
    },
})

-- ---------------------------
-- RACKET LANGSERVER
-- ---------------------------
lspconfig("racket_langserver", {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "racket" },
    root_dir = util.root_pattern("*.rkt", ".git"),
})
