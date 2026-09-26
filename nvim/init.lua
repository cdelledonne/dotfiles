--------------------------------------------------------------------------------
-- List of plugins
--------------------------------------------------------------------------------

vim.pack.add({
    -- Dependencies
    "https://github.com/nvim-lua/plenary.nvim",               -- Telescope, Neo-tree, todo-comments
    "https://github.com/SmiteshP/nvim-navic",                 -- barbecue.nvim
    "https://github.com/MunifTanjim/nui.nvim",                -- neo-tree.nvim
    "https://github.com/kevinhwang91/promise-async",          -- nvim-ufo
    "https://github.com/nvim-tree/nvim-web-devicons",         -- Dependency for various plugins
    -- Editing
    "https://github.com/numToStr/Comment.nvim",               -- Comment/uncomment lines
    "https://github.com/windwp/nvim-autopairs",               -- Automatically close brackets-like
    "https://github.com/tpope/vim-surround",                  -- Enable dot repeat fog plugins
    "https://github.com/tpope/vim-repeat",                    -- Comment/uncomment lines
    "https://github.com/junegunn/vim-peekaboo",               -- Peek content of registers
    -- UI components
    "https://github.com/nvim-lualine/lualine.nvim",           -- Statusline
    "https://github.com/utilyre/barbecue.nvim",               -- Winbar
    "https://github.com/folke/trouble.nvim",                  -- Lists GUI
    "https://github.com/kevinhwang91/nvim-ufo",               -- Better folds
    {                                                         -- Tree navigator (files, LSP symbols)
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range("3")
    },
    -- Styling
    "https://github.com/ellisonleao/gruvbox.nvim",            -- Color scheme
    "https://github.com/ARM9/arm-syntax-vim",                 -- Syntax highlighting for ARM assembly
    "https://github.com/romainl/vim-cool",                    -- Disable search highlights when moving
    "https://github.com/lukas-reineke/indent-blankline.nvim", -- Show indent lines
    "https://github.com/TaDaa/vimade",                        -- Dim inactive windows
    "https://github.com/folke/todo-comments.nvim",            -- Highlight TODO, NOTE, etc.
    -- Treesitter
    "https://github.com/arborist-ts/arborist.nvim",           -- Tree-sitter parser manager
    -- Language server protocol (LSP)
    "https://github.com/neovim/nvim-lspconfig",               -- LSP clients configurations
    -- Autocompletion
    "https://github.com/danymat/neogen",                      -- Doxygen documentation snippets
    "https://github.com/hrsh7th/nvim-cmp",                    -- Autocompletion framework
    "https://github.com/hrsh7th/cmp-nvim-lsp",                -- LSP completion source for nvim-cmp
    "https://github.com/hrsh7th/cmp-path",                    -- Path completion source for nvim-cmp
    "https://github.com/hrsh7th/cmp-cmdline",                 -- Command completion source for nvim-cmp
    "https://github.com/L3MON4D3/LuaSnip",                    -- Snippets
    "https://github.com/saadparwaiz1/cmp_luasnip",            -- Snippet completion source for nvim-cmp
    "https://github.com/onsails/lspkind-nvim",                -- Icons for LSP completion items
    -- Searching
    "https://github.com/nvim-telescope/telescope.nvim",       -- Extensible fuzzy-finder
    "https://github.com/crispgm/telescope-heading.nvim",      -- Telescope extension
    -- Project configuration
    "https://github.com/embear/vim-localvimrc",               -- Local project options
    -- Language-specific tools
    "https://github.com/cdelledonne/vim-cmake",               -- CMake projects
    -- Debug adapter protocol (DAP)
    -- "https://github.com/mfussenegger/nvim-dap",            -- DAP client implementation
    -- "https://github.com/nvim-neotest/nvim-nio",            -- Dependency of nvim-dap-ui
    -- "https://github.com/rcarriga/nvim-dap-ui",             -- UI for nvim-dap
    -- Archived / deprecated
    -- "https://github.com/levouh/tint.nvim",                 -- Dim inactive windows
    -- "https://github.com/stevearc/dressing.nvim",           -- Improve the default vim.ui interfaces
})

--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------

-- General settings.
require("config/globals")
require("config/mappings")
require("config/utils")
require("config/lsp")

-- Vimscript plugins configuration.
local function SourceVimscript(file)
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/" .. file)
end
SourceVimscript("vimscript/plugins/localvimrc-init.vim")
SourceVimscript("vimscript/plugins/peekaboo-init.vim")

-- Colorscheme plugin config + styling first, before loading other plugins.
require("plugins/gruvbox-init")
require("config/styling")

-- Lua plugins configuration.
require("plugins/arborist-init")
require("plugins/barbecue-init")
require("plugins/indent-blankline-init")
require("plugins/lualine-init")
require("plugins/luasnip-init")
require("plugins/neo-tree-init")
require("plugins/neogen-init")
require("plugins/nvim-cmp-init")
require("plugins/telescope-init")
require("plugins/trouble-init")
require("plugins/vimade-init")

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.fillchars = "fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
require("ufo").setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {"treesitter", "indent"}
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local excluded_filetypes = {
            "help",
            "qf",
            "neo-tree",
            "vimcmake",
            "TelescopeResults",
        }
        if not vim.tbl_contains(excluded_filetypes, vim.bo[args.buf].filetype) then
            vim.opt_local.foldenable = true
            vim.opt_local.foldcolumn = "1"
            vim.opt_local.signcolumn = "yes:1"
        else
            require("ufo").detach()
            vim.opt_local.foldenable = false
            vim.opt_local.foldcolumn = "0"
            vim.opt_local.signcolumn = "no"
        end
    end,
})

require("todo-comments").setup({
    signs = false,
    highlight = {
        keyword = "bg",
    },
})

-- Lua config-less plugins.
require("Comment").setup()
require("nvim-autopairs").setup()
