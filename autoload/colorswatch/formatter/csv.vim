" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#csv#format(entryset)
	let bg_attr_name = colorswatch#util#bg_attr_name()
	let fg_attr_name = colorswatch#util#fg_attr_name()
	let rows = []

	let names = a:entryset.get_all_names()
	for name in names
		let row = []

		call add(row, name)

		let attrs = a:entryset.get_attrs(name)
		call add(row, get(attrs, bg_attr_name, ''))
		call add(row, get(attrs, fg_attr_name, ''))

		call add(rows, join(map(row, '"\"" . v:val . "\""'), ','))
	endfor

	return rows
endfunction


let &cpo = s:save_cpo
