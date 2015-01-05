" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#default#format(entries) abort
	let bg_attr_name = colorswatch#util#bg_attr_name()
	let fg_attr_name = colorswatch#util#fg_attr_name()

	let entryset = colorswatch#entryset#new(a:entries)
	let data = []

	for name in entryset.all_names()
		let row = []

		let attrs = entryset.get_attrs(name)
		call add(row, colorswatch#cell#text(name))
		call add(row, colorswatch#cell#color(get(attrs, bg_attr_name, '')))
		call add(row, colorswatch#cell#color(get(attrs, fg_attr_name, '')))

		call add(data, row)
	endfor

	return s:format(data)
endfunction


function! s:format(data) abort
	let decorator = colorswatch#decorator#new()

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

	return table.build()
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
