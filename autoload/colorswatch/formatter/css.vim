" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#css#format(entries) abort
	let entryset = colorswatch#entryset#new(a:entries)
	let lines = []
	for name in entryset.all_names()
		let attrs = entryset.get_attrs(name)
		let decls = []

		let bg = get(attrs, 'guibg', '')
		if !empty(bg)
			call add(decls, printf('background-color:%s;', bg))
		endif

		let fg = get(attrs, 'guifg', '')
		if !empty(fg)
			 call add(decls, printf('color:%s;', fg))
		endif

		if empty(decls)
			continue
		endif

		let line = printf('.%s{%s}',
					\ name,
					\ join(decls, ''))
		call add(lines, line)
	endfor

	return lines
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
