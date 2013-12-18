" Author:  cocopon <cocopon@me.com>
" License: MIT License


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


function colorswatch#entry#new(name)
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


function! colorswatch#entry#get_name() dict
	return self.name_
endfunction


function! colorswatch#entry#get_link() dict
	return self.link_
endfunction


function! colorswatch#entry#set_link(name) dict
	let self.link_ = a:name
endfunction


function! colorswatch#entry#has_link() dict
	return strlen(self.get_link()) > 0
endfunction


function! colorswatch#entry#is_cleared() dict
	return self.cleared_
endfunction


function! colorswatch#entry#set_cleared(cleared) dict
	let self.cleared_ = a:cleared
endfunction


function! colorswatch#entry#get_attrs() dict
	return self.attrs_
endfunction


function! colorswatch#entry#set_attrs(attrs) dict
	let self.attrs_ = a:attrs
endfunction


let &cpo = s:save_cpo
