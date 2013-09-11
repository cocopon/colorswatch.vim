" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#generate()
	let loader = colorswatch#loader#new()
	call loader.load()

	let entryset = loader.get_entryset()
	let rows = s:generate_rows(entryset)
	call colorswatch#sorter#sort_by_name(rows)

	let needs_new_buffer =
				\ &modified
				\ || line('$') != 1
				\ || getline(1) != ''
	if needs_new_buffer
		new
	endif

	call s:print(rows)

	set nomodified
	setlocal nocursorline
	normal! gg
endfunction


function! s:generate_rows(entryset)
	let original_entries = a:entryset.get_all_original_names()

	let rows = []
	let i = 0
	for name in keys(original_entries)
		let row = {}
		let row.name = name

		let attrs = a:entryset.get_attrs(name)
		let row.bg = get(attrs, 'guibg', '')
		let row.fg = get(attrs, 'guifg', '')
		call add(rows, row)

		let i += 1
	endfor

	return rows
endfunction


function! s:print(rows)
	let decorator = colorswatch#decorator#new()
	call decorator.init()

	let table_rows = []
	for row in a:rows
		let table_row = []
		call add(table_row, row.name)

		call decorator.register(row.bg)
		let marker = decorator.get_marker(row.bg)
		call add(table_row, marker)
		call add(table_row, row.bg)

		call decorator.register(row.fg)
		let marker = decorator.get_marker(row.fg)
		call add(table_row, marker)
		call add(table_row, row.fg)

		call add(table_rows, table_row)
	endfor
	let table = colorswatch#table#new(table_rows)

	call append(0, table.build())
endfunction


let &cpo = s:save_cpo
