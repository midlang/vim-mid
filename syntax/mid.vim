" augroup filetype
"   au! BufRead,BufNewFile *.mid setfiletype mid
" augroup end
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

syn keyword midTodo       contained TODO FIXME XXX
syn cluster midCommentGrp contains=midTodo

syn keyword midKeyword    syntax import option
syn keyword midKeyword    package message group oneof protocol enum bean struct const
syn keyword midKeyword    optional required repeated
syn keyword midKeyword    default
syn keyword midExtend     extends extensions to max
syn keyword midRPC        service rpc returns

syn keyword midType      int32 int64 uint32 uint64 sint32 sint64 int8 int16 uint8 uint16 int uint
syn keyword midType      fixed32 fixed64 sfixed32 sfixed64
syn keyword midType      float double bool string bytes float32 float64 byte
syn keyword midTypedef   vector map array
syn keyword midBool      true false

syn match   midInt     /-\?\<\d\+\>/
syn match   midInt     /\<0[xX]\x+\>/
syn match   midFloat   /\<-\?\d*\(\.\d*\)\?/
syn region  midComment start="\/\*" end="\*\/" contains=@midCommentGrp
syn region  midComment start="//" skip="\\$" end="$" keepend contains=@midCommentGrp
syn region  midString  start=/"/ skip=/\\./ end=/"/
syn region  midString  start=/'/ skip=/\\./ end=/'/

syn match midProtocol  /\(protocol\s\+\)\@<=\w\+\(\s\+{\)\@=/
syn match midProtocol  /\(protocol\s\+\)\@<=\w\+\(\s\+(\)\@=/
syn match midProtocol  /\(protocol\s\+\)\@<=\w\+\({\)\@=/
syn match midProtocol  /\(protocol\s\+\)\@<=\w\+\((\)\@=/
syn match midService  /\(service\s\+\)\@<=\w\+\(\s\+{\)\@=/
syn match midService  /\(service\s\+\)\@<=\w\+\({\)\@=/
syn match midEnum  /\(enum\s\+\)\@<=\w\+\(\s\+{\)\@=/
syn match midEnum  /\(enum\s\+\)\@<=\w\+\({\)\@=/
syn match midStruct  /\(struct\s\+\)\@<=\w\+\(\s\+{\)\@=/
syn match midStruct  /\(struct\s\+\)\@<=\w\+\({\)\@=/

  
syn match midFunction /\w\+\ze(/
hi def link midFunction          Function

if version >= 508 || !exists("did_mid_syn_inits")
  if version < 508
    let did_mid_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink midTodo         Todo

  "HiLink midSyntax       Include
  "HiLink midStructure    Structure
  "HiLink midRepeat       Repeat
  HiLink midKeyword      Keyword
  "HiLink midDefault      Keyword
  HiLink midExtend       Keyword
  HiLink midRPC          Keyword
  HiLink midType         Type
  HiLink midTypedef      Typedef
  HiLink midBool         Boolean

  HiLink midInt          Number
  HiLink midFloat        Float
  HiLink midComment      Comment
  HiLink midString       String

  HiLink midProtocol		Typedef
  HiLink midService			Typedef
  HiLink midEnum			Typedef
  HiLink midStruct		Typedef

  delcommand HiLink
endif

let b:current_syntax = "mid"
