let s:save_cpo = &cpo
set cpo&vim


" Write [name, guibg, guifg], sorted by name
function! colorswatch#writer#screen#write(entryset)
	let original_entries = a:entryset.get_original_entries()

	let names = keys(original_entries)
	call colorswatch#sorter#text(names)

	let data = []

	for name in names
		let row = []

		let attrs = a:entryset.get_attrs(name)
		call add(row, colorswatch#cell#text(name))
		call add(row, colorswatch#cell#color(get(attrs, 'guibg', '')))
		call add(row, colorswatch#cell#color(get(attrs, 'guifg', '')))

		call add(data, row)
	endfor

	call s:write(data)
endfunction


" Write set of colors, sorted by hue
function! colorswatch#writer#screen#write_unique(entryset)
	let original_entries = a:entryset.get_original_entries()

	let names = keys(original_entries)
	let colors = {}
	for name in names
		let attrs = a:entryset.get_attrs(name)

		let value = get(attrs, 'guibg', '')
		if len(value) > 0
			let colors[value] = 1
		endif

		let value = get(attrs, 'guifg', '')
		if len(value) > 0
			let colors[value] = 1
		endif
	endfor

	" TODO: Sort colors by hue

	let data = []
	for color in keys(colors)
		let cell = colorswatch#cell#color(color)
		call add(data, [cell])
	endfor

	call s:write(data)
endfunction


function! s:write(data)
	let decorator = colorswatch#decorator#new()
	call decorator.init()

	let table_rows = []
	for row in a:data
		let table_row = []

		for cell in row
			if exists('cell.text')
				call add(table_row, cell.text)
			elseif exists('cell.color')
				call decorator.register(cell.color)
				let marker = decorator.get_marker(cell.color)
				call add(table_row, marker)
				call add(table_row, cell.color)
			else
				throw 'Invalid cell: ' . string(cell)
			endif
		endfor

		call add(table_rows, table_row)
	endfor
	let table = colorswatch#table#new(table_rows)

	call append(0, table.build())
endfunction


let &cpo = s:save_cpo
