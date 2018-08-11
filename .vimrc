" Enable syntax highlighting
syntax on

" Set font
set guifont=Source\ Code\ Pro\ for\ Powerline:h13

" Set colorscheme
set background=dark
colo gruvbox

" Set tab behaviour
set expandtab
set shiftwidth=4
set softtabstop=4
" set tabstop=4
" set softtabstop=0 noexpandtab
" set shiftwidth=4

" Autoindent based on file type
filetype plugin indent on

" Show line number
set number

" Hide buffers when abandoned
set hidden

" Highlight cursor line
set cursorline

set guioptions-=r
set guioptions-=L
set t_Co=256

" Highlight search matches
set hlsearch

" Case-sensitive search ONLY when capital letters appear in the search string
set ignorecase
set smartcase

" Show diff in vertical mode
set diffopt+=vertical

" Put new window to the right when using a vertical split
set splitright

" Set update delay (in milliseconds)
set updatetime=100

" Set minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" Do not wrap text except for some file types
set nowrap
autocmd FileType tex,txt setlocal wrap

" Open .tex files as LaTeX files
let g:tex_flavor='latex'

" Configure nesC syntax
augroup filetypedetect
    au! BufRead,BufNewFile *.nc setfiletype nc
augroup END

" Insert a new line after the current without entering INSERT mode
" nmap <CR> o<Esc>

" Insert a new line before the current without entering INSERT mode
" nmap <S-CR> O<Esc>

" Remap ESC to 'kj'
" imap kj <Esc>

" Windows navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers navigation
nnoremap <C-Tab>   :bn<CR>
nnoremap <S-C-Tab> :bp<CR>
inoremap <C-Tab>   <Esc>:bn<CR>i
inoremap <S-C-Tab> <Esc>:bp<CR>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline configuration "
"""""""""""""""""""""""""

" Set theme
let g:airline_theme = 'gruvbox'

" Set symbols (and enable powerline fonts)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

" Configure statusline
if has('gui_running')
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
endif
let g:airline_detect_modified = 1
let g:airline_skip_empty_sections = 1

" Configure section z (current position in the file)
function! AirlineInit()
    " let g:airline_section_z = airline#section#create(['%#__accent_bold#%{g:airline_symbols.linenr}%4l/%L%#__restore__#:%3v'])
    let g:airline_section_z = airline#section#create(['%#__accent_bold#%4l/%L%#__restore__#:%3v'])
endfunction
autocmd VimEnter * call AirlineInit()

" Enable fugitive (git extension)
let g:airline#extensions#fugitiveline#enabled = 1

" Enable hunks to show VCS modifications
let g:airline#extensions#hunks#enabled = 1

" Enable and configure tabline
set guioptions-=e
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline#extensions#ycm#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter configuration "
"""""""""""""""""""""""""""

" Disable signs on gutter
let g:gitgutter_signs = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree configuration "
""""""""""""""""""""""""""

" Show hidden files and sort them first
let NERDTreeShowHidden = 1
let NERDTreeSortHiddenFirst = 1

" Ignore some files
let NERDTreeIgnore = ['.DS_Store', '\.swp$', '\~$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter configuration "
"""""""""""""""""""""""""""""""

" Use alternative delimiters '//' for c files
let g:NERDAltDelims_c = 1

" Insert a space after comment delimiters
let g:NERDSpaceDelims = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe configuration "
"""""""""""""""""""""""""""""""

" Path to configuration file for semantic support
" let g:ycm_global_ycm_extra_conf = '/Users/Carlo/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Python interpreter (point to the one got from homebrew)
" let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_python_interpreter = '/usr/local/bin/python3'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'

" Minimum number of characters before autocompletion menu is displayed
" (default is 3)
let g:ycm_min_num_of_chars_for_completion = 3

" Disable diagnostic
let g:ycm_show_diagnostics_ui = 0

" Close preview window after autocompletion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lexima configuration "
"""""""""""""""""""""""""""""""

" Auto close dollar sign in LaTeX files
" call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
" call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
" call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
