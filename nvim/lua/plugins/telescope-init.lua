local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

local function link_hl_group(group, target)
    vim.api.nvim_exec(string.format("hi! link %s %s", group, target), false)
end

telescope.setup({
    defaults = {
        sorting_strategy = "ascending",
        preview = false,
        scroll_strategy = "limit",
        file_ignore_patterns = { "%.git/" },
        prompt_prefix   = "   ",
        selection_caret = "    ",
        entry_prefix = "    ",
        multi_icon = "   ",
        -- color_devicons = false,
        results_title = false,
        layout_strategy = "center",
        layout_config = {
            height = 24,    -- 4 lines of borders and 20 results
            mirror = true,  -- invert position of results and preview
        },
        -- Join borders of prompt and results windows
        borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        mappings = {
            n = { ["<C-T>"] = trouble.open_with_trouble },
            i = { ["<C-T>"] = trouble.open_with_trouble },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            sort_mru = true,
        },
        lsp_dynamic_workspace_symbols = {
            path_display = { "shorten" },
            -- symbol_highlight = { field = "TSField" },
            -- symbol_width = 50,
            -- show_line = true,
        },
        spell_suggest = {
            results_title = false,
            layout_strategy = "cursor",
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
        heading = {
            treesitter = true,
        },
    },
})

-- Extensions
telescope.load_extension("fzf")
telescope.load_extension("heading")
