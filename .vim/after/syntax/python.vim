syn keyword pythonBoolean False None True
syn keyword pythonBuiltin self

syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

syn match pythonParenthesis "("
syn match pythonFunctionCall "\w\+\s*(" contains=pythonParenthesis
hi def link pythonFunctionCall pythonFunction

hi def link pythonBoolean boolean
hi def link pythonDocstring Comment
