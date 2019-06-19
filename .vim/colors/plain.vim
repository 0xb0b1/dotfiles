
set background=dark
highlight clear

if exists("syntax on")
  hi clear
  hi clear CursorLine
  syntax reset
endif

let g:colors_name = "plain"

hi Cursor          ctermfg=231
hi Normal          ctermfg=231 ctermbg=NONE 
hi Title           ctermfg=254 ctermbg=NONE term=bold cterm=bold
hi Special         ctermfg=250 ctermbg=NONE 
hi Comment         ctermfg=240 ctermbg=NONE term=italic
hi Constant        ctermfg=248 ctermbg=NONE 
hi String          ctermfg=242 ctermbg=NONE 
hi Number          ctermfg=242 ctermbg=NONE 
hi htmlTagName     ctermfg=254 ctermbg=NONE 
hi Identifier      ctermfg=250 ctermbg=NONE 
hi Statement       ctermfg=242 ctermbg=NONE cterm=NONE
hi Boolean         ctermfg=252 ctermbg=NONE cterm=NONE
hi PreProc         ctermfg=244 ctermbg=NONE 
hi Type            ctermfg=248 ctermbg=NONE 
hi Function        ctermfg=231 ctermbg=NONE cterm=NONE
hi Repeat          ctermfg=244 ctermbg=NONE 
hi Operator        ctermfg=242 ctermbg=NONE 
hi Error           ctermfg=231 ctermbg=NONE 
hi TODO            ctermfg=231 ctermbg=NONE cterm=italic
hi linenr          ctermfg=237 ctermbg=NONE term=bold cterm=bold
hi CursorLine      ctermfg=231 ctermbg=235 cterm=bold
hi CursorLineNR    ctermfg=231 ctermbg=235 term=bold cterm=bold
hi Search          ctermfg=231 ctermbg=242  term=bold cterm=bold
hi IncSearch       ctermfg=231 ctermbg=242  term=bold cterm=bold
hi WildMenu        ctermfg=254 ctermbg=244 

" Messages
hi ModeMsg         ctermfg=232 ctermbg=231
hi MoreMsg         ctermfg=232 ctermbg=231
hi WarningMsg      ctermfg=202 ctermbg=NONE
hi ErrorMsg        ctermfg=232 ctermbg=231 term=NONE cterm=NONE

hi Visual          ctermfg=232 ctermbg=244 
hi SpecialKey      ctermfg=254 ctermbg=NONE 
hi NonText         ctermfg=254 ctermbg=NONE 
hi ExtraWhitespace             ctermbg=NONE
hi MatchParen      ctermfg=250 ctermbg=238  cterm=bold
hi Pmenu           ctermfg=254 ctermbg=233  
hi PmenuSel        ctermfg=236 ctermbg=255  
hi VertSplit       ctermfg=233 ctermbg=235 
hi ColorColumn                 ctermbg=236 
hi Underlined      ctermfg=NONE ctermbg=949494 cterm=underline term=underline gui=underline

match ExtraWhitespace /\s\+$/

hi link character	constant
hi link number	    constant
hi link boolean	    constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	    Statement
hi link Exception	Statement
hi link Include	    PreProc
hi link Define	    PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass Type
hi link Structure	Type
hi link Typedef	    Type
hi link htmlTag	    Special
hi link Tag		    Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment  Special
hi link Debug		Special

" sytnax specific

" NerdTree
hi link NERDTreeDir Special
hi NERDTreeFile     ctermfg=241
