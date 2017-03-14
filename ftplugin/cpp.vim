" TODO: In all my plugins, change the folding markers.

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let &formatprg='astyle --style=allman'
