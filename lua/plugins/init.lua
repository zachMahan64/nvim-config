local plugs = {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "cpp",
                "c",
                "rust",
                "python",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
            textobjects = {
                enable = true,
            },
        },
    },
    --MAY BREAK:
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "rust_analyzer",
                "shellcheck",
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "rust_analyzer" },
            handlers = {
                function(server_name)
                    if server_name == "clangd" then
                        return
                    end
                    require("lspconfig")[server_name].setup {}
                end,
                clangd = function() end,
            },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                enable = true,
                ignore = false,
            },
            filters = {
                dotfiles = false,
                custom = { ".DS_Store" },
            },
        },
        lazy = false,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "nvim-neotest/nvim-nio",
            "folke/which-key.nvim",
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"
            local wk = require "which-key"

            require("mason-nvim-dap").setup {
                ensure_installed = { "codelldb" },
                automatic_setup = true,
            }

            -- UI setup
            dapui.setup()
            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )

            -- Auto-open/close UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Adapter config
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }
            dap.configurations.cpp = {
                {
                    name = "Launch C++ (codelldb)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            -- Which-key descriptions only
            wk.setup()
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim", -- for LSP server install
        },
    },
    config = function()
        local rt = require "rust-tools"
        local extension_path = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- or .so on Linux

        rt.setup {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = {
                            command = "clippy",
                            enable = true,
                        },
                        diagnostics = {
                            enable = true,
                            enableExperimental = true,
                        },
                    },
                },
            },

            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
        }
    end,

    {
        "nvimtools/none-ls.nvim", -- the maintained fork of null-ls
        event = "VeryLazy",
        enabled = false,
        config = function()
            local null_ls = require "null-ls"

            null_ls.setup {
                sources = {
                    -- formatting
                    --null_ls.builtins.formatting.cmake_format, -- <- cmakelang formatter
                    --require("null-ls").builtins.diagnostics.cmake_lint,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.clang_format,
                    --null_ls.builtins.diagnostics.shellcheck,
                    --null_ls.builtins.formatting.rustfmt,
                    --null_ls.builtins.formatting.black, --for python
                },
                on_attach = require("custom.configs.base").on_attach,
            }
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
    },
    { "nvzone/volt", lazy = true },

    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
    { "nvzone/menu", lazy = true },
    {
        "NotAShelf/direnv.nvim",
        lazy = false,
        config = function()
            require "custom.configs.direnv"
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        enabled = false, -- !!!!!!!!!!!!!!!!!
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        -- Not all LSP servers add brackets when completing a function.
        -- To better deal with this, LazyVim adds a custom option to cmp,
        -- that you can configure. For example:
        --
        -- ```lua
        -- opts = {
        --   auto_brackets = { "python" }
        -- }
        -- ```
    },
    -- Live preview
    {
        "OXY2DEV/markview.nvim",
        lazy = false,

        -- For `nvim-treesitter` users.
        priority = 49,

        -- For blink.cmp's completion
        -- source
        -- dependencies = {
        --     "saghen/blink.cmp"
        -- },
    },
    -- Syntax highlighting, TOC, etc.
    {
        "preservim/vim-markdown",
        ft = { "markdown" },
        dependencies = { "godlygeek/tabular" },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_conceal = 0
        end,
    },

    -- Markdown snippets
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
        end,
    },
    {
        "famiu/bufdelete.nvim",
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*", -- latest stable
        lazy = false,
        enabled = false,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/notes/personal",
                },
            },
            daily_notes = {
                folder = "daily",
            },
            -- completion = {
            --   nvim_cmp = true, -- if using nvim-cmp
            -- },
        },
    },
}

return plugs
