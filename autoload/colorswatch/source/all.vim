let s:save_cpo = &cpo
set cpo&vim


" A source that collects all highlight groups.
function! colorswatch#source#all#collect()
	let reader = colorswatch#reader#new()
	call reader.read()
	return reader.get_entryset()
endfunction


let &cpo = s:save_cpo
