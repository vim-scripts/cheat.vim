" cheat.vim
"
" Vim wrapper for cheat (http://cheat.errtheblog.com) utility.
" Feedback is more than welcome :-)
"
" Last Change:  Sat Sep  8 20:44:46 EEST 2007
" Maintainer:   Alexandru Ungur <alexandru@globalterrasoft.ro>
" License:      This file is placed in the public domain.
" Version:      1.0

if exists('loaded_cheats')
    echo "cheat.vim already loaded! won't reload."
    finish
endif

" Get the cheat sheets list
let s:cheat_sheets = system("cheat sheets|cut -b3-|grep -v 'Cheat Sheet'")

func! CheatCompletion(ArgLead, CmdLine, CursorPos)
    return s:cheat_sheets
endf

func! Cheat(c)
    execute '!cheat ' a:c
endf

func! CheatCurrent()
    call Cheat(expand("<cword>"))
endf
  
command! -nargs=1 -complete=custom,CheatCompletion Cheat :call Cheat(<q-args>)
command! CheatCurrent :call CheatCurrent()
nmap <leader>ch :call CheatCurrent()<CR>
vmap <leader>ch <ESC>:call CheatCurrent()<CR>
