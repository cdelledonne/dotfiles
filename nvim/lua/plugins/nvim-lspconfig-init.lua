-- Customize how diagnostics are displayed
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

-- Customize highlights and borders of floating window
vim.cmd("highlight! link NormalFloat None")
vim.cmd("highlight! link FloatBorder None")
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or {
        {"╭", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╮", "FloatBorder"},
        {"│", "FloatBorder"},
        {"╯", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╰", "FloatBorder"},
        {"│", "FloatBorder"},
    }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 1000

-- Setup language servers
require("plugins/lsp-servers")
