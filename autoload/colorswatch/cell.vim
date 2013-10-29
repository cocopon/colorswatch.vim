let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#cell#text(text)
	return {'text': a:text}
endfunction


function! colorswatch#cell#color(color)
	return {'color': a:color}
endfunction


let &cpo = s:save_cpo
