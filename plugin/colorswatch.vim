if exists('g:loaded_colorswatch')
	finish
endif


let s:save_cpo = &cpo
set cpo&vim


command! -nargs=*
			\ -complete=custom,colorswatch#generate_complete
			\ ColorSwatchGenerate call colorswatch#generate(<f-args>)

let g:loaded_colorswatch = 1


let &cpo = s:save_cpo
unlet s:save_cpo
