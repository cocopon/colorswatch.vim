let s:save_cpo = &cpo
set cpo&vim


" A source that collects original (not a link) highlight groups.
function! colorswatch#source#original#collect()
	let reader = colorswatch#reader#new()
	call reader.read()

	let entries = reader.get_entryset().entries()
	let original_entries = copy(entries)
	call filter(original_entries, '!v:val.has_link()')

	return colorswatch#entryset#new(original_entries)
endfunction


let &cpo = s:save_cpo
