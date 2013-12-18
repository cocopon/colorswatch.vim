" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate(...)
	call s:prepare_buffer()

	let source_name = get(a:000, 0, 'all')
	let entryset = colorswatch#source(source_name)

	let formatter_name = get(a:000, 1, 'screen')
	let lines = colorswatch#format(entryset, formatter_name)
	call append(0, lines)

	call s:finish_buffer()
endfunction


function! colorswatch#source(source_name)
	let func_name = printf('colorswatch#source#%s#collect',
				\ a:source_name)
	return function(func_name)()
endfunction


function! colorswatch#format(entryset, formatter_name)
	let func_name = printf('colorswatch#formatter#%s#format',
				\ a:formatter_name)
	return function(func_name)(a:entryset)
endfunction


function! s:prepare_buffer()
	let needs_new_buffer =
				\ &modified
				\ || line('$') != 1
				\ || getline(1) != ''
	if needs_new_buffer
		new
	endif
endfunction


function! s:finish_buffer()
	set nomodified
	setlocal nocursorline
	normal! gg
endfunction


let &cpo = s:save_cpo
