" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#sorter#sort_by_name(rows)
	call sort(a:rows, 's:compare_by_name')
endfunction


function! s:compare_by_name(row1, row2)
	return char2nr(a:row1.name) - char2nr(a:row2.name)
endfunction


let &cpo = s:save_cpo
