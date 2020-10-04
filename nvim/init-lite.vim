""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" gruvbox color scheme
Plug 'gruvbox-community/gruvbox'

" Status/tabline
Plug 'vim-airline/vim-airline'

" Show indent lines
Plug 'Yggdroot/indentLine'

" Disable search highlighting when done searching
Plug 'romainl/vim-cool'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

if $XDG_SESSION_TYPE != 'tty'

" Markdown
Plug 'plasticboy/vim-markdown'

" TOML syntax highlighting
Plug 'cespare/vim-toml'

" File type icons (load as the last one)
Plug 'ryanoasis/vim-devicons'

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
autocmd FileType yaml,toml set shiftwidth=2 softtabstop=2

" Set folding method but do not fold on start-up
set foldmethod=syntax
set nofoldenable

" Fold specific files based on indent
autocmd FileType python,basic,yaml,toml,vim set foldmethod=indent

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
autocmd BufRead *.clang-format set filetype=yaml

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
" vim-devicons configuration                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:webdevicons_enable_airline_tabline = 0
