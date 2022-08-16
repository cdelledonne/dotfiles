local indent_blankline = require('indent_blankline')

indent_blankline.setup({
    max_indent_increase = 1,
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
    filetype_exclude = { 'help', 'NvimTree' },
})
