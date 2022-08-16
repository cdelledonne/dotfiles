local plugin = require('nvim-treesitter.configs')

plugin.setup{
    ensure_installed = {
        'bash', 'bibtex', 'c', 'cmake', 'comment', 'cpp', 'css', 'dockerfile',
        'go', 'html', 'java', 'javascript', 'json', 'json5', 'jsonc', 'latex',
        'llvm', 'lua', 'make', 'markdown', 'ninja', 'perl', 'php', 'python',
        'regex', 'ruby', 'rust', 'toml', 'typescript', 'verilog', 'vim', 'yaml'
    },
    sync_install = false,
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the
        -- same time. Set this to `true` if you depend on 'syntax' being
        -- enabled (like for indentation). Using this option may slow down your
        -- editor, and you may see some duplicate highlights. Instead of true
        -- it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },

    -- playground = {
    --     enable = true,
    -- },
}

-- Highlight constructors as normal functions
vim.api.nvim_set_hl(0, 'TSConstructor', { link = 'Function', default = true })
