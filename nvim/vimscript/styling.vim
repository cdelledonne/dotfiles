" Set insert mode cursor as block
" set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20
set guicursor=

" Enable true colors
if $COLORTERM == 'truecolor'
    set termguicolors
endif

" Color scheme
" Gruvbox configuration must be called before loading colorscheme
lua require('plugins/gruvbox-init')
colorscheme gruvbox

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

" Change highlight of sign column
highlight clear SignColumn
highlight! link CursorLineSign CursorLine

" TreeSitter custom highlights
highlight! link TSConstructor Function

" Telescope custom highlights
highlight! link TelescopePromptPrefix Normal
highlight! link TelescopeSelection CursorLine
highlight! link TelescopeMatching Special
highlight! link TelescopeMultiSelection Type
highlight! link TelescopeMultiIcon Type

" DAP UI custom highlights
highlight! link DapUIVariable Identifier
highlight! link DapUIScope DashboardHeader
highlight! link DapUIType Type
highlight! link DapUIValue None
highlight! link DapUIModifiedValue Constant
highlight! link DapUIDecoration Operator
highlight! link DapUIThread DashboardHeader
highlight! link DapUIStoppedThread DapUIThread
highlight! link DapUIFrameName Function
highlight! link DapUISource Identifier
highlight! link DapUILineNumber Type
highlight! link DapUIFloatBorder None
highlight! link DapUIWatchesEmpty DashboardHeader
highlight! link DapUIWatchesValue Operator
highlight! link DapUIWatchesError Operator
highlight! link DapUIBreakpointsPath DashboardHeader
highlight! link DapUIBreakpointsInfo Keyword
highlight! link DapUIBreakpointsCurrentLine Function
highlight! link DapUIBreakpointsLine DapUILineNumber
highlight! link DapUIBreakpointsDisabledLine LineNr
