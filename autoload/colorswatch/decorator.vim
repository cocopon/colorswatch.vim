let s:save_cpo = &cpo
set cpo&vim


let s:methods = [
			\ 	'get_marker',
			\ 	'register',
			\ ]


function! colorswatch#decorator#new() abort
	let decorator = {}
	let decorator.dict_ = {}
	let decorator.color_id_ = 0

	call colorswatch#util#setup_methods(
				\ decorator,
				\ 'colorswatch#decorator',
				\ s:methods)

	return decorator
endfunction


function! colorswatch#decorator#register(color) abort dict
	if strlen(a:color) == 0
		return -1
	endif

	let color_id = get(self.dict_, a:color, -1)
	if color_id >= 0
		return color_id
	endif

	let color_id = self.color_id_
	let self.dict_[a:color] = color_id

	let group_name = s:group_name(color_id)
	execute printf('highlight %s %s=%s %s=%s',
				\ group_name,
				\ colorswatch#util#bg_attr_name(),
				\ a:color,
				\ colorswatch#util#fg_attr_name(),
				\ a:color)
	execute printf('syntax match %s /\[%03d\]/', group_name, color_id)

	let self.color_id_ += 1

	return color_id
endfunction


function! colorswatch#decorator#get_marker(color) abort dict
	let color_id = get(self.dict_, a:color, -1)

	return color_id < 0
				\ ? '     '
				\ : printf('[%03d]', color_id)
endfunction


function! s:group_name(color_id) abort
	return printf('colorSwatch%03d', a:color_id)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
