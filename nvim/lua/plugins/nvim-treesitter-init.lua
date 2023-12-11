local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    sync_install = false,

    ensure_installed = {
        "bash", "bibtex", "c", "cmake", "comment", "cpp", "css", "dockerfile",
        "go", "html", "java", "javascript", "json", "json5", "jsonc", "latex",
        "llvm", "lua", "make", "markdown", "markdown_inline", "ninja", "perl",
        "php", "python", "regex", "rst", "ruby", "rust", "toml", "typescript",
        "verilog", "vim", "yaml",
    },

    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the
        -- same time. Set this to `true` if you depend on "syntax" being
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

    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },

        swap = {
            enable = true,
            swap_next = {
                ["<leader>xm"] = "@function.outer",
                ["<leader>xc"] = "@class.outer",
            },
            swap_previous = {
                ["<leader>Xm"] = "@function.outer",
                ["<leader>Xc"] = "@block.outer",
            },
        },
    },

    -- playground = {
    --     enable = true,
    -- },
})
