local telescope = require('telescope')

local function link_hl_group(group, target)
    vim.api.nvim_exec(string.format('hi! link %s %s', group, target), false)
end

telescope.setup({
    defaults = {
        sorting_strategy = 'ascending',
        preview = false,
        scroll_strategy = 'limit',
        file_ignore_patterns = { '%.git/' },
        prompt_prefix = '   ',
        multi_icon = '   ',
        entry_prefix = '    ',
        selection_caret = '    ',
        layout_strategy = 'center',
        layout_config = {
            height = 24,  -- 4 lines of borders and 20 results
        },
        -- Join borders of prompt and results windows
        borderchars = {
            prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
            results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
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
            case_mode = 'smart_case',
        },
        heading = {
            treesitter = true,
        },
    },
})

-- Extensions
telescope.load_extension('fzf')
telescope.load_extension('heading')
