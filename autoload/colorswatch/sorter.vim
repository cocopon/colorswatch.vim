" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#sorter#text(texts)
	call sort(a:texts, 's:compare_by_text')
endfunction


function! s:compare_by_text(text1, text2)
	return char2nr(a:text1) - char2nr(a:text2)
endfunction


let &cpo = s:save_cpo
