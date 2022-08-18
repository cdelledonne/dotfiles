-- Customize how diagnostics are displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = false,
    }
)

-- Customize diagnostic symbols
-- vim.fn.sign_define('DiagnosticSignHint',
--     {text='', texthl='DiagnosticSignHint', linehl='', numhl=''})
-- vim.fn.sign_define('DiagnosticSignInfo',
--     {text='', texthl='DiagnosticSignInfo', linehl='', numhl=''})
-- vim.fn.sign_define('DiagnosticSignWarn',
--     {text='', texthl='DiagnosticSignWarn', linehl='', numhl=''})
-- vim.fn.sign_define('DiagnosticSignError',
--     {text='', texthl='DiagnosticSignError', linehl='', numhl=''})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 1000

-- Setup language servers
require('plugins/lsp-servers')
