return {
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- use LSP formatting if no formatter is set
    },
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang_format" },
        python = { "black" },
        -- add more per language
    },
}
