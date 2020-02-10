" -----------------------------------------------------------------------------
" File: basic.vim
" Language: ADbasic
" Author: Carlo Delle Donne
" Last Change: Jan 29 2019
" Description: Extension to BASIC syntax file to support ADbasic syntax
" -----------------------------------------------------------------------------

" Process labels
syn keyword basicLabel lowinit LOWINIT LowInit Lowinit
syn keyword basicLabel init INIT Init
syn keyword basicLabel event EVENT Event
syn keyword basicLabel finish FINISH Finish

" General keywords
syn keyword basicStatement endif ENDIF EndIf Endif
syn keyword basicStatement to TO To
syn keyword basicStatement until UNTIL Until
syn keyword basicStatement selectcase SELECTCASE SelectCase Selectcase
syn keyword basicStatement ccase CCASE CCase Ccase
syn keyword basicStatement caseelse CASEELSE CaseElse Caseelse
syn keyword basicStatement endselect ENDSELECT EndSelect Endselect
syn keyword basicStatement endfunction ENDFUNCTION EndFuntion Endfunction
syn keyword basicStatement endsub ENDSUB EndSub Endsub

" Boolean/bitwise operators
syn keyword basicStatement and AND And
syn keyword basicStatement or OR Or
syn keyword basicStatement xor XOR XOr Xor

" Type specifiers
syn keyword basicTypeSpecifier long LONG Long
syn keyword basicTypeSpecifier float FLOAT Float

" Variable declarators
syn keyword basicDeclaration dim DIM Dim
syn keyword basicDeclaration as AS As

" Hexadecimal number
syn match basicNumber "\<\d\x\+h\>"
" Binary number
syn match basicNumber "\<[01]\+b\>"
" Scientific notation (integer)
syn match basicNumber "\<\d\+[eE]\d\+\>"
" Scientific notation (float)
syn match basicNumber "\<\(\d\+\)\?\.\d*[eE]\d\+\>"

" Predefined variables
syn keyword basicIdentifier processdelay PROCESSDELAY ProcessDelay Processdelay
syn match basicIdentifier "\<[fF]\?\(par\|PAR\|Par\)_\([1-9]\|[1-7][0-9]\|80\)\>"
syn match basicIdentifier "\<\(data\|DATA\|Data\)_\([1-9]\|[1-9][0-9]\|1[0-9][0-9]\|200\)\>"

" Hexadecimal number error
syn match basicNumberError "\<\D\x\+h\>"

" Function call/declaration
syn match basicParenthesis "("
syn match basicCustomFunction "\w\+\s*(" contains=basicParenthesis

" Preprocessor directives
syn match basicPreProc "#include\|#INCLUDE\|#Include"
syn match basicPreProc "#define\|#DEFINE\|#Define"

" Include files
syn region basicIncluded start="#include\|#INCLUDE\|#Include" end="$" contains=basicPreProc

" Comments
syn region basicComment start="^\(rem\|Rem\|REM\)" end="$" contains=basicTodo
syn region basicComment start=":\s*\(rem\|Rem\|REM\)" end="$" contains=basicTodo
syn region basicComment start="'" end="$" contains=basicTodo

hi def link basicDeclaration StorageClass
hi def link basicNumberError Error
hi def link basicPreProc PreProc
hi def link basicIncluded String
hi def link basicCustomFunction Function
hi def link basicIdentifier Identifier
