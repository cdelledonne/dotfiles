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

" File navigator
Plug 'preservim/nerdtree'

" Commenter
Plug 'scrooloose/nerdcommenter'

" Auto-close pairs
Plug 'jiangmiao/auto-pairs'

" Show indent lines
Plug 'Yggdroot/indentLine'

" Search (and replace) multiple files
Plug 'wincent/ferret'

" Fuzzy search (for buffers and multiple-entry selection)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

" Completion framework
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'liuchengxu/vista.vim'

" Language server client add-ons
Plug 'jackguo380/vim-lsp-cxx-highlight'

" LaTeX autocompletion and other features
Plug 'lervag/vimtex'

" Peek content of registers
Plug 'junegunn/vim-peekaboo'

" CMake projects
" Plug 'cdelledonne/vim-cmake'
Plug '~/Developer/Repositories/cdelledonne/vim-cmake'

" File type icons (load as the last one)
Plug 'ryanoasis/vim-devicons'

endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings                                                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set foldmethod=syntax
set nofoldenable

" Fold specific files based on indent
autocmd FileType python,basic,yaml,toml,vim setlocal foldmethod=indent

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

" Use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Windows navigation in terminal mode
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

" Folding
nnoremap <space> za

" Custom commands
command! RemoveTrailingSpaces %s/\s\+$//g | noh

" Set insert mode cursor as block
" set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20
set guicursor=

" Mouse support in normal and visual mode
set mouse=nv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom theming                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight folds as comments
highlight! link Folded Comment

" Apply a slightly lighter backgroun on inactive windows
highlight ThemeNormalNC ctermfg=223 ctermbg=234 guifg=#ebdbb2 guibg=#282828

function! s:OnWinEnter() abort
    set winhighlight=NormalNC:ThemeNormalNC
    if &l:number
        setlocal relativenumber
    endif
    setlocal cursorline
endfunction

function! s:OnWinLeave() abort
    set winhighlight=NormalNC:ThemeNormalNC
    if &l:number
        setlocal norelativenumber
    endif
    setlocal nocursorline
endfunction

autocmd VimEnter,BufEnter,WinEnter * call s:OnWinEnter()
autocmd BufLeave,WinLeave * call s:OnWinLeave()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline configuration                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Configure statusline symbols
let g:airline_symbols.branch = ''
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

" let g:airline#extensions#term#enabled = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_signs = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show hidden files and sort them first
let NERDTreeShowHidden = 1
let NERDTreeSortHiddenFirst = 1

" Ignore some files
let NERDTreeIgnore = ['.DS_Store', '\.swp$', '\~$']

let NERDTreeStatusline = 'NERDTree'

" Toggle window
nnoremap <silent> <F11> :NERDTreeToggle<CR>

" Focus window
nnoremap <silent> <F10> :NERDTreeFocus<CR>

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
" indentLine configuration                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Change default indent line character
" let g:indentLine_char = '┊'
let g:indentLine_char = '│'

" Enable for certain file types only
let g:indentLine_fileType = [
    \ 'c', 'cpp', 'python', 'bash', 'rust', 'vim', 'lua', 'yaml', 'php',
    \ 'javascript', 'html', 'css', 'cmake', 'go'
    \ ]

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
" Coc configuration                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <C-Space> to trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" Highlight comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

" Define key bindings
function! SetLSPShortcuts()
    nmap <silent> <leader>df <Plug>(coc-definition)
    nmap <silent> <leader>dc <Plug>(coc-declaration)
    nmap <silent> <leader>im <Plug>(coc-implementation)
    nmap <silent> <leader>td <Plug>(coc-type-definition)
    nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
    nmap <silent> <leader>dp <Plug>(coc-diagnostic-previous)
    nmap <silent> <leader>dl :CocList diagnostics<CR>
    nmap <silent> <leader>rf <Plug>(coc-references)
    vmap <silent> <leader>fs <Plug>(coc-format-selected)
    nmap <silent> <leader>rn <Plug>(coc-rename)
    nmap <silent> <leader>fx <Plug>(coc-fix-current)
    nmap <silent> <leader>hv :call CocActionAsync('doHover')<CR>
    nmap <silent> <leader>hl :call CocActionAsync('highlight')<CR>
endfunction()

" Set key bindings for some specific file types
augroup LSP
    autocmd!
    autocmd FileType c,cpp,python,php,javascript,typescript
            \ call SetLSPShortcuts()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vista configuration                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vista_echo_cursor = 0
let g:vista_blink = [0, 0]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:deoplete#enable_at_startup = 1

" Do not show preview
" set completeopt-=preview

" Use <Tab> and <S-Tab> to navigate completion list
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enable around and buffer sources in some textual filetypes only
" call deoplete#custom#source('around', 'filetypes', ['text', 'markdown'])
" call deoplete#custom#source('buffer', 'filetypes', ['text', 'markdown'])

" Enable tmux source in tmux files only
" call deoplete#custom#source('tmux-complete', 'filetypes', ['tmux'])

" Enable syntax source in some filetypes only
" call deoplete#custom#source('syntax', 'filetypes', ['make', 'cmake'])
" let g:necosyntax#max_syntax_lines = 50000

" Trigger completion of some sources after typing 3 characters
" call deoplete#custom#source('LanguageClient', 'min_pattern_length', 3)
" call deoplete#custom#source('tmux-complete', 'min_pattern_length', 3)
" call deoplete#custom#source('syntax', 'min_pattern_length', 3)
" call deoplete#custom#source('lsp', 'min_pattern_length', 3)
" call deoplete#custom#source('ultisnips', 'min_pattern_length', 3)

" call deoplete#custom#source('lsp', 'mark', '[+]')
" call deoplete#custom#source('ultisnips', 'mark', '[$]')

" call deoplete#custom#source('lsp', 'rank', 1)
" call deoplete#custom#source('ultisnips', 'rank', 2)
" call deoplete#custom#source('ultisnips', 'rank', 2)

" Disable the truncate feature
" call deoplete#custom#source('_', 'max_abbr_width', 0)
" call deoplete#custom#source('_', 'max_menu_width', 0)

" LaTeX autocompletion with vimtex
" call deoplete#custom#var('omni', 'input_patterns', {
        " \ 'tex': g:vimtex#re#deoplete
        " \ })

" Close preview window when leaving INSERT mode
" autocmd InsertLeave * silent! pclose!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neopairs configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoclose parentheses when completing a function with deoplete
" let g:neopairs#enable = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet configuration                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:neosnippet#disable_runtime_snippets = 1
" let g:neosnippet#enable_completed_snippet = 1
" let g:neosnippet#enable_complete_done = 1

" imap <C-K> <Plug>(neosnippet_expand_or_jump)
" smap <C-K> <Plug>(neosnippet_expand_or_jump)
" xmap <C-K> <Plug>(neosnippet_expand_target)

" if has('conceal')
  " set conceallevel=2 concealcursor=niv
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp-cxx-highlight configuration                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable logging
let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
let g:lsp_cxx_hl_verbose = 1

" Clear/change some highlight groups
hi link LspCxxHlSymVariable   NONE
hi link LspCxxHlSymParameter  NONE
hi link LspCxxHlSymUnknown    NONE
hi link LspCxxHlSymField      NONE
hi link LspCxxHlSymEnumMember Constant

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Workaround, check :help vimtex-faq-neovim
let g:vimtex_compiler_progname = 'nvr'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf configuration                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Hide statusline in fzf buffers
augroup FZF
    autocmd!
    autocmd FileType fzf set laststatus=0 noshowmode noruler nonumber nornu
        \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler number rnu
augroup END

" Use default colors defined in environment variable $FZF_DEFAULT_OPTS
let g:fzf_colors = {}

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
" vim-devicons configuration                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:webdevicons_enable_airline_tabline = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nvim LSP configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
" if has('nvim-0.5')
    " lua require 'lspinit'
" endif
