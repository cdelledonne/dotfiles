-- Global options must be set before sourcing the plugin
vim.g.nvim_tree_icons = { default = '', symlink = '' }
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_symlink_arrow = ' ➜ '

local plugin = require('nvim-tree')

local function map_command(keymap, command)
    vim.api.nvim_set_keymap(
        'n',
        keymap,
        string.format('<cmd>%s<CR>', command),
        {noremap = true}
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
}

map_command('<F10>', 'NvimTreeToggle')
map_command('<F11>', 'NvimTreeFocus')
