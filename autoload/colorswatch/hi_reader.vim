" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#hi_reader#read() abort
	redir => data
	silent highlight
	redir END

	return s:parse_entries(data)
endfunction


function! s:parse_entries(data) abort
	let lines = split(a:data, '\n')

	let entries = []
	let entry_dict = {}

	let total_lines = len(lines)
	let line = ''
	let i = 0

	while i < total_lines
		let line .= lines[i]

		if i + 1 < total_lines
			let next_line = lines[i + 1]

			if match(next_line, '^\s') >= 0
				" Join wrapped line
				let i += 1
				continue
			endif
		endif

		let entry = s:parse_entry(line)
		if s:is_allowed(entry)
			call add(entries, entry)
		endif

		let i += 1
		let line = ''
	endwhile

	return entries
endfunction


function! s:parse_entry(line) abort
	" Name xxx key=value key=value ...
	" Name xxx links to AnotherName
	" Name xxx cleared

	let comps = split(a:line)
	let name = comps[0]

	let entry = colorswatch#entry#new(name)

	let comps2 = comps[2]
	if comps2 ==? 'links'
		let target_name = comps[4]
		call entry.set_link(target_name)
	elseif comps2 ==? 'cleared'
		call entry.set_cleared(1)
	else
		let attrs = copy(comps)
		call remove(attrs, 0, 1)
		call entry.set_attrs(s:parse_attrs(attrs))
	endif

	return entry
endfunction


function! s:parse_attrs(attrs) abort
	let result = {}

	for attr in a:attrs
		let pair = split(attr, '=')

		if len(pair) == 2
			let result[pair[0]] = pair[1]
		endif
	endfor

	return result
endfunction


function! s:is_allowed(entry) abort
	if !exists('g:colorswatch_exclusion_pattern')
		return 1
	endif

	return match(a:entry.get_name(), g:colorswatch_exclusion_pattern) < 0
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
