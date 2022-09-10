if exists("g:loaded_disable_italics")
	finish
endif
let g:loaded_disable_italics = 1

autocmd VimEnter * call disable_italics#Apply()

