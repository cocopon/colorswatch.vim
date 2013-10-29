let s:save_cpo = &cpo
set cpo&vim


" Generate [name, guibg, guifg], sorted by name
function! colorswatch#generator#standard(entryset)
	let original_entries = a:entryset.get_original_entries()

	let names = keys(original_entries)
	call colorswatch#sorter#text(names)

	let rows = []

	for name in names
		let row = []

		let attrs = a:entryset.get_attrs(name)
		call add(row, colorswatch#cell#text(name))
		call add(row, colorswatch#cell#color(get(attrs, 'guibg', '')))
		call add(row, colorswatch#cell#color(get(attrs, 'guifg', '')))

		call add(rows, row)
	endfor

	return rows
endfunction



let &cpo = s:save_cpo
