" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate(...)
	call s:prepare_buffer()

	let source_name = get(a:000, 0, 'all')
	let entries = colorswatch#source(source_name)

	let formatter_name = get(a:000, 1, 'screen')
	let lines = colorswatch#format(entries, formatter_name)
	call append(0, lines)

	call s:finish_buffer()
endfunction


function! colorswatch#source(source_name)
	try
		let func_name = printf('colorswatch#source#%s#collect',
					\ a:source_name)
		let result = function(func_name)()
		return result
	catch /:E117:/
		" E117: Unknown function
		echoerr printf('Source not found: %s',
					\ a:source_name)
	endtry
endfunction


function! colorswatch#format(entries, formatter_name)
	try
		let func_name = printf('colorswatch#formatter#%s#format',
					\ a:formatter_name)
		let result = function(func_name)(a:entries)
		return result
	catch /:E117:/
		" E117: Unknown function
		echoerr printf('Formatter not found: %s',
					\ a:formatter_name)
	endtry
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
