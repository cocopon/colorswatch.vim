let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#cell#text(text) abort
	return {'text': a:text}
endfunction


function! colorswatch#cell#color(color) abort
	return {'color': a:color}
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
