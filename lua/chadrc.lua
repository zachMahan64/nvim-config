-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "carbonfox",
    theme_toggle = { "carbonfox", "catppuccin", "tokyonight", "tokyodark" },
}
M.ui = {
    cmp = {
        icons_left = false, -- only for non-atom styles!
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        abbr_maxwidth = 60,
        -- for tailwind, css lsp etc
        format_colors = { lsp = true, icon = "󱓻" },
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
        enabled = true,
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        order = nil,
        modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "treeOffset", "buffers", "tabs", "btns" },
        modules = nil,
        bufwidth = 21,
    },
}
M.nvdash = {
    load_on_startup = true,
    header = {
        "                      ",
        "  ▄▄         ▄ ▄▄▄▄▄▄▄",
        "▄▀███▄     ▄██ █████▀ ",
        "██▄▀███▄   ███        ",
        "███  ▀███▄ ███        ",
        "███    ▀██ ███        ",
        "███      ▀ ███        ",
        "▀██ █████▄▀█▀▄██████▄ ",
        "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
        "                      ",
        "  Powered By  eovim ",
        "                      ",
    },

    buttons = {
        { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
        { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
        { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
        { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
        { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

        {
            txt = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime) .. " ms"
                return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
            end,
            hl = "NvDashFooter",
            no_gap = true,
        },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
}
M.plugs = "custom.plugins"
M.lsp = {
    override = require "custom.configs.lspconfig", -- may break
}
M.lazy_nvim = {
    config = {
        defaults = {
            lazy = true,
        },
    },
}

return M
