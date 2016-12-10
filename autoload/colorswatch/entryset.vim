" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


let s:methods = [
			\ 	'all_names',
			\ 	'entries',
			\ 	'find_entry',
			\ 	'get_attrs',
			\ 	'get_attr',
			\ ]


function! colorswatch#entryset#new(entries) abort
	let entryset = {}
	let entryset.entries_ = a:entries

	let dict = {}
	for entry in a:entries
		let name = entry.get_name()
		let dict[name] = entry
	endfor
	let entryset.dict_ = dict

	call colorswatch#util#setup_methods(
				\ entryset,
				\ 'colorswatch#entryset',
				\ s:methods)

	return entryset
endfunction


function! colorswatch#entryset#find_entry(name) abort dict
	return get(self.dict_, a:name)
endfunction


function! colorswatch#entryset#entries() abort dict
	return self.entries_
endfunction


function! colorswatch#entryset#all_names() abort dict
	return map(copy(self.entries_), 'v:val.get_name()')
endfunction


function! colorswatch#entryset#get_attrs(name, ...) abort dict
	let entry = get(self.dict_, a:name, {})
	if empty(entry)
		return entry
	endif

	if !entry.has_link()
		return entry.get_attrs()
	endif

	" Avoid infinite loop caused by circular reference
	let history = (a:0 == 1) ? a:1 : []
	if index(history, a:name) >= 0
		echoerr 'Circular reference detected'
		return {}
	endif
	call add(history, a:name)

	let my_attrs = entry.get_attrs()
	let linked_attrs = self.get_attrs(entry.get_link(), history)
	return extend(my_attrs, linked_attrs, 'force')
endfunction


function! colorswatch#entryset#get_attr(name, attr_name) abort dict
	let attrs = self.get_attrs(a:name)
	let attr = get(attrs, a:attr_name, '')
	return attr
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
