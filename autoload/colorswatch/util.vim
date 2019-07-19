let s:save_cpo = &cpo
set cpo&vim


function! s:is_gui_enabled() abort
	return has('gui')
				\ || (has('termguicolors') && &termguicolors)
endfunction


function! colorswatch#util#bg_attr_name() abort
	return s:is_gui_enabled() ? 'guibg' : 'ctermbg'
endfunction


function! colorswatch#util#fg_attr_name() abort
	return s:is_gui_enabled() ? 'guifg' : 'ctermfg'
endfunction


function! colorswatch#util#setup_methods(instance, namespace, methods) abort
	for method in a:methods
		let a:instance[method] = function(join([a:namespace, method], '#'))
	endfor
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
