" Author:  cocopon <cocopon@me.com>
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#decorator#new()
	let decorator = {}

	let decorator.dict_ = {}
	let decorator.color_id_ = 0

	function! decorator.init() dict
	endfunction

	function! decorator.register(color) dict
		if strlen(a:color) == 0
			return 0
		endif

		let color_id = get(self.dict_, a:color, -1)
		if color_id >= 0
			return color_id
		endif

		let color_id = self.color_id_
		let self.dict_[a:color] = color_id

		let group_name = s:group_name(color_id)
		execute printf('highlight %s guibg=%s guifg=%s', group_name, a:color, a:color)
		execute printf('syntax match %s /\[%03d\]/', group_name, color_id)

		let self.color_id_ += 1

		return color_id
	endfunction

	function! decorator.get_marker(color) dict
		let color_id = get(self.dict_, a:color, 0)

		return color_id == 0
					\ ? '     '
					\ : printf('[%03d]', color_id)
	endfunction

	return decorator
endfunction


function! s:group_name(color_id)
	return printf('colorSwatch%03d', a:color_id)
endfunction


let &cpo = s:save_cpo
