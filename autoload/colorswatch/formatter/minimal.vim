let s:save_cpo = &cpo
set cpo&vim


let s:width = 3


function! colorswatch#formatter#minimal#format(entries)
	let bg_attr_name = colorswatch#util#bg_attr_name()
	let fg_attr_name = colorswatch#util#fg_attr_name()

	let entryset = colorswatch#entryset#new(a:entries)
	let colors = []
	for name in entryset.all_names()
		let attrs = entryset.get_attrs(name)

		let color = get(attrs, bg_attr_name, '')
		if !empty(color)
			call add(colors, color)
		endif

		let color = get(attrs, fg_attr_name, '')
		if !empty(color)
			call add(colors, color)
		endif
	endfor

	" TODO: Sort by hue

	return s:build_table(colors)
endfunction


function! s:build_table(colors)
	let decorator = colorswatch#decorator#new()

	let rows = []
	let row = []
	let col = 0

	for color in a:colors
		if empty(color)
			call extend(row, ['', ''])
		else
			call decorator.register(color)
			let marker = decorator.get_marker(color)
			call add(row, marker)
			call add(row, color)
		endif

		let col += 1
		if col >= s:width
			call add(rows, row)
			let row = []
			let col = 0
		endif
	endfor

	if !empty(row)
		call extend(row, repeat(['', ''], s:width - col))
		call add(rows, row)
	endif

	let table = colorswatch#table#new(rows)
	return table.build()
endfunction


let &cpo = s:save_cpo
