let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#formatter#json#format(entries) abort
	let bg_attr_name = colorswatch#util#bg_attr_name()
	let fg_attr_name = colorswatch#util#fg_attr_name()

	let entryset = colorswatch#entryset#new(a:entries)
	let entry_jsons = []

	for name in entryset.all_names()
		let entry_json = printf('"%s":', name)

		let entry_json .= '['

		let bg_attr = entryset.get_attr(name, bg_attr_name)
		let entry_json .= printf('"%s",', bg_attr)
		let fg_attr = entryset.get_attr(name, fg_attr_name)
		let entry_json .= printf('"%s"', fg_attr)
		let entry_json .= ']'

		call add(entry_jsons, entry_json)
	endfor

	return printf('{%s}', join(entry_jsons, ','))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
