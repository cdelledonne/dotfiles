--------------------------------------------------------------------------------
-- List of plugins
--------------------------------------------------------------------------------

vim.pack.add({
    -- Editing
    "https://github.com/numToStr/Comment.nvim",               -- Comment/uncomment lines
    "https://github.com/windwp/nvim-autopairs",               -- Automatically close brackets-like
    "https://github.com/tpope/vim-surround",                  -- Enable dot repeat fog plugins
    "https://github.com/tpope/vim-repeat",                    -- Comment/uncomment lines
    "https://github.com/junegunn/vim-peekaboo",               -- Peek content of registers
    -- UI components
    "https://github.com/nvim-tree/nvim-web-devicons",         -- Lua fork of vim-devicons
    "https://github.com/nvim-lualine/lualine.nvim",           -- Statusline
    "https://github.com/SmiteshP/nvim-navic",                 -- Dependency of barbecue.nvim 
    "https://github.com/utilyre/barbecue.nvim",               -- Winbar 
    "https://github.com/folke/trouble.nvim",                  -- Lists GUI
    "https://github.com/MunifTanjim/nui.nvim",                -- Dependency of neo-tree.nvim
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
    "https://github.com/nvim-lua/plenary.nvim",               -- Dependency for telescope.nvim
    "https://github.com/nvim-telescope/telescope.nvim",       -- Extensible fuzzy-finder
    "https://github.com/crispgm/telescope-heading.nvim",      -- Telescope extension
    -- Project configuration
    "https://github.com/embear/vim-localvimrc",               -- Local project options
    -- Debug adapter protocol (DAP)
    -- "https://github.com/mfussenegger/nvim-dap",            -- DAP client implementation
    -- "https://github.com/nvim-neotest/nvim-nio",            -- Dependency of nvim-dap-ui
    -- "https://github.com/rcarriga/nvim-dap-ui",             -- UI for nvim-dap
    -- Language-specific tools
    "https://github.com/cdelledonne/vim-cmake",               -- CMake projects
    -- Unused
    -- "https://github.com/nvim-tree/nvim-tree.lua",          -- File explorer
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
require("plugins/nvim-lspconfig-init")
require("plugins/telescope-init")
require("plugins/trouble-init")
-- require("plugins/nvim-dap-init")

-- Lua config-less plugins.
require("Comment").setup()
require("nvim-autopairs").setup()
