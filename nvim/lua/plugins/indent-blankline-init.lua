local ibl = require('ibl')
local hooks = require('ibl.hooks')

ibl.setup({
    scope = {
        enabled = false,
        show_start = false,
        show_end = false,
    },
    -- max_indent_increase = 1,
    -- show_first_indent_level = false,
    -- filetype_exclude = { 'help', 'NvimTree' },
    -- show_trailing_blankline_indent = false,
    -- show_current_context = true,
    -- use_treesitter = true,
    -- use_treesitter_scope = true,
})

hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
