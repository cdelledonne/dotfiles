local plugin = require('bufferline')

plugin.setup{
    options = { 
        indicator_icon = '│',
        show_buffer_icons = false,
        show_close_icon = false,
        always_show_bufferline = false,
        offsets = {
            {
                filetype = 'NvimTree',
                text = '  Directory: ',
                text = function()
                    return '  '..vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                end,
                highlight = 'NvimTreeRootFolder',
                text_align = 'left',
            },
        },
    },
}
