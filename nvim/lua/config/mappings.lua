local utils = require("config/utils")
local map = vim.keymap.set

-- Window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- Use Esc to exit terminal mode
map("t", "<Esc>", [[<C-\><C-n>]])

-- Folding
map("n", "<space>", "za")

-- Editing
map("n", "<leader>af", utils.toggle_autoformat, { silent = true })
map("n", "<leader>rt", utils.remove_trailing_spaces, { silent = true })

-- Plugins - normal mode
map("n", "<leader>tt", "<cmd>Neotree toggle left<CR>")
map("n", "<leader>tf", "<cmd>Neotree focus<CR>")
map("n", "<leader>tF", "<cmd>Neotree float<CR>")

map("n", "<leader>cb", "<Plug>(CMakeBuild)")
map("n", "<leader>cg", "<Plug>(CMakeGenerate)")
map("n", "<leader>ci", "<Plug>(CMakeInstall)")
map("n", "<leader>cq", "<Plug>(CMakeClose)")
map("n", "<leader>ct", "<Plug>(CMakeTest)")

map("n", "<leader>sb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>sc", "<cmd>Telescope commands<CR>")
map("n", "<leader>sd", "<cmd>Telescope lsp_document_symbols<CR>")
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>")
map("n", "<leader>sg", "<cmd>Telescope git_branches<CR>")
map("n", "<leader>sh", "<cmd>silent Telescope heading<CR>")
map("n", "<leader>sl", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>ss", "<cmd>Telescope grep_string<CR>")
map("n", "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
map("n", "z=", "<cmd>Telescope spell_suggest<CR>")

map("n", "<leader>dc", function() require("dap").continue() end, { silent = true })
map("n", "<leader>dn", function() require("dap").step_over() end, { silent = true })
map("n", "<leader>di", function() require("dap").step_into() end, { silent = true })
map("n", "<leader>do", function() require("dap").step_out() end, { silent = true })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { silent = true })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { silent = true })
map("n", "<leader>dt", function() require("dap").terminate() end, { silent = true })
map("n", "<leader>dh", function() require("dapui").eval() end, { silent = true })
