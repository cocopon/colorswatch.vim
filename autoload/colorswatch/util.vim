" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#util#bg_attr_name()
	return has('gui') ? 'guibg' : 'ctermbg'
endfunction


function! colorswatch#util#fg_attr_name()
	return has('gui') ? 'guifg' : 'ctermfg'
endfunction


let &cpo = s:save_cpo
