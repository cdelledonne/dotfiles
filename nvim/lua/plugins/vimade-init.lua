local vimade = require("vimade")

vimade.setup({
    recipe = {"default", {animate = true}},
    ncmode = "windows",
    fadelevel = 0.5,
    blocklist = {
        skip_neotree = function(win, current)
            return vim.bo[win.bufnr].filetype == "neo-tree"
        end,
    },
})
