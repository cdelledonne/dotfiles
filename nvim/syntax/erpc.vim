" ==============================================================================
" eRPC interface description language syntax file
" ==============================================================================

if exists("b:current_syntax")
  finish
endif

syntax case match
syn sync minlines=100

" ------------------------------------------------------------------------------
" Comments (basic + Doxygen)
" ------------------------------------------------------------------------------
syntax region erpcDocComment start='/\*\*' end='\*/' keepend contains=@Spell extend
syntax region erpcDocComment start='/!\*' end='\*/' keepend contains=@Spell extend
syntax match  erpcDocComment '^\s*///.*$' contains=@Spell
syntax match  erpcDocComment '^\s*//!.*$' contains=@Spell

syntax region erpcComment start='/\*' end='\*/' keepend contains=@Spell,erpcDocComment
syntax match  erpcComment '//.*$' contains=@Spell

" ------------------------------------------------------------------------------
" Strings
" ------------------------------------------------------------------------------
syntax region erpcString start=+"+ skip=+\\\\\|\\"+ end=+"+

" ------------------------------------------------------------------------------
" Keywords
" ------------------------------------------------------------------------------
syntax keyword erpcKeyword program interface struct enum union case default byref import const type oneway
syntax keyword erpcDir     in out inout

" ------------------------------------------------------------------------------
" Built-in types
" ------------------------------------------------------------------------------
syntax keyword erpcType bool string float double void
syntax keyword erpcType int8 int16 int32 int64
syntax keyword erpcType uint8 uint16 uint32 uint64
syntax keyword erpcType binary list

" ------------------------------------------------------------------------------
" Custom user-defined types (e.g. struct Foo)
" ------------------------------------------------------------------------------
syntax match erpcUserType '\%(\<struct\s\+\|\<enum\s\+\|\<union\s\+\|\<interface\s\+\|\<type\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
" Matches a capitalized identifier followed by a lowercase one, e.g. 'Person who'
syntax match erpcUserType '\<[A-Z][A-Za-z0-9_]*\>\ze\s\+\h\w*\s*\(@\h\w*\)\?[),]' containedin=ALLBUT,erpcComment,erpcDocComment
" Match a capitalized identifier (custom type) before a member name, ending with newline or '}'
syntax match erpcUserType '^\s*\zs[A-Z][A-Za-z0-9_]*\>\ze\s\+\h\w*\s*\(@\h\w*\)\?\($\|}\)' containedin=ALLBUT,erpcComment,erpcDocComment
" Match a capitalized identifier immediately after '->'
syntax match erpcUserType '\%(\s*->\s*\)\@<=[A-Z][A-Za-z0-9_]*\>' containedin=ALLBUT,erpcComment,erpcDocComment

" ------------------------------------------------------------------------------
" Annotations (e.g., @length(len), @nullable)
" ------------------------------------------------------------------------------
" Match @annotation(...) or bare @annotation
syntax match erpcAnnotation '@\h\w*' containedin=ALLBUT,erpcComment,erpcDocComment

" ------------------------------------------------------------------------------
" Operators & punctuation
" ------------------------------------------------------------------------------
" Prevent operators from matching inside comments
syntax match erpcOp '==\|!=\|<=\|>=\|<<\|>>\|&&\|||'
syntax match erpcOp '[-+*%&|^~<>]=\=' containedin=ALLBUT,erpcComment,erpcDocComment
syntax match erpcOp '[(){}\[\],.;:?]' containedin=ALLBUT,erpcComment,erpcDocComment
syntax match erpcOp '->' containedin=ALLBUT,erpcComment,erpcDocComment

" ------------------------------------------------------------------------------
" Function names
" ------------------------------------------------------------------------------
syntax match erpcFuncName '\<\h\w*\>\s*\ze(' containedin=ALLBUT,erpcComment,erpcDocComment,erpcAnnotation nextgroup=erpcParams
syntax region erpcParams start='(' end=')' transparent

" ------------------------------------------------------------------------------
" Highlight links
" ------------------------------------------------------------------------------
hi def link erpcComment        Comment
hi def link erpcDocComment     Comment
hi def link erpcString         String
hi def link erpcKeyword        Keyword
hi def link erpcDir            StorageClass
hi def link erpcType           Type
hi def link erpcUserType       Type
hi def link erpcUserTypeParam  Type
hi def link erpcOp             Operator
hi def link erpcFuncName       Function
hi def link erpcAnnotation     PreProc

let b:current_syntax = "erpc"
