-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "carbonfox",
}
M.plugs = "custom.plugins"
M.lsp = {
  override = require("custom.configs.lspconfig"), -- may break
}
M.lazy_nvim = {
  config = {
    defaults = {
      lazy = true,
    },
  },
}

return M
