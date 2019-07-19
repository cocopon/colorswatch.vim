let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#csv#format(entries) abort
	let bg_attr_name = colorswatch#util#bg_attr_name()
	let fg_attr_name = colorswatch#util#fg_attr_name()

	let entryset = colorswatch#entryset#new(a:entries)
	let rows = []

	for name in entryset.all_names()
		let row = []

		call add(row, name)

		let bg_attr = entryset.get_attr(name, bg_attr_name)
		call add(row, bg_attr)
		let fg_attr = entryset.get_attr(name, fg_attr_name)
		call add(row, fg_attr)

		call add(rows, join(map(row, '"\"" . v:val . "\""'), ','))
	endfor

	return rows
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
