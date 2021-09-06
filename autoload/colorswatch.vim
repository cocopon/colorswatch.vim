let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate(...) abort
	call s:prepare_buffer()

	let source_name = get(a:000, 0, 'all')
	let entries = colorswatch#source(source_name)

	let formatter_name = get(a:000, 1, 'default')
	let lines = colorswatch#format(entries, formatter_name)
	call append(0, lines)
	normal! Gdd

	call s:finish_buffer()
endfunction


function! colorswatch#generate_complete(arglead, cmdline, cursorpos) abort
	let args = split(substitute(a:cmdline[: a:cursorpos - len(a:arglead) - 1],
				\ '\C^.\{-}C\%[olorSwatchGenerate]!\?', '', ''))
	let n = len(args)
	if n == 0
		let candidates = ['all', 'original', 'cterm']
	elseif n == 1
		let candidates = ['default', 'minimal', 'csv', 'css', 'json']
	else
		let candidates = []
	endif
	return join(candidates, "\n")
endfunction


function! colorswatch#source(source_name) abort
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


function! colorswatch#format(entries, formatter_name) abort
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


function! s:prepare_buffer() abort
	let needs_new_buffer =
				\ &modified
				\ || line('$') != 1
				\ || getline(1) !=? ''
	if needs_new_buffer
		new
	endif
endfunction


function! s:finish_buffer() abort
	set nomodified
	setlocal nocursorline
	normal! gg
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
