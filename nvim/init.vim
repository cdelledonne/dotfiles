""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" Editing
Plug 'jiangmiao/auto-pairs'             " Automatically close brackets-like
Plug 'tpope/vim-surround'               " Add brackets-like around elements
Plug 'tpope/vim-repeat'                 " Enable dot repeat fog plugins
Plug 'preservim/nerdcommenter'          " Comment/uncomment lines
Plug 'junegunn/vim-peekaboo'            " Peek content of registers

" Git
Plug 'tpope/vim-fugitive'               " Git management
Plug 'tpope/vim-rhubarb'                " GitHub extension for vim-fugitive
Plug 'shumphrey/fugitive-gitlab.vim'    " GitLab extension for vim-fugitive
Plug 'sindrets/diffview.nvim'           " Git diff GUI

" UI components
Plug 'kyazdani42/nvim-tree.lua'         " File explorer
Plug 'nvim-lualine/lualine.nvim'        " Statusline
Plug 'akinsho/bufferline.nvim'          " Tabline
Plug 'folke/trouble.nvim'               " Lists GUI

" Navigation
Plug 'christoomey/vim-tmux-navigator'   " Tmux integration

" Searching
Plug 'wincent/ferret'                   " Search (and replace) multiple files
Plug 'nvim-lua/plenary.nvim'            " Dependency for telescope.nvim
Plug 'nvim-telescope/telescope.nvim'    " Extensible fuzzy-finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'crispgm/telescope-heading.nvim'

" Styling
Plug 'ellisonleao/gruvbox.nvim'         " Color scheme
Plug 'ARM9/arm-syntax-vim'              " Syntax highlighting for ARM assembly
Plug 'kyazdani42/nvim-web-devicons'     " Lua fork of vim-devicons
Plug 'jghauser/shade.nvim'              " Dim inactive windows
Plug 'romainl/vim-cool'                 " Disable search highlights when moving
Plug 'lukas-reineke/indent-blankline.nvim'
                                        " Show indent lines

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'  " Treesitter abstraction layer
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'       " Treesitter utilities

" Language server protocol (LSP)
Plug 'neovim/nvim-lspconfig'            " LSP clients configurations

" Debug adapter protocol (DAP)
Plug 'mfussenegger/nvim-dap'            " DAP client implementation
Plug 'rcarriga/nvim-dap-ui'             " UI for nvim-dap

" Autocompletion
Plug 'hrsh7th/nvim-cmp'                 " Autocompletion framework
Plug 'hrsh7th/cmp-nvim-lsp'             " LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-path'                 " Path completion source for nvim-cmp
Plug 'hrsh7th/cmp-cmdline'              " Command completion source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'                 " Snippets
Plug 'saadparwaiz1/cmp_luasnip'         " Snippet completion source for nvim-cmp
Plug 'onsails/lspkind-nvim'             " Icons for LSP completion items

" Language-specific tools
" Plug 'cdelledonne/vim-cmake'            " CMake projects
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
                                        " Markdown preview

" Project configuration
Plug 'tpope/vim-obsession'              " Session manager
Plug 'embear/vim-localvimrc'            " Local project options

" Local plugins
Plug '~/Developer/Repositories/cdelledonne/vim-cmake'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:Source(file) abort
    execute 'source ' . stdpath('config') . '/' . a:file
endfunction

" General settings
call s:Source('vimscript/utils.vim')
call s:Source('vimscript/globals.vim')
call s:Source('vimscript/mappings.vim')
call s:Source('vimscript/styling.vim')

" Vimscript plugins configuration
call s:Source('vimscript/plugins/autopairs-init.vim')
call s:Source('vimscript/plugins/ferret-init.vim')
call s:Source('vimscript/plugins/fugitive-init.vim')
call s:Source('vimscript/plugins/localvimrc-init.vim')
call s:Source('vimscript/plugins/markdown-preview-init.vim')
call s:Source('vimscript/plugins/nerdcommenter-init.vim')
call s:Source('vimscript/plugins/peekaboo-init.vim')

" Lua plugins configuration
lua require('plugins/bufferline-init')
lua require('plugins/indent-blankline-init')
lua require('plugins/lualine-init')
lua require('plugins/nvim-cmp-init')
lua require('plugins/nvim-dap-init')
lua require('plugins/nvim-lspconfig-init')
lua require('plugins/nvim-tree-init')
lua require('plugins/nvim-treesitter-init')
lua require('plugins/shade-init')
lua require('plugins/telescope-init')

" Lua config-less plugins
lua require('diffview').setup()
