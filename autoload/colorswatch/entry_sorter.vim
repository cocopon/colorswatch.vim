let s:save_cpo = &cpo
set cpo&vim


function! colorswatch#entry_sorter#by_name(entry1, entry2) abort
	return (a:entry1.get_name() >= a:entry2.get_name()) * 2 - 1
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
