require "nvchad.autocmds"
vim.cmd([[
  autocmd CmdlineLeave :%s/:.*\// :nohlsearch
]])
