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
map("n", "<leader>rr", vim.lsp.buf.rename, { desc = "LSP: Rename (prefer <leader>ra)" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Go to Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Doc" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help" })

map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics under cursor" })

-- persistence mappings
map("n", "<leader>qs", function()
    require("persistence").load()
end, { desc = "load the session for the current directory" })
map("n", "<leader>qS", function()
    require("persistence").select()
end, { desc = "select a session to load" })
map("n", "<leader>ql", function()
    require("persistence").load { last = true }
end, { desc = "load the last session" })
map("n", "<leader>qd", function()
    require("persistence").stop()
end, { desc = "stop Persistence => session won't be saved on exit" })

-- misc
map("n", "<leader>zq", ":Telescope find_files cwd=~/.config/nvim/lua<CR>", { desc = "  Quick Fix" })
map("n", "<leader>zn", ":Nvdash<CR>", { desc = "Toggle Nvdash" })
--true shortcuts/nvdash stuff


map("n", "<leader>0", function()
  local bufdelete = require("bufdelete").bufdelete

  -- Delete all listed buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      bufdelete(buf, false)
    end
  end

  -- Open NvChad dashboard
  vim.cmd("Nvdash")
end, { desc = "󰑮 Nvdash" })


map("n", "<leader>1", ":cd ~/dev/c | NvimTreeOpen<CR>", { desc = " C projects" })
map("n", "<leader>2", ":cd ~/dev/cpp | NvimTreeOpen<CR>", { desc = " C++ projects" })
map("n", "<leader>3", ":cd ~/dev/py/ | NvimTreeOpen<CR>", { desc = " Python projects" })
map("n", "<leader>4", ":cd ~/dev/rust | NvimTreeOpen<CR>", { desc = " Rust projects" })

-- direnv keymaps for normal mode
map("n", "<Leader>Ya", function()
    require("direnv").allow_direnv()
end, { desc = "Direnv: allow .envrc" })
map("n", "<Leader>Yd", function()
    require("direnv").deny_direnv()
end, { desc = "Direnv: deny .envrc" })
map("n", "<Leader>Yr", function()
    require("direnv").check_direnv()
end, { desc = "Direnv: reload/check .envrc" })
map("n", "<Leader>Ye", function()
    require("direnv").edit_envrc()
end, { desc = "Direnv: edit .envrc" })

-- themes
-- Remap toggle term

vim.keymap.set("n", "<leader>tt", function()
    require("base46").toggle_theme()
end, { noremap = true, silent = true, desc = "Toggle NvChad theme via base46" })

vim.keymap.set("n", "<F6>", ":set spell!<CR>", { noremap = true, silent = true, desc = "Toggle spell check" })
vim.keymap.set("n", "<leader>cc", ":set spell! <CR>", { noremap = true, silent = true, desc = "Toggle spell check" })

-- nvzone/menu
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
    require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
    require("menu.utils").delete_old_menus()

    vim.cmd.exec '"normal! \\<RightMouse>"'

    -- clicked buf
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

    require("menu").open(options, { mouse = true })
end, {})

-- Markdown

map(
    "n",
    "<leader>mp", -- toggle markdown preview
    ":MarkdownPreviewToggle<CR>",
    { noremap = true, silent = true, desc = "Toggle .md preview" }
)

map(
    "n",
    "<leader>ms", -- stop markdown preview
    ":MarkdownPreviewStop<CR>",
    { noremap = true, silent = true, desc = "Disable .md preview" }
)
