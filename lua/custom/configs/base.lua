local M = {}

M.on_attach = function(client, bufnr)
  -- your on_attach logic here, for example:
  -- print("LSP attached")
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- you can extend capabilities here if needed

return M
