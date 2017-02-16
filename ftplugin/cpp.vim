" Plugin setup {{{
" =============================================================================
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1
" =============================================================================
" }}}

" Functions {{{
" =============================================================================
function! CppIncludeGuard()
    let l:line = line('.') + 3
    let l:col = col('.')
    let l:filename = substitute(toupper(expand('%:t')), '[^A-Z0-9_]', '_', 'g')
    normal gg
    put! ='#ifndef ' . l:filename
    put ='#define ' . l:filename
    normal o
    normal G
    put ='#endif // ' . l:filename
    call cursor(l:line, l:col)
endfunction
" =============================================================================
" }}}

" Options {{{
" =============================================================================

" Use c-style indenting
setlocal cindent

" Normal-mode key bindings
" TODO: Change the below so that it's a movement!
nnoremap <buffer> <localleader>c I// <esc> 

" TODO: This will interfere with the global grep which I want
" to implement from steve losh.
nnoremap <buffer> <localleader>g :call CppIncludeGuard()<cr>

" Abbreviations
" TODO: This isn't working!
iabbrev <buffer> todo // TODO:
iabbrev <buffer> iff if ()<cr>{<cr>}<esc>?(<cr>
iabbrev <buffer> ife if ()<cr>{<cr>}<cr>else<cr>{<cr>}<esc>?(<cr>
iabbrev <buffer> whilee while ()<cr>{<cr>}<esc>?(<cr>
iabbrev <buffer> forr for (;;)<cr>{<cr>}<esc>?(<cr>
iabbrev <buffer> fora for (auto& value : collection)<cr>{<cr>}<esc>?(<cr>
iabbrev <buffer> mainn #include <iostream><cr>using std::cin;<cr>using std::cout;<cr>using std::cerr;<cr>using std::endl;<cr><cr>int main(int argc, const char**argv)<cr>{<cr>return EXIT_SUCCESS;<cr>}<esc>?return<cr>

iabbrev <buffer> cls
    \ <esc>:set paste<cr>i
    \ class MyClass<cr>
    \ {<cr>
    \ public:<cr>
    \ <cr>
    \     // Lifecycle<cr>
    \     MyClass();<cr>
    \     // TODO: Make non-virtual if required!<cr>
    \     virtual ~MyClass() = 0;<cr>
    \     <cr>
    \     // Noncopyable<cr>
    \     MyClass(const MyClass& that) = delete;<cr>
    \     MyClass(MyClass&& that) = delete;<cr>
    \     MyClass& operator =(const MyClass& that) = delete;<cr>
    \     MyClass& operator =(MyClass&& that) = delete;<cr>
    \ <cr>
    \     // Accessors<cr>
    \     // TODO: Add accessors here!<cr>
    \ <cr>
    \     // Mutators<cr>
    \     // TODO: Add mutators here!<cr>
    \ <cr>
    \ private:<cr>
    \ <cr>
    \     // Helpers<cr>
    \     // TODO: Add helpers here!<cr>
    \ <cr>
    \     // Variables<cr>
    \     // TODO: Add variables here!<cr>
    \ <cr>
    \ };<cr>
    \ <esc>:set nopaste<cr>
    \ ?^ class<cr>k<esc>

augroup END


