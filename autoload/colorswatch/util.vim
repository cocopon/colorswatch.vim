" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#util#bg_attr_name() abort
	return has('gui') ? 'guibg' : 'ctermbg'
endfunction


function! colorswatch#util#fg_attr_name() abort
	return has('gui') ? 'guifg' : 'ctermfg'
endfunction


function! colorswatch#util#setup_methods(instance, namespace, methods) abort
	for method in a:methods
		let a:instance[method] = function(join([a:namespace, method], '#'))
	endfor
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
