local plugin = require('lspconfig')

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[d',         '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d',         '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', 'K',          '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    -- buf_set_keymap('n', '[d',         '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d',         '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
    -- buf_set_keymap('n', '<leader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    -- buf_set_keymap('n', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
end

-- Customize how diagnostics are displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
    })

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 1000
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()]]

-- Advertise client capabilities to LSP server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- C/C++ language server
plugin.ccls.setup{
    on_attach = on_attach,
    cmd = { 'ccls', '-v=1', '-log-file=/tmp/ccls.log' },
    init_options = {
        cache = { directory = '/tmp/ccls' },
        clang = { extraArgs = { '-Wno-extra', '-Wno-empty-body' } },
        client = { snippetSupport = true },
        completion = { detailedLabel = false, caseSensitivity = 1 },
        highlight = { lsRanges = true },
    },
    capabilities = capabilities,
}

-- Python language server
plugin.pyright.setup{
    on_attach = on_attach,
    cmd = { 'pyright-langserver', '--stdio' },  -- Default
    capabilities = capabilities,
}

-- LaTeX language server
plugin.texlab.setup{
    on_attach = on_attach,
    cmd = { 'texlab' },  -- Default
    settings = {
        texlab = {
            auxDirectory = 'build',  -- Non-default
            bibtexFormatter = 'texlab',
            build = {
                args = {
                    '-pdf',
                    '-interaction=nonstopmode',
                    '-synctex=1',
                    '-outdir=build',  -- Non-default
                    '-xelatex',  -- Non-default
                    '%f'
                },
                executable = 'latexmk',
                forwardSearchAfter = false,
                onSave = false
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 100,  -- Non-default
            forwardSearch = {
                executable = 'evince-synctex',  -- Non-default
                args = {'-f', '%l', '%p', ''}  -- Non-default
            },
            latexFormatter = 'latexindent',
        }
    },
    capabilities = capabilities,
}

-- lspsaga
-- local lspsaga = require('lspsaga')
-- lspsaga.setup{
--     use_saga_diagnostic_sign = false,
--     border_style = 'round',
--     code_action_keys = { quit = '<ESC>' },
--     rename_action_keys = { quit = '<ESC>' },
--     code_action_prompt = { sign = false },
--     rename_prompt_prefix = ' ',
-- }

-- vim.cmd('highlight link LspSagaCodeActionBorder Identifier')
-- vim.cmd('highlight link LspSagaDefPreviewBorder Identifier')
-- vim.cmd('highlight link LspSagaDiagnosticBorder Identifier')
-- vim.cmd('highlight link LspSagaHoverBorder Identifier')
-- vim.cmd('highlight link LspSagaLspFinderBorder Identifier')
-- vim.cmd('highlight link LspSagaRenameBorder Identifier')
-- vim.cmd('highlight link LspSagaSignatureHelpBorder Identifier')

-- vim.cmd('highlight link LspSagaCodeActionTruncateLine Identifier')
-- vim.cmd('highlight link LspSagaDiagnosticTruncateLine Identifier')
-- vim.cmd('highlight link LspSagaDocTruncateLine Identifier')

-- vim.cmd('highlight link LspSagaDiagnosticHeader Identifier')
-- vim.cmd('highlight link LspSagaCodeActionTitle Identifier')
-- vim.cmd('highlight link LspSagaCodeActionContent Normal')

-- vim.cmd('highlight link LspSagaRenamePromptPrefix Identifier')
-- vim.cmd('highlight link LspSagaLightBulb Identifier')
