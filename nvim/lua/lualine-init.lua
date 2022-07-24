local plugin = require('lualine')

local vimcmake = {
    sections = {
        lualine_a = {function() return 'CMake' end},
        lualine_b = {'%{cmake#statusline#GetBuildInfo(1)}'},
        lualine_c = {'%{cmake#statusline#GetCmdInfo()}'},
        lualine_x = {},  -- CMake info e.g. version?
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_c = {function() return 'CMake' end},
        lualine_x = {'location'},
    },
    filetypes = {'vimcmake'} ,
}

local nvimtree = {
    sections = {
        lualine_a = {function() return 'Files' end},
    },
    inactive_sections = {
        lualine_c = {function() return 'Files' end},
    },
    filetypes = {'NvimTree'} ,
}

plugin.setup{
    -- options = {
        -- section_separators = '',
        -- component_separators = '',
        -- globalstatus = true,
    -- },
    sections = {
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                path = 1,  -- relative path
                symbols = {
                    modified = ' פֿ',
                    readonly = ' ',
                    unnamed = '[No Name]',
                },
            },
        },
    },
    inactive_sections = {
        lualine_c = {
            {
                'filename',
                path = 1,  -- relative path
                symbols = {
                    modified = ' פֿ',
                    readonly = ' ',
                    unnamed = '[No Name]',
                },
            },
        },
    },
    extensions = {
        'fugitive',
        'man',
        'quickfix',
        vimcmake,
        nvimtree,
    },
}
