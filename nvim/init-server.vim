""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" gruvbox color scheme
Plug 'morhetz/gruvbox'

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

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Allow repetition (dot command) for plugin mappings
Plug 'tpope/vim-repeat'

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
autocmd FileType tex,text,markdown,gitcommit setlocal spell spelllang=en_us

" Open .tex files as LaTeX files
let g:tex_flavor='latex'

" Configure nesC syntax
" augroup filetypedetect
    " au! BufRead,BufNewFile *.nc setfiletype nc
" augroup END

" Use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Windows navigation in terminal mode
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

" Buffers navigation
" nnoremap <C-Tab>   :bn<CR>
" nnoremap <S-C-Tab> :bp<CR>

" Folding
nnoremap <space> za

" Custom commands
command! RemoveTrailingSpaces %s/\s\+$//g | noh

" Set insert mode cursor as block
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20

" Enable reading of project-specific .vimrc
set exrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>gs :Gstatus<CR>

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
let g:indentLine_char = '┊'

" Enable for certain file types only
let g:indentLine_fileType = ['c', 'cpp', 'python', 'bash', 'rust', 'vim', 'lua']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoPairs configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ferret configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:FerretAutojump = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf configuration                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>f :FZF  --inline-info --prompt >\ <CR>

" Hide statusline in fzf buffers
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Match colorscheme
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Comment'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Statement'],
    \ 'fg+':     ['fg', 'Normal'],
    \ 'bg+':     ['bg', 'Normal'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'Comment'],
    \ 'border':  ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'PreProc'],
    \ 'pointer': ['fg', 'Label'],
    \ 'marker':  ['fg', 'Label'],
    \ 'spinner': ['fg', 'Function'],
    \ 'header':  ['fg', 'Comment']
    \ }
