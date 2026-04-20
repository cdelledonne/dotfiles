-- Customize how diagnostics are displayed
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

-- Customize highlights and borders of floating windows
vim.cmd("highlight! link NormalFloat None")
vim.cmd("highlight! link FloatBorder None")

local orig_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }
    return orig_open_floating_preview(contents, syntax, opts, ...)
end

local jump_prev_diag = function()
    vim.diagnostic.jump({ count = -1, float = true })
end

local jump_next_diag = function()
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
        map("n", "<leader>fm", function()
            vim.lsp.buf.format({ async = true })
        end, "LSP: format")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
        map("n", "K", vim.lsp.buf.hover, "LSP: hover")
        map("n", "[d", jump_prev_diag, "Diagnostics: previous")
        map("n", "]d", jump_next_diag, "Diagnostics: next")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
    end,
})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 1000

-- Setup language servers
require("plugins/lsp-servers")
