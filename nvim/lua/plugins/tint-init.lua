local tint = require("tint")

tint.setup({
    tint = -70,
    highlight_ignore_patterns = { "WinSeparator", "Telescope.*" },
    window_ignore_function = function(winid)
        local buf = vim.api.nvim_win_get_buf(winid)
        -- if vim.wo[winid].diff then return true end

        -- Do not tint certain window types
        local wintype = vim.fn.win_gettype(winid)
        local ignore_wt = { "popup" }
        for _, item in ipairs(ignore_wt) do
            if wintype:match(item) then return true end
        end

        -- Do not tint certain buffer types
        -- local buftype = vim.bo[buf].bt
        -- local ignore_bt = { "terminal", "prompt", "nofile", }
        -- for _, item in ipairs(ignore_bt) do
        --     if buftype:match(item) then return true end
        -- end

        -- Do not tint certain file types
        -- local filetype = vim.bo[buf].ft
        -- local ignore_ft = { "Telescope.*", "qf", }
        -- for _, item in ipairs(ignore_ft) do
        --     if filetype:match(item) then return true end
        -- end

        return false
    end,
})
