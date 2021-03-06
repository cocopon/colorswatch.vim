let s:save_cpo = &cpo
set cpo&vim


let s:methods = [
			\ 	'get_attrs',
			\ 	'get_link',
			\ 	'get_name',
			\ 	'has_link',
			\ 	'is_cleared',
			\ 	'set_attrs',
			\ 	'set_cleared',
			\ 	'set_cleared',
			\ 	'set_link',
			\ ]


function! colorswatch#entry#new(name) abort
	let entry = {}
	let entry.name_ = a:name
	let entry.link_ = ''
	let entry.cleared_ = 0
	let entry.attrs_ = {}

	call colorswatch#util#setup_methods(
				\ entry,
				\ 'colorswatch#entry',
				\ s:methods)

	return entry
endfunction


function! colorswatch#entry#get_name() abort dict
	return self.name_
endfunction


function! colorswatch#entry#get_link() abort dict
	return self.link_
endfunction


function! colorswatch#entry#set_link(name) abort dict
	let self.link_ = a:name
endfunction


function! colorswatch#entry#has_link() abort dict
	return strlen(self.get_link()) > 0
endfunction


function! colorswatch#entry#is_cleared() abort dict
	return self.cleared_
endfunction


function! colorswatch#entry#set_cleared(cleared) abort dict
	let self.cleared_ = a:cleared
endfunction


function! colorswatch#entry#get_attrs() abort dict
	return self.attrs_
endfunction


function! colorswatch#entry#set_attrs(attrs) abort dict
	let self.attrs_ = a:attrs
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
