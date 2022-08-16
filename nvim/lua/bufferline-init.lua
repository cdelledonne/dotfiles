local plugin = require('bufferline')

plugin.setup{
    options = {
        -- indicator_icon = '│',
        -- indicator_icon = '█',
        -- indicator_icon = '',
        -- separator_style = { '', '' }, -- 'padded_slant',
        -- separator_style = { '', '' },
        -- separator_style = { '', '' },
        -- separator_style = 'thick',
        show_buffer_icons = false,
        show_close_icon = false,
        -- always_show_bufferline = false,
        offsets = {
            {
                filetype = 'NvimTree',
                text = function()
                    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    return '  ' .. cwd .. '  '
                end,
                highlight = 'NvimTreeImageFile',
                text_align = 'center',
            },
        },
    },
}

-- options = {
--         -- numbers = "none",
--         indicator_icon = '',
--         buffer_close_icon = '',
--         tab_size = 4,
--         close_icon = '',
--         left_trunc_marker = '',
--         right_trunc_marker = '',
--         modified_icon = '●',
--         diagnostics_update_in_insert = false,
--         show_buffer_icons = false,
--         show_tab_indicators = true,
--         persist_buffer_sort = true,
--         separator_style = { '', '' },
--         offsets = { { filetype = "NvimTree", text = "File Explorer"  } },
--         },
