" cheat.vim
"
" Vim wrapper for cheat (http://cheat.errtheblog.com) utility.
" Feedback is more than welcome :-)
"
" Last Change:  Sat Sep 15 23:01:14 EEST 2007
" Maintainer:   Alexandru Ungur <alexandru@globalterrasoft.ro>
" License:      This file is placed in the public domain.
" Version:      1.1

if exists('loaded_cheats')
    echo "cheat.vim already loaded! won't reload."
    finish
endif

" Set the path to the cheat sheets cache file, can be overriden from
" .vimrc with:
"               let g:cheats_cache = "/path/to/your/cache/file"
let s:cheats_cache = exists('g:cheats_cache') ? g:cheats_cache : $HOME . '/.cheats'

" Get/Create the cheat sheets list
if !filereadable(s:cheats_cache)
    echo "Cheat: cheats cache file `" s:cheats_cache "'not found. Creating it..."
    execute system("ruby -e 'print IO.popen(\"cheat sheets\") { |io| io.readlines[1..-1].map{|line| line.strip}.join(\"\n\") }' > " . s:cheats_cache)
endif
let s:cheat_sheets = join(readfile(s:cheats_cache), "\n")

" Func Defs
func! CheatCompletion(ArgLead, CmdLine, CursorPos)
    return s:cheat_sheets
endf

func! Cheat(c)
    let l:c = strlen(a:c) ? a:c : input("Cheat Sheet: ", "", "custom,CheatCompletion")
    execute '!cheat ' l:c
endf

func! CheatCurrent()
    call Cheat(expand("<cword>"))
endf
  
" Commands Mappings
command! -nargs=1 -complete=custom,CheatCompletion Cheat :call Cheat(<q-args>)
command! CheatCurrent :call CheatCurrent()
nmap <leader>C  :call Cheat("")<CR>

" Ask for cheatsheet for the word under cursor
nmap <leader>ch :call CheatCurrent()<CR>
vmap <leader>ch <ESC>:call CheatCurrent()<CR>
