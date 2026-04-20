local telescope = require("telescope")
local trouble = require("trouble.sources.telescope")

local function link_hl_group(group, target)
    vim.api.nvim_exec(string.format("hi! link %s %s", group, target), false)
end

telescope.setup({
    defaults = {
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        prompt_prefix   = "   ",
        selection_caret = "    ",
        entry_prefix = "    ",
        multi_icon = "   ",
        -- Join borders of prompt and results windows
        borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        mappings = {
            n = { ["<C-T>"] = trouble.open },
            i = { ["<C-T>"] = trouble.open },
        },
        preview = false,
        file_ignore_patterns = { "%.git/" },
        layout_strategy = "center",
        layout_config = {
            height = 24,    -- 4 lines of borders and 20 results
            mirror = true,  -- invert position of results and preview
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            sort_mru = true,
        },
        lsp_document_symbols = {
            symbol_width = 0.8,
            symbol_type_width = 0.2,
        },
        lsp_dynamic_workspace_symbols = {
            path_display = { "shorten" },
        },
        spell_suggest = {
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
telescope.load_extension("heading")
