let s:save_cpo = &cpo
set cpo&vim


" A source that collects all cterm colors.
function! colorswatch#source#cterm#collect()
	if has('gui_running') || &t_Co < 256
		echoerr 'Not available in this version'
	endif

	let entries = []
	let i = 0
	while i < 256
		let name = printf('#%03d', i)
		let entry = colorswatch#entry#new(name)
		call entry.set_attrs({'ctermbg': i})
		call add(entries, entry)
		let i += 1
	endwhile

	return entries
endfunction


let &cpo = s:save_cpo
