local plugin = require('telescope')

local function map_picker(keymap, picker)
    vim.api.nvim_set_keymap(
        'n',
        keymap,
        string.format('<cmd>lua require("telescope.builtin").%s()<CR>', picker),
        {noremap = true}
    )
end

local function link_hl_group(group, target)
    vim.api.nvim_exec(string.format('hi! link %s %s', group, target), false)
end

plugin.setup{
    defaults = {
        sorting_strategy = 'ascending',
        preview = false,
        selection_caret = '  ',
        multi_icon = '+ ',
        layout_strategy = 'center',
        layout_config = {
            height = 24,  -- 4 lines of borders and 20 results
        },
        -- Join prompt and results window borders
        borderchars = {
            prompt = {'─', '│', ' ', '│', '╭', '╮', '│', '│'},
            results = {'─', '│', '─', '│', '├', '┤', '╯', '╰'},
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        },
    },
    pickers = {
        find_files = {
            results_title = false,
            hidden = true,
        },
        commands = {
            results_title = false,
        },
        buffers = {
            results_title = false,
            sort_mru = true,
        },
        lsp_document_symbols = {
            results_title = false,
        },
        lsp_dynamic_workspace_symbols = {
            results_title = false,
        },
        git_branches = {
            results_title = false,
        },
        help_tags = {
            results_title = false,
        },
        live_grep = {
            results_title = false,
        },
        grep_string = {
            results_title = false,
        },
        spell_suggest = {
            results_title = false,
            layout_strategy = 'cursor',
            layout_config = {
                height = 14,  -- 4 lines of borders and 10 results
                width = 40,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

-- Extensions
plugin.load_extension('fzf')

-- Map pickers
map_picker('<C-P>',      'find_files')
map_picker('<C-Space>',  'commands')
map_picker('<leader>b',  'buffers')
map_picker('<leader>ds', 'lsp_document_symbols')
map_picker('<leader>gb', 'git_branches')
map_picker('<leader>h',  'help_tags')
map_picker('<leader>lg', 'live_grep')
map_picker('<leader>s',  'grep_string')
map_picker('<leader>ws', 'lsp_dynamic_workspace_symbols')
map_picker('z=',         'spell_suggest')

-- Redefine some default Telescope highlight groups here, as they are otherwise
-- overwritten by the Gruvbox theme
link_hl_group('TelescopeNormal', 'Normal')
link_hl_group('TelescopeSelectionCaret', 'TelescopeSelection')
link_hl_group('TelescopeMultiSelection', 'Type')
link_hl_group('TelescopeMatching', 'Special')
link_hl_group('TelescopePromptPrefix', 'Identifier')

-- Custom highlight groups
link_hl_group('TelescopeSelection', 'CursorLine')
