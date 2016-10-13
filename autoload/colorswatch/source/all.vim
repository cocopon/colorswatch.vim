let s:save_cpo = &cpo
set cpo&vim


" A source that collects all highlight groups.
function! colorswatch#source#all#collect() abort
	let entries = colorswatch#hi_reader#read()
	call sort(entries, 'colorswatch#entry_sorter#by_name')
	return entries
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
