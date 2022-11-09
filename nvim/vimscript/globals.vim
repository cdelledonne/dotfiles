" From :help provider-nodejs
" By default, Nvim searches for 'neovim-node-host' using 'npm root -g', which
" can be slow. To avoid this, set g:node_host_prog to the host path:
"     let g:node_host_prog = '/usr/local/bin/neovim-node-host'
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" Set tab behaviour
set expandtab
set shiftwidth=4
set softtabstop=4

" Tab behaviour for some config files
autocmd FileType yaml,toml,markdown setlocal shiftwidth=2 softtabstop=2

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

" Set minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" Do not wrap text except for textual files
set nowrap
autocmd FileType tex,text,markdown setlocal wrap linebreak

" Enable spell checking for textual files
autocmd FileType tex,text,markdown,rst,gitcommit setlocal spell spelllang=en_us

" Set text width for line breaks for some filetypes
autocmd FileType tex,text,markdown,rst,gitcommit,vim setlocal textwidth=80

" Open .clangd and .clang-format files as YAML files
autocmd BufRead *.clang-format setlocal filetype=yaml
autocmd BufRead *.clangd setlocal filetype=yaml

" Open .tex files as LaTeX files
let g:tex_flavor='latex'

" Mouse support in normal and visual mode
set mouse=nv

" Redefine leader to be ';'
let mapleader = ";"
