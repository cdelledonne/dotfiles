local indent_blankline = require('indent_blankline')

indent_blankline.setup({
    max_indent_increase = 1,
    show_first_indent_level = false,
    filetype_exclude = { 'help', 'NvimTree' },
    show_trailing_blankline_indent = false,
    -- show_current_context = true,
    -- use_treesitter = true,
    -- use_treesitter_scope = true,
})
