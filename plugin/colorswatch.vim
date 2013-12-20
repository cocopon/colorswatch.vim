" Author:  cocopon <cocopon@me.com>
" License: MIT License


if exists('g:loaded_colorswatch')
	finish
endif


let s:save_cpo = &cpo
set cpo&vim


command! -nargs=* ColorSwatchGenerate call colorswatch#generate(<f-args>)


let g:loaded_colorswatch = 1


let &cpo = s:save_cpo
unlet s:save_cpo
