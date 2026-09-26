-- Customize how diagnostics are displayed
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

local lsp_format = function()
    vim.lsp.buf.format({ async = true })
end

local diag_jump_prev = function()
    vim.diagnostic.jump({ count = -1, float = true })
end

local diag_jump_next = function()
    vim.diagnostic.jump({ count = 1, float = true })
end

-- Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
    callback = function(ev)
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                buffer = ev.buf,
                noremap = true,
                silent = true,
                desc = desc,
            })
        end
        map("n", "gd", vim.lsp.buf.definition, "LSP: definition")
        map("n", "gD", vim.lsp.buf.declaration, "LSP: declaration")
        map("n", "gi", vim.lsp.buf.implementation, "LSP: implementation")
        map("n", "gr", vim.lsp.buf.references, "LSP: references")
        map("n", "<leader>td", vim.lsp.buf.type_definition, "LSP: type definition")
        map("n", "<leader>fm", lsp_format, "LSP: format")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
        map("n", "K", vim.lsp.buf.hover, "LSP: hover")
        map("n", "[d", diag_jump_prev, "Diagnostics: previous")
        map("n", "]d", diag_jump_next, "Diagnostics: next")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
    end,
})

-- Setup language servers
require("config/lsp-servers")
