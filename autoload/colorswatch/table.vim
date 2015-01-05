" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


let s:methods = [
			\ 	'build',
			\ ]
let s:separator = '  '


function! colorswatch#table#new(rows) abort
	let table = {}
	let table.rows_ = a:rows

	let table.total_rows_ = len(table.rows_)
	if table.total_rows_ > 0
		let first_row = table.rows_[0]
		let table.total_cols_ = len(first_row)
	else
		let table.total_cols_ = 0
	endif

	let table.col_widths_ = []
	for col in range(table.total_cols_)
		let max_width = 0

		for row in range(table.total_rows_)
			let cell = table.rows_[row][col]
			let width = strdisplaywidth(cell)
			if max_width < width
				let max_width = width
			endif
		endfor

		call add(table.col_widths_, max_width)
	endfor

	call colorswatch#util#setup_methods(
				\ table,
				\ 'colorswatch#table',
				\ s:methods)

	return table
endfunction


function! colorswatch#table#build() abort dict
	let lines = []

	for row in range(self.total_rows_)
		let cells = []

		for col in range(self.total_cols_)
			let cell = self.rows_[row][col]
			call add(cells, s:pad(cell, self.col_widths_[col]))
		endfor

		let line = s:rtrim(join(cells, s:separator))
		call add(lines, line)
	endfor

	return lines
endfunction


function! s:pad(cell, width) abort
	let pad_width = a:width - strdisplaywidth(a:cell)
	if pad_width <= 0
		return a:cell
	endif

	return a:cell . repeat(' ', pad_width)
endfunction


function! s:rtrim(str) abort
	let matches = matchlist(a:str, '^\(.\{-}\)\s*$')
	return get(matches, 1, a:str)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
