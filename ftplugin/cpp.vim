" TODO: In all my plugins, change the folding markers.

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") && b:did_ftplugin == 1
  finish
endif

let b:did_ftplugin = 1

setlocal formatprg=astyle\ --style=allman\ --max-code-length=80
let g:load_doxygen_syntax=1

let &suffixesadd='.hpp,.cpp'

highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.*/

setlocal textwidth=80

function! s:CppImplementation()
    s/^\s\+//ge
    s/virtual //ge
    s/ = 0;/;/ge
    normal 0yl

    if @@ ==# "~"
        normal l
    endif

    normal yt(0Pa::$
    normal yl
    if @@ !=# ';'
        normal F;
    endif

    normal C{}
endfunction

nnoremap <leader>m :call <SID>CppImplementation()<cr>O

function! s:CppFixFunctionLength()
    let l:line = getline('.')
    let l:parts = split(l:line, '(')

    if len(l:parts) <= 1
        return
    endif

    normal 0f(i
    normal 0f(a

    while 1
        let l:line = getline('.')
        let l:parts = split(l:line, ',')

        if len(l:parts) > 1
            normal 0f,li
        else
            let l:line = getline('.')
            let l:parts = split(l:line, ')')

            if len(l:parts) <= 1
                return
            else
                normal 0f)i
                return
            endif
        endif
    endwhile
endfunction
command! CppFixFunctionLength :call <SID>CppFixFunctionLength()

nmap gqgq gggqG
