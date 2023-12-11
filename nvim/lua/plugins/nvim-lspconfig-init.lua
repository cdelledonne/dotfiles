-- Customize how diagnostics are displayed
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = false,
    }
)

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 1000

-- Setup language servers
require("plugins/lsp-servers")
