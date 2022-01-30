""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" gruvbox color scheme
Plug 'gruvbox-community/gruvbox'

" Status/tabline
Plug 'vim-airline/vim-airline'

" Show git modifications
Plug 'airblade/vim-gitgutter'

" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

" Commenter
Plug 'scrooloose/nerdcommenter'

" Auto-close pairs
Plug 'jiangmiao/auto-pairs'

" Search (and replace) multiple files
Plug 'wincent/ferret'

" Disable search highlighting when done searching
Plug 'romainl/vim-cool'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Allow repetition (dot command) for plugin mappings
Plug 'tpope/vim-repeat'

" Session manager
Plug 'tpope/vim-obsession'

Plug 'embear/vim-localvimrc'
Plug 'ARM9/arm-syntax-vim'

if $XDG_SESSION_TYPE != 'tty'

" Markdown preview and additional tools
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'

" TOML syntax highlighting
Plug 'cespare/vim-toml'

" Code snippets
Plug 'SirVer/ultisnips'

" Terminal wrapper
Plug 'kassio/neoterm'

" LaTeX autocompletion and other features
Plug 'lervag/vimtex'

" Peek content of registers
Plug 'junegunn/vim-peekaboo'

" CMake projects
" Plug 'cdelledonne/vim-cmake'
Plug '~/Developer/Repositories/cdelledonne/vim-cmake'

" Dependencies
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'  " Lua fork of vim-devicons

" Plug 'tami5/lspsaga.nvim'

" Dim inactive windows
Plug 'sunjon/shade.nvim'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Show indent lines
Plug 'lukas-reineke/indent-blankline.nvim'

endif

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
let g:gruvbox_italic=1
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Set tab behaviour
set expandtab
set shiftwidth=4
set softtabstop=4

" Tab behaviour for some config files
autocmd FileType yaml,toml setlocal shiftwidth=2 softtabstop=2

" Set folding method but do not fold on start-up
" set foldmethod=syntax
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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

" Set text width for line breaks for textual files
autocmd FileType tex,text,markdown,rst,gitcommit setlocal textwidth=80

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

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
nnoremap <silent> taf :call ToggleAutoFormat()<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline configuration                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Configure statusline symbols
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.notexists = ' Ɇ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = ''

" Configure section z (current position in the file)
function! AirlineInit()
    let g:airline_section_z = airline#section#create(
            \ ['%#__accent_bold#%4l/%L%#__restore__#:%3v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline#extensions#branch#enabled = 0

" Enable and configure tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_signs = 0

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
" UltiSnips configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open snippet file in a split (horizontal or vertical, depending on context)
let g:UltiSnipsEditSplit = 'context'

" Search snippets in the 'ultisnips' directory, relative to this file
let g:UltiSnipsSnippetDirectories = ['ultisnips']

" Unmap default CTRL-J and CTRL-K in insert mode
let g:i_CTRL_J = 'off'
let g:i_CTRL_K = 'off'

" Remap triggers
let g:UltiSnipsExpandTrigger       = '<C-e>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsListSnippets        = '<C-s>'

" Import C snippets into C++ files
autocmd FileType cpp UltiSnipsAddFiletypes cpp.c

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
" vimtex configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable folding (should work with treesitter?)
" let g:vimtex_fold_enabled = 1

" Configure ToC
let g:vimtex_toc_config = {
        \ 'name': 'ToC ',
        \ 'split_pos': 'vert topleft',
        \ 'split_width': 30,
        \ }

" Do not open quickfix window if there are only compilation warnings
let g:vimtex_quickfix_open_on_warning = 0

augroup VIMTEX
    autocmd!
    " Center cursor vertically after jumping to ToC entry
    autocmd User VimtexEventTocActivated execute 'normal! zz'
augroup END

" Workaround, check :help vimtex-faq-neovim
let g:vimtex_compiler_progname = 'nvr'

" Use XeLaTeX as default engine for Latexmk
" let g:vimtex_compiler_latexmk_engines['_'] = '-xelatex'

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
nmap <leader>ci <Plug>(CMakeInstall)
nmap <leader>cq <Plug>(CMakeClose)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-lspconfig and lspsaga.nvim configuration                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
lua require('nvim-lspconfig-init')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-treesitter configuration                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
lua require('nvim-treesitter-init')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
lua require('telescope-init')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shade configuration                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require('shade').setup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-tree configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
lua require('nvim-tree-init')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent-blankline configuration                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
lua require('indent-blankline-init')
