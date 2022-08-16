" Use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Windows navigation in terminal mode
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

" Folding
nnoremap <space> za

" Editing
nnoremap <silent> <leader>af <cmd>call ToggleAutoFormat()<CR>
nnoremap <silent> <leader>rt <cmd>call RemoveTrailingSpaces()<CR>

" Plugins - normal mode

nnoremap <leader>tt <cmd>NvimTreeToggle<CR>
nnoremap <leader>tf <cmd>NvimTreeFocus<CR>

nnoremap <leader>c<Space> <Plug>NERDCommenterToggle
nnoremap <leader>cA <Plug>NERDCommenterAppend
nnoremap <leader>ca <Plug>NERDCommenterAltDelims

nnoremap <leader>cb <Plug>(CMakeBuild)
nnoremap <leader>cg <Plug>(CMakeGenerate)
nnoremap <leader>ci <Plug>(CMakeInstall)
nnoremap <leader>cq <Plug>(CMakeClose)
nnoremap <leader>ct <Plug>(CMakeTest)

nnoremap <leader>sb <cmd>Telescope buffers<CR>
nnoremap <leader>sc <cmd>Telescope commands<CR>
nnoremap <leader>sd <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader>sf <cmd>Telescope find_files<CR>
nnoremap <leader>sg <cmd>Telescope git_branches<CR>
nnoremap <leader>sh <cmd>Telescope help_tags<CR>
nnoremap <leader>sl <cmd>Telescope live_grep<CR>
nnoremap <leader>ss <cmd>Telescope grep_string<CR>
nnoremap <leader>sw <cmd>Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap z=         <cmd>Telescope spell_suggest<CR>

nnoremap <leader>mp <Plug>MarkdownPreviewToggle

" Plugins - insert mode

inoremap <C-c> <Plug>NERDCommenterInsert
