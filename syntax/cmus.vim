" Syntax highlighting for cmus command/configuration files.
if exists('b:current_syntax')
  finish
endif

syntax case match

syntax match cmusComment /^\s*#.*$/

syntax match cmusCommand /^\s*\zs\%(bind\|unbind\)\>/ nextgroup=cmusFlag,cmusContext skipwhite
syntax match cmusFlag /-\a\+/ contained nextgroup=cmusContext skipwhite
syntax keyword cmusContext common library playlist queue browser filters settings contained nextgroup=cmusKey skipwhite
syntax match cmusKey /\S\+/ contained nextgroup=cmusAction skipwhite
syntax match cmusAction /\S\+/ contained nextgroup=cmusArgument skipwhite
syntax match cmusArgument /\S.*$/ contained contains=cmusBoolean,cmusNumber,cmusFormat

syntax match cmusCommand /^\s*\zsset\>/ nextgroup=cmusOption skipwhite
syntax match cmusOption /[A-Za-z_][A-Za-z0-9_.]*/ contained nextgroup=cmusEquals
syntax match cmusEquals /=/ contained nextgroup=cmusValue
syntax match cmusValue /.*$/ contained contains=cmusBoolean,cmusNumber,cmusHex,cmusFormat

syntax match cmusCommand /^\s*\zs\%(source\|colorscheme\|shell\|add\|fset\|factivate\)\>/ nextgroup=cmusArgument skipwhite
syntax keyword cmusBoolean true false default disabled off contained
syntax match cmusNumber /[-+]\=\d\+\%(\.\d\+\)\=%\=/ contained
syntax match cmusHex /#\x\{6}\>/ contained
syntax match cmusFormat /%[-0-9]*\%({[^}]*}\|[A-Za-z%=]\)/ contained

highlight default link cmusComment Comment
highlight default link cmusCommand Statement
highlight default link cmusFlag Special
highlight default link cmusContext Type
highlight default link cmusKey SpecialChar
highlight default link cmusAction Function
highlight default link cmusArgument String
highlight default link cmusOption Identifier
highlight default link cmusEquals Operator
highlight default link cmusValue String
highlight default link cmusBoolean Boolean
highlight default link cmusNumber Number
highlight default link cmusHex Constant
highlight default link cmusFormat Special

let b:current_syntax = 'cmus'
