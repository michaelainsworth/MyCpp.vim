" TODO: In all my plugins, change the folding markers.

" Plugin setup {{{ ============================================================
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1
" ========================================================================= }}}

" Functions {{{ ===============================================================
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
" ========================================================================= }}}

" Options {{{ =================================================================
" Use c-style indenting
setlocal cindent
" ========================================================================= }}}

" Mappings {{{ ================================================================
" Normal-mode key bindings
" TODO: Change the below so that it's a movement!
nnoremap <buffer> <localleader>c I// <esc> 

" TODO: This will interfere with the global grep which I want
" to implement from steve losh.
nnoremap <buffer> <localleader>g :call CppIncludeGuard()<cr>
" ========================================================================= }}}

" Abbreviations {{{ ===========================================================
iabbrev <buffer> todo // TODO:

" iff => if block
iabbrev <buffer> iff 
	\if ()
	\{
	\}
	\<esc>?(<cr>

" ife => if/else blocks
iabbrev <buffer> ife 
	\if ()                                                                              
	\{                                                                                  
	\}                                                                                  
	\else                                                                               
	\{                                                                                  
	\}
	\<esc>?(<cr>

" whl => while block
iabbrev <buffer> whl 
	\while (true)
	\{
	\}
	\<esc>?(<cr>

" fri => for block
iabbrev <buffer> fri 
    \for (std::size_t i = 0, s = 0; i < s; ++i)
    \{
    \}
	\<esc>?(<cr>

" fra => for block (auto)
iabbrev <buffer> fora 
	\for (auto& item : collection)
	\{
	\}
	\<esc>?(<cr>

" mainn => main function
iabbrev <buffer> mainn 
	\#include <iostream>
	\using std::cin;
	\using std::cout;
	\using std::cerr;
	\using std::endl;
	\
	\int main(int argc, const char**argv)
	\{
	\    return EXIT_SUCCESS;
	\}
	\<esc>?return

" cls => class definition
iabbrev <buffer> cls 
    \<esc>set paste<cr>
	\// TODO: Document this class.
	\class MyClass
	\{
	\public:
	\
	\    // Lifecycle
	\    MyClass();
	\    // TODO: Make non-virtual if required!
	\    virtual ~MyClass() = 0;
	\
	\    // Noncopyable
	\    MyClass(const MyClass& that) = delete;
	\    MyClass(MyClass&& that) = delete;
	\    MyClass& operator =(const MyClass& that) = delete;
	\    MyClass& operator =(MyClass&& that) = delete;
	\
	\    // Accessors
	\    // TODO: Add accessors here!
	\
	\    // Mutators
	\    // TODO: Add mutators here!
	\
	\private:
	\
	\    // Helpers
	\    // TODO: Add helpers here!
	\
	\    // Variables
	\    // TODO: Add variables here!
	\
	\};
    \<esc>set nopaste<cr>
    \?s MyClass<cr>l
" ========================================================================= }}} 

" Abbreviations {{{ ===========================================================
let &formatprg='astyle --style=allman'
" ========================================================================= }}} 
