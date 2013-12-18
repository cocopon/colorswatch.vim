" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


let s:methods = [
			\ 	'get_all_names',
			\ 	'get_attrs',
			\ ]


function! colorswatch#entryset#new(entries)
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


function! colorswatch#entryset#get_all_names() dict
	return keys(self.dict_)
endfunction


function! colorswatch#entryset#get_attrs(name, ...) dict
	let entry = get(self.dict_, a:name, {})
	if empty(entry)
		return entry
	endif

	if !entry.has_link()
		return entry.get_attrs()
	endif

	let history = (a:0 == 1) ? a:1 : []
	if index(history, a:name) >= 0
		echoerr 'Circular reference detected'
		return {}
	endif
	call add(history, a:name)

	return self.get_attrs(entry.get_link(), history)
endfunction


let &cpo = s:save_cpo
