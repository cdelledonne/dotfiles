-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "[d",         "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d",         "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

-- Advertise client capabilities to LSP server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- C/C++ language server with clangd
vim.lsp.config.clangd = {
    cmd = { "clangd" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Python language server
vim.lsp.config.pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- LaTeX language server
vim.lsp.config.texlab = {
    cmd = { "texlab" },
    settings = {
        texlab = {
            build = {
                executable = "tectonic",
                args = {
                    "-X",
                    "compile",
                    "%f",
                    "--keep-intermediates",
                    "--keep-logs",
                    "--synctex",
                    "--outdir", "build",
                },
                forwardSearchAfter = false,
                onSave = false,
            },
            auxDirectory = "build",
            latexFormatter = "latexindent",
            bibtexFormatter = "texlab",
            formatterLineLength = 100,
            latexindent = {
                ["modifyLineBreaks"] = true,
                -- Not the cleanest solution, but couldn't find anything else 
                ["local"] = vim.fn.getcwd() .. "/latexindent.yaml",
            },
            diagnosticsDelay = 300,
            forwardSearch = {
                executable = "evince-synctex",
                -- args = { "-f", "%l", "%p", "" },
                args = { "-f", "%l", "%p", '"code -g %f:%l"' },
            },
        }
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Vimscript language server
vim.lsp.config.vimls = {
    cmd = { "vim-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Enable configs
vim.lsp.enable({
    "clangd",
    "pyright",
    "texlab",
    "vimls",
})
