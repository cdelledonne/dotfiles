""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins (managed by vim-plug)                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plug')

" gruvbox color scheme
Plug 'morhetz/gruvbox'

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

" Markdown preview and additional tools
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Plug 'SidOfc/mkdx'

" Code snippets
Plug 'SirVer/ultisnips'

" Terminal wrapper
Plug 'kassio/neoterm'

" Search (and replace) multiple files
Plug 'dyng/ctrlsf.vim'

" Completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }

" Completion sources for deoplete
Plug 'Shougo/neco-vim'
Plug 'wellle/tmux-complete.vim'
Plug 'Shougo/neco-syntax'

" Plugins for deoplete
Plug 'Shougo/neopairs.vim'

" Language server client
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'jackguo380/vim-lsp-cxx-highlight'

" Fuzzy search (for buffers and multiple-entry selection)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Viewer & Finder for LSP symbols and tags in Vim
Plug 'liuchengxu/vista.vim'
" Plug 'cdelledonne/vista.vim', { 'dir': '~/.local/share/nvim/forkedplug/vista.vim' }

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Allow repetition (dot command) for plugin mappings
Plug 'tpope/vim-repeat'

Plug '~/.local/share/nvim/plug/hilsp.nvim'

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
autocmd BufNewFile,BufRead *.py,*.bas set foldmethod=indent

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
" airline configuration                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Enable powerline fonts
" if has('gui_running')
    let g:airline_powerline_fonts = 1
    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''
" endif

" Configure statusline symbols
" if has('gui_running')
    let g:airline_symbols.branch = ''
    let g:airline_symbols.notexists = ' Ɇ'
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.dirty = ''
" endif

" Detect modified buffers
let g:airline_detect_modified = 1

" Skip empty sections
let g:airline_skip_empty_sections = 1

" Configure section z (current position in the file)
function! AirlineInit()
    " let g:airline_section_z = airline#section#create(['%#__accent_bold#%{g:airline_symbols.linenr}%4l/%L%#__restore__#:%3v'])
    let g:airline_section_z = airline#section#create(['%#__accent_bold#%4l/%L%#__restore__#:%3v'])
endfunction
autocmd VimEnter * call AirlineInit()

" Enable and configure tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

" Enable fugitive (git extension)
let g:airline#extensions#fugitiveline#enabled = 1

" Enable hunks to show VCS modifications
let g:airline#extensions#hunks#enabled = 1

" Enable YCM integration
let g:airline#extensions#ycm#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>s :Gstatus<CR>

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
let g:indentLine_char = '┊'

" Enable for certain file types only
let g:indentLine_fileType = ['c', 'cpp', 'python', 'bash', 'rust', 'vim', 'lua']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoPairs configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips configuration                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open snippet file in a split (horizontal or vertical, depending on context)
let g:UltiSnipsEditSplit = 'context'

" Directory containing user-defined snippets
let g:UltiSnipsSnippetsDir = '~/.config/nvim/ultisnips'

" Search snippets in above directory, plus the default 'UltiSnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips', 'UltiSnips']

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
" CtrlSF configuration                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Focus CtrlSF window when search is done
let g:ctrlsf_auto_focus = { 'at' : 'done', 'duration_less_than' : 2000 }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc configuration                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use <Tab> and <S-Tab> to navigate completion list
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <C-Space> to trigger completion
" inoremap <silent><expr> <C-Space> coc#refresh()

" nnoremap <leader>gg <Plug>(coc-definition)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient-neovim configuration                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loggingLevel = 'DEBUG'

" Enable loading of settings file
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'

" Filetype-specific commands (language servers)
let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '-log-file=/tmp/ccls.log', '-v=1'],
    \ 'cpp': ['ccls', '-log-file=/tmp/ccls.log', '-v=1'],
    \ 'python': ['pyls'],
    \ }

let g:LanguageClient_rootMarkers = {
    \ 'c': ['build/compile_commands.json', 'compile_commands.json'],
    \ 'cpp': ['build/compile_commands.json', 'compile_commands.json'],
    \ }

" Define key bindings
function! SetLSPShortcuts()
  nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <leader>lD :call LanguageClient#textDocument_definition({'gotoCmd': 'vsplit'})<CR>
  nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>
  " nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <silent> <leader>lx :call LanguageClient#textDocument_references()<CR>
  " nnoremap <silent> <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <silent> <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
  " nnoremap <silent> <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <silent> <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

" Set key bindings for some specific file types
augroup LSP
  autocmd!
  autocmd FileType c,cpp,python call SetLSPShortcuts()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enable around and buffer sources in some textual filetypes only
call deoplete#custom#source('around', 'filetypes', ['text', 'markdown'])
call deoplete#custom#source('buffer', 'filetypes', ['text', 'markdown'])

" Enable tmux source in tmux files only
call deoplete#custom#source('tmux-complete', 'filetypes', ['tmux'])

" Enable syntax source in some filetypes only
call deoplete#custom#source('syntax', 'filetypes', ['make', 'cmake'])
let g:necosyntax#max_syntax_lines = 50000

" Trigger completion of some sources after typing 3 characters
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 3)
call deoplete#custom#source('tmux-complete', 'min_pattern_length', 3)
call deoplete#custom#source('syntax', 'min_pattern_length', 3)

" Disable the truncate feature
call deoplete#custom#source('_', 'max_abbr_width', 0)
call deoplete#custom#source('_', 'max_menu_width', 0)

" Close preview window when leaving INSERT mode
autocmd InsertLeave * silent! pclose!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neopairs configuration                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoclose parentheses when completing a function with deoplete
let g:neopairs#enable = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp-cxx-highlight configuration                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable logging
let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
let g:lsp_cxx_hl_verbose = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" hilsp configuration                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:hilsp_log_file = '/tmp/hilsp.log'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vista configuration                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set LanguageClient-neovim as default source for Vista for some filetypes
let g:vista_executive_for = {
    \ 'c': 'lcn',
    \ 'cpp': 'lcn',
    \ 'python': 'lcn',
    \ 'rust': 'lcn',
    \ 'vim': 'lcn'
    \ }

let g:vista_icon_indent = ["▸ ", "▸ "]

" Position and size of FZF window
let g:vista_fzf_preview = ['right:25%']

" Disable icons
let g:vista#renderer#enable_icon = 0

" Display info in floating window when hovering over tags
" let g:vista_echo_cursor_strategy = 'floating_win'

" Display info immediately when hovering over tags
let g:vista_cursor_delay = 0

" Do not blink when jumping
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]

" Map commands
nnoremap <silent> <F12> :Vista focus<CR>
nnoremap <silent> <leader>ls :Vista finder lcn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview configuration                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>p <Plug>MarkdownPreviewToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" More general settings                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set secure

function! Make() abort
    let l:curr_dir = expand('%:p:h')
    if match(l:curr_dir, $HOME) != 0
        echo 'Cannot run outside $HOME directory.'
        return
    endif
    while match(l:curr_dir, $HOME) == 0
        let l:build_dir = expand(l:curr_dir . '/build')
        if filereadable(expand(l:build_dir . '/Makefile'))
            execute '!make ' . '-C ' . l:build_dir
            return
        endif
        let l:curr_dir = fnamemodify(l:curr_dir, ':h')
    endwhile
    echo "Makefile not found."
endfunction

nnoremap <leader>m :call Make()<CR>
