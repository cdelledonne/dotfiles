local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Apply shared settings to all enabled servers
vim.lsp.config("*", {
    capabilities = capabilities,
})

-- C/C++ language server
vim.lsp.config("clangd", {
    cmd = { "clangd" },
})

-- Python language server
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
})

-- Vimscript language server
vim.lsp.config("vimls", {
    cmd = { "vim-language-server", "--stdio" },
})

vim.lsp.enable({
    "clangd",
    "pyright",
    "vimls",
})
