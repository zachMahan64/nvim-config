require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- DAP keymaps
map("n", "<F5>", require("dap").continue, { desc = "DAP: Continue" })
map("n", "<leader>dc", require("dap").continue, { desc = "DAP: Continue, <F5> works too" })
map("n", "<F10>", require("dap").step_over, { desc = "DAP: Step Over" })
map("n", "<leader>dn", require("dap").step_over, { desc = "DAP: Step Over" })
map("n", "<F11>", require("dap").step_into, { desc = "DAP: Step Into" })
map("n", "<F12>", require("dap").step_out, { desc = "DAP: Step Out" })
map("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "DAP: Conditional Breakpoint" })
map("n", "<leader>du", require("dapui").toggle, { desc = "DAP UI Toggle" })
map("n", "<leader>dc", require("dap").clear_breakpoints, { desc = "DAP: Clear Breakpoints" })

-- Formatting
map("n", "<leader>fx", vim.lsp.buf.format, { desc = "file-spec format" })

-- LSP mappings
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP: Rename (prefer <leader>ra)" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Go to Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Doc" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help" })

-- persistence mappings
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "load the session for the current directory"})
-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "select a session to load"})
-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "load the last session"})
-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "stop Persistence => session won't be saved on exit"})
