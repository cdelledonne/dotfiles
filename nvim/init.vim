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
Plug 'scrooloose/nerdtree'

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

if $XDG_SESSION_TYPE != 'tty'

" Markdown preview and additional tools
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'cdelledonne/vim-markdown', { 'branch': 'insert-toc' }

" TOML syntax highlighting
Plug 'cespare/vim-toml'

" Code snippets
Plug 'SirVer/ultisnips'

" Terminal wrapper
Plug 'kassio/neoterm'

" Nvim LSP client configurations
" Plug 'neovim/nvim-lsp'

" Completion framework
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Completion sources for deoplete
" Plug 'Shougo/neco-vim'
" Plug 'wellle/tmux-complete.vim'
" Plug 'Shougo/neco-syntax'
" Plug 'Shougo/deoplete-lsp' " source: 'lsp'

" Plugins for deoplete
" Plug 'Shougo/neopairs.vim'
" Plug 'Shougo/neosnippet.vim'

" Language server client add-ons
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Fuzzy search in preview window
Plug 'yuki-ycino/fzf-preview.vim'

" LaTeX autocompletion and other features
Plug 'lervag/vimtex'

" Peek content of registers
Plug 'junegunn/vim-peekaboo'

" Local plugins
Plug '~/Nextcloud/Developer/cdelledonne/vim-cmake'

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
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Set tab behaviour
set expandtab
set shiftwidth=4
set softtabstop=4

" Set folding method but do not fold on start-up
set foldmethod=syntax
set nofoldenable

" Fold specific files based on indent
autocmd FileType python,basic,yaml set foldmethod=indent

" Show line number
set number

" Display keystrokes in the command line in normal mode
set showcmd

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline configuration                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '│'
let g:airline_right_alt_sep = '│'

" Configure statusline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = ' Ɇ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = ''

" Detect modified buffers
let g:airline_detect_modified = 1

" Skip empty sections
let g:airline_skip_empty_sections = 1

" Configure section z (current position in the file)
function! AirlineInit()
    " let g:airline_section_z = airline#section#create(['%#__accent_bold#%{g:airline_symbols.linenr}%4l/%L%#__restore__#:%3v'])
    let g:airline_section_z = airline#section#create(['%#__accent_bold#%4l/%L%#__restore__#:%3v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Enable and configure tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

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

" Insert comment in insert mode
imap <C-c> <Plug>NERDCommenterInsert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine configuration                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Change default indent line character
" let g:indentLine_char = '┊'
let g:indentLine_char = '│'

" Enable for certain file types only
let g:indentLine_fileType = [
    \ 'c', 'cpp', 'python', 'bash', 'rust', 'vim', 'lua', 'yaml'
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
" CtrlSF configuration (NOT USED)                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Focus CtrlSF window when search is done
let g:ctrlsf_auto_focus = { 'at' : 'done', 'duration_less_than' : 2000 }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ferret configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:FerretAutojump = 1

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
    nmap <silent> <leader>h  :call CocAction('doHover')<CR>
endfunction()

" Set key bindings for some specific file types
augroup LSP
    autocmd!
    autocmd FileType c,cpp,python call SetLSPShortcuts()
augroup END

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

if $XDG_SESSION_TYPE == 'tty'
    nnoremap <silent> <C-F> :FZF --inline-info --prompt >\ <CR>
else
    nnoremap <silent> <C-F> :FzfPreviewProjectFiles<CR>
    nnoremap <silent> <leader>b :FzfPreviewBuffers<CR>
endif

" Hide statusline in fzf buffers
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Match colorscheme
"
" The same effect is achieved with
"
" export FZF_DEFAULT_OPTS="
"     --color bg+:#282828,bg:#282828,border:#83a598,spinner:#928374,hl:#fe8019
"     --color fg:#928374,header:#928374,info:#928374,pointer:#83a598
"     --color marker:#b8bb26,fg+:#b8bb26,prompt:#83a598,hl+:#fe8019
"
" which is useful when running fzf outside Vim
"
" let g:fzf_colors = {
    " \ 'fg':      ['fg', 'Comment'],
    " \ 'bg':      ['bg', 'Normal'],
    " \ 'hl':      ['fg', 'Question'],
    " \ 'fg+':     ['fg', 'Function'],
    " \ 'bg+':     ['bg', 'Normal'],
    " \ 'hl+':     ['fg', 'Question'],
    " \ 'info':    ['fg', 'Comment'],
    " \ 'border':  ['fg', 'Identifier'],
    " \ 'prompt':  ['fg', 'Identifier'],
    " \ 'pointer': ['fg', 'Identifier'],
    " \ 'marker':  ['fg', 'Function'],
    " \ 'spinner': ['fg', 'Comment'],
    " \ 'header':  ['fg', 'Comment']
    " \ }

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

let g:cmake_native_options = ['--no-print-directory']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nvim LSP configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lua config file in ~/.config/nvim/lua
" if has('nvim-0.5')
    " lua require 'lspinit'
" endif
