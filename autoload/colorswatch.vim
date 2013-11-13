" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate(...)
	call s:prepare_buffer()

	let formatter = get(a:000, 0, 'screen')
	call append(0, colorswatch#format(formatter))

	call s:finish_buffer()
endfunction


function! colorswatch#format(formatter)
	let func_name = printf('colorswatch#formatter#%s#format', a:formatter)
	let entryset = s:read_entryset()
	return function(func_name)(entryset)
endfunction


function! s:read_entryset()
	let reader = colorswatch#reader#new()
	call reader.read()
	return reader.get_entryset()
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
