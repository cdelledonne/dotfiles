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
" Coc configuration                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
