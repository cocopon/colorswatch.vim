" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#sorter#by_name(entry1, entry2)
	return (a:entry1.get_name() >= a:entry2.get_name()) * 2 - 1
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
