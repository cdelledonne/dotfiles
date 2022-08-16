local plugin = require('nvim-tree')

local function map_command(keymap, command)
    vim.api.nvim_set_keymap(
        'n',
        keymap,
        string.format('<cmd>%s<CR>', command),
        { noremap = true }
    )
end

plugin.setup{
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
}

map_command('<F10>', 'NvimTreeToggle')
map_command('<F11>', 'NvimTreeFocus')
