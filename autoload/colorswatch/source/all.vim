let s:save_cpo = &cpo
set cpo&vim


" A source that collects all highlight groups.
function! colorswatch#source#all#collect()
	let entries = colorswatch#reader#read()
	call sort(entries, 'colorswatch#sorter#by_name')
	return entries
endfunction


let &cpo = s:save_cpo
