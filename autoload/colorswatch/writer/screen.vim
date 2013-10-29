let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#writer#screen#write(rows)
	let decorator = colorswatch#decorator#new()
	call decorator.init()

	let table_rows = []
	for row in a:rows
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
