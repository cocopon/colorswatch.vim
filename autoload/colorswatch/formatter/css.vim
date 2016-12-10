" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#css#format(entries) abort
	let entryset = colorswatch#entryset#new(a:entries)
	let lines = []
	for name in entryset.all_names()
		let decls = []

		let bg_attr = entryset.get_attr(name, 'guibg')
		if !empty(bg_attr)
			call add(decls, printf('background-color:%s;', bg_attr))
		endif

		let fg_attr = entryset.get_attr(name, 'guifg')
		if !empty(fg_attr)
			 call add(decls, printf('color:%s;', fg_attr))
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
