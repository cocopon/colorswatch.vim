let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#writer#csv#write(entryset)
	let rows = []

	let names = a:entryset.get_all_names()
	for name in names
		let row = []

		call add(row, name)

		let attrs = a:entryset.get_attrs(name)
		call add(row, get(attrs, 'guibg', ''))
		call add(row, get(attrs, 'guifg', ''))

		call add(rows, join(map(row, '"\"" . v:val . "\""'), ','))
	endfor

	call append(0, rows)
endfunction


function! s:color(color)
	" TODO: Convert named color (see `:help gui-colors`)
	return a:color
endfunction


let &cpo = s:save_cpo
