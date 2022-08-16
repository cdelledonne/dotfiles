""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" Editing
Plug 'jiangmiao/auto-pairs'             " Automatically close brackets-like
Plug 'tpope/vim-surround'               " Add brackets-like around elements
Plug 'tpope/vim-repeat'                 " Enable dot repeat fog plugins
Plug 'preservim/nerdcommenter'          " Comment/uncomment lines
Plug 'wincent/ferret'                   " Search (and replace) multiple files

" Git
Plug 'tpope/vim-fugitive'               " Git management
Plug 'tpope/vim-rhubarb'                " GitHub extension for vim-fugitive
Plug 'shumphrey/fugitive-gitlab.vim'    " GitLab extension for vim-fugitive
Plug 'sindrets/diffview.nvim'           " Git diff GUI

" UI components
Plug 'kyazdani42/nvim-tree.lua'         " File explorer
Plug 'nvim-lualine/lualine.nvim'        " Statusline
Plug 'akinsho/bufferline.nvim'          " Tabline

" Navigation
Plug 'christoomey/vim-tmux-navigator'   " Tmux integration

" Styling
Plug 'ellisonleao/gruvbox.nvim'         " Color scheme
Plug 'kyazdani42/nvim-web-devicons'     " Lua fork of vim-devicons
Plug 'jghauser/shade.nvim'              " Dim inactive windows
Plug 'lukas-reineke/indent-blankline.nvim' " Show indent lines

" Language server protocol
Plug 'neovim/nvim-lspconfig'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'  " Treesitter abstraction layer
Plug 'nvim-treesitter/playground'       " Treesitter utilities

" Debug adapter protocol

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'             " LSP completion source
Plug 'hrsh7th/cmp-path'                 " Path completion source
Plug 'hrsh7th/cmp-cmdline'              " Command line completion source
Plug 'onsails/lspkind-nvim'             " Icons for LSP completion items
Plug 'hrsh7th/nvim-cmp'                 " Autocompletion framework

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable search highlighting when done searching
Plug 'romainl/vim-cool'

" Session manager
Plug 'tpope/vim-obsession'

Plug 'embear/vim-localvimrc'
Plug 'ARM9/arm-syntax-vim'

" Markdown preview and additional tools
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'

" Peek content of registers
Plug 'junegunn/vim-peekaboo'

" CMake projects
" Plug 'cdelledonne/vim-cmake'
Plug '~/Developer/Repositories/cdelledonne/vim-cmake'

" Dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'folke/trouble.nvim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings                                                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" From :help provider-nodejs
" By default, Nvim searches for 'neovim-node-host' using 'npm root -g', which
" can be slow. To avoid this, set g:node_host_prog to the host path:
"     let g:node_host_prog = '/usr/local/bin/neovim-node-host'
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" Enable true colors
if $COLORTERM == 'truecolor'
    set termguicolors
endif

" Color scheme
" Gruvbox configuration must be called before loading colorscheme
lua require('gruvbox-init')
colorscheme gruvbox

" Set tab behaviour
set expandtab
set shiftwidth=4
set softtabstop=4

" Tab behaviour for some config files
autocmd FileType yaml,toml setlocal shiftwidth=2 softtabstop=2

" Set folding method but do not fold on start-up
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" Fold specific files based on indent (should work with treesitter?)
" autocmd FileType python,basic,yaml,toml,vim setlocal foldmethod=indent

" Soft-wrapped lines will continue visually indented
set breakindent

" Show line number
set number

" Display keystrokes in the command line in normal mode
set showcmd

" Hide mode from command line
set noshowmode

" Hide buffers when abandoned
set hidden

" Highlight cursor line
set cursorline

" Case-sensitive search ONLY when capital letters appear in the search string
set ignorecase
set smartcase

" Case-insensitive path completion in commands
set wildignorecase

" Show diff in vertical mode
set diffopt+=vertical

" Put new window to the right when using a vertical split
set splitright

" Show effects of some commands incrementally in a preview window
set inccommand=split

" Set update delay (in milliseconds)
" set updatetime=100

" Set minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" Do not wrap text except for textual files
set nowrap
autocmd FileType tex,text,markdown setlocal wrap linebreak

" Enable spell checking for textual files
autocmd FileType tex,text,markdown,rst,gitcommit setlocal spell spelllang=en_us

" Set text width for line breaks for some filetypes
autocmd FileType tex,text,markdown,rst,gitcommit,vim setlocal textwidth=80

" Open .clang-format files as YAML files
autocmd BufRead *.clang-format setlocal filetype=yaml

" Open .tex files as LaTeX files
let g:tex_flavor='latex'

" Custom commands
command! RemoveTrailingSpaces %s/\s\+$//g | noh

" Set insert mode cursor as block
" set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20
set guicursor=

" Mouse support in normal and visual mode
set mouse=nv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom mappings                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Redefine leader to be ';'
let mapleader = ";"

" Use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Windows navigation in terminal mode
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

" Folding
nnoremap <space> za

" Formatting
function! ToggleAutoFormat() abort
    " Search for 'a' in formatoptions
    let l:autoformat_active = match(&l:formatoptions, '\m\Ca') > 0
    if l:autoformat_active
        set formatoptions-=a
        echo 'Automatic formatting turned OFF'
    else
        set formatoptions+=a
        echo 'Automatic formatting turned ON'
    endif
endfunction
nnoremap <silent> <leader>af :call ToggleAutoFormat()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom theming                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight folds as comments
highlight! link Folded Comment

function! s:OnWinEnter() abort
    if &l:number
        setlocal relativenumber
    endif
    setlocal cursorline
endfunction

function! s:OnWinLeave() abort
    if &l:number
        setlocal norelativenumber
    endif
    setlocal nocursorline
endfunction

" Enable 'cursorline' and 'relativenumber' in active window only
autocmd VimEnter,BufEnter,WinEnter * call s:OnWinEnter()
autocmd BufLeave,WinLeave * call s:OnWinLeave()

" But disable 'cursorline' in TelescopePrompt window
autocmd FileType TelescopePrompt setlocal nocursorline

" Other highlight definitions
highlight! link TelescopePromptPrefix Normal
highlight! link TelescopeSelection CursorLine
highlight! link TelescopeMatching Special
highlight! link TelescopeMultiSelection Type
highlight! link TelescopeMultiIcon Type

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fugitive_gitlab_domains = ['https://gitlab.tudelft.nl']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter configuration                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use alternative delimiters '//' for c files
let g:NERDAltDelims_c = 1

" Insert a space after comment delimiters
let g:NERDSpaceDelims = 1

" Use '#' delimiter (and not '# ') for python files
let g:NERDCustomDelimiters = { 'python': { 'left': '#' } }

" Only define some key mappings
let NERDCreateDefaultMappings = 0
nmap <leader>ca <Plug>NERDCommenterAltDelims
nmap <leader>cA <Plug>NERDCommenterAppend
nmap <leader>c<Space> <Plug>NERDCommenterToggle
imap <C-c> <Plug>NERDCommenterInsert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoPairs configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ferret configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:FerretAutojump = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-localvimrc configuration                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Store and restore decisions only if the answer was given in upper case (Y/N/A)
let g:localvimrc_persistent = 1

let g:localvimrc_persistence_file = expand('~/.config/localvimrc/persistent')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview configuration                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not close preview when switching to another buffer
let g:mkdp_auto_close = 0

nmap <leader>p <Plug>MarkdownPreviewToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown configuration                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight YAML-style frontmatter (starts and ends with '---') and TOML-style
" frontmatter (starts and ends with '+++')
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

" Prevent problems when using automatic line wrapping
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" Override some syntax highlighting
hi def link mkdHeading Delimiter

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-peekaboo configuration                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delay opening of Peekaboo window
let g:peekaboo_delay = 1000

" Create Peekaboo window below current window
let g:peekaboo_window = 'bel 30new'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-cmake configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>cg <Plug>(CMakeGenerate)
nmap <leader>cb <Plug>(CMakeBuild)
nmap <leader>ct <Plug>(CMakeBuild)
nmap <leader>ci <Plug>(CMakeInstall)
nmap <leader>cq <Plug>(CMakeClose)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lua plugins configuration                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config files in ~/.config/nvim/lua
lua require('bufferline-init')
lua require('indent-blankline-init')
lua require('lualine-init')
lua require('nvim-cmp-init')
lua require('nvim-lspconfig-init')
lua require('nvim-tree-init')
lua require('nvim-treesitter-init')
lua require('shade-init')
lua require('telescope-init')

" Config-less plugins
lua require('diffview').setup()
