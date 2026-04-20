-- Set insert mode cursor as block.
vim.opt.guicursor = ""

-- Enable true colors.
if vim.env.COLORTERM == "truecolor" then
    vim.opt.termguicolors = true
end

local function apply_highlights()
    -- Highlight folds as comments.
    vim.api.nvim_set_hl(0, "Folded", { link = "Comment" })

    -- Change highlight of sign column.
    vim.api.nvim_set_hl(0, "SignColumn", {})
    vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })

    -- TreeSitter custom highlights.
    vim.api.nvim_set_hl(0, "TSConstructor", { link = "Function" })

    -- Telescope custom highlights.
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { link = "Type" })
    vim.api.nvim_set_hl(0, "TelescopeMultiIcon", { link = "Type" })

    -- Trouble custom highlights.
    vim.api.nvim_set_hl(0, "TroubleCount", { link = "Constant" })
    vim.api.nvim_set_hl(0, "TroubleFoldIcon", { link = "Type" })
    vim.api.nvim_set_hl(0, "TroubleSignError", { link = "TroubleError" })
    vim.api.nvim_set_hl(0, "TroubleSignHint", { link = "TroubleHint" })
    vim.api.nvim_set_hl(0, "TroubleSignInformation", { link = "TroubleInformation" })
    vim.api.nvim_set_hl(0, "TroubleSignOther", { link = "TroubleOther" })
    vim.api.nvim_set_hl(0, "TroubleSignWarning", { link = "TroubleWarning" })
    vim.api.nvim_set_hl(0, "TroubleText", { link = "None" })

    -- Neo-tree custom highlights.
    vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { link = "NeoTreeNormal" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { link = "NeoTreeNormal" })
    vim.api.nvim_set_hl(0, "NeoTreeExpander", { link = "Comment" })
    vim.api.nvim_set_hl(0, "NeoTreeExpander", { italic = false, update = true })
    vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { link = "Comment" })
    vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { italic = false, update = true })
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "Special" })

    -- DAP UI custom highlights.
    vim.api.nvim_set_hl(0, "DapUIVariable", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "DapUIScope", { link = "DashboardHeader" })
    vim.api.nvim_set_hl(0, "DapUIType", { link = "Type" })
    vim.api.nvim_set_hl(0, "DapUIValue", { link = "None" })
    vim.api.nvim_set_hl(0, "DapUIModifiedValue", { link = "Constant" })
    vim.api.nvim_set_hl(0, "DapUIDecoration", { link = "Operator" })
    vim.api.nvim_set_hl(0, "DapUIThread", { link = "DashboardHeader" })
    vim.api.nvim_set_hl(0, "DapUIStoppedThread", { link = "DapUIThread" })
    vim.api.nvim_set_hl(0, "DapUIFrameName", { link = "Function" })
    vim.api.nvim_set_hl(0, "DapUISource", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "DapUILineNumber", { link = "Type" })
    vim.api.nvim_set_hl(0, "DapUIFloatBorder", { link = "None" })
    vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { link = "DashboardHeader" })
    vim.api.nvim_set_hl(0, "DapUIWatchesValue", { link = "Operator" })
    vim.api.nvim_set_hl(0, "DapUIWatchesError", { link = "Operator" })
    vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { link = "DashboardHeader" })
    vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { link = "Function" })
    vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { link = "DapUILineNumber" })
    vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { link = "LineNr" })
end

local augroup = vim.api.nvim_create_augroup("ConfigStyling", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = apply_highlights,
})

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter" }, {
    group = augroup,
    callback = function()
        if vim.opt_local.number:get() then
            vim.opt_local.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    group = augroup,
    callback = function()
        if vim.opt_local.number:get() then
            vim.opt_local.relativenumber = false
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "TelescopePrompt",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- Colorscheme (leave at the end of this file).
vim.cmd.colorscheme("gruvbox")
