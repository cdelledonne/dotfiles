" -----------------------------------------------------------------------------
" File: gruvbox-edit.vim
" Description: Tweaked version of the colorscheme 'gruvbox'
" Author: Carlo Delle Donne
" Based On: https://github.com/morhetz/gruvbox
" Last Modified: 2 Oct 2018
" -----------------------------------------------------------------------------


hi clear
if exists("syntax_on")
  syntax reset
endif

" Load base colorscheme (gruvbox)
runtime pack/plugins/start/gruvbox/colors/gruvbox.vim

" Override color name
let g:colors_name = 'gruvbox-edit'

" Function -> GruvboxGreen, instead of GruvboxGreenBold
hi! link Function GruvboxGreen
