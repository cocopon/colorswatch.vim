" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate(...)
	let entryset = s:read_entryset()

	call s:prepare_buffer()

	let writer = get(a:000, 0, 'screen')
	execute printf('call colorswatch#writer#%s#write(entryset)', writer)

	call s:finish_buffer()
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
