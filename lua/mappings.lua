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


