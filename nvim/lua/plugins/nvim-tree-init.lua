local nvimtree = require("nvim-tree")

nvimtree.setup({
    actions = {
        open_file = {
            -- Do not resize window when opening file
            resize_window = false,
        },
    },
    filters = {
        -- Hide hidden files
        dotfiles = true,
        -- Hide some system files
        custom = { ".DS_Store", "*.swp" },
    },
    -- Disable git integration
    git = { enable = false },
    renderer = {
        icons = {
            symlink_arrow = " ➜ ",
            glyphs = { default = "", symlink = "" },
        },
        root_folder_label = false,
        special_files = {},
    },
    view = {
        signcolumn = "no",
    },
})
