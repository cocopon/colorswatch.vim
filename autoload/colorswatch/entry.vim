" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function colorswatch#entry#new(name)
	let entry = {}

	let entry.name_ = a:name
	let entry.link_ = ''
	let entry.cleared_ = 0
	let entry.attrs_ = {}

	function! entry.get_name() dict
		return self.name_
	endfunction

	function! entry.get_link() dict
		return self.link_
	endfunction

	function! entry.set_link(name) dict
		let self.link_ = a:name
	endfunction

  function! entry.has_link() dict
    return strlen(self.get_link()) > 0
  endfunction

	function! entry.is_cleared() dict
		return self.cleared_
	endfunction

	function! entry.set_cleared(cleared) dict
		let self.cleared_ = a:cleared
	endfunction

	function! entry.get_attrs() dict
		return self.attrs_
	endfunction

	function! entry.set_attrs(attrs) dict
		let self.attrs_ = a:attrs
	endfunction

	return entry
endfunction


let &cpo = s:save_cpo
