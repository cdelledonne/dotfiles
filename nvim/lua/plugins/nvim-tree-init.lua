local nvimtree = require('nvim-tree')

nvimtree.setup({
    -- Disable git integration
    git = { enable = false },
    -- Hide hidden files, and hide some system files
    filters = {
        dotfiles = true,
        custom = { '.DS_Store', '*.swp' },
    },
    view = {
        hide_root_folder = true,
        signcolumn = 'no',
    },
    renderer = {
        icons = {
            symlink_arrow = ' ➜ ',
            glyphs = { default = '', symlink = '' },
        },
        special_files = {},
    }
})
