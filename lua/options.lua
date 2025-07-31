require "nvchad.options"

-- add yours here!

vim.opt.cursorlineopt = "both" -- to enable cursorline!

vim.opt.tabstop = 4 -- number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4 -- number of spaces for autoindent
vim.opt.expandtab = true -- convert tabs to spaces

-- Treesitter folding setup
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
