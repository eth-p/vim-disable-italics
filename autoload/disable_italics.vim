" Thanks to u/TheDerkus on Reddit for the code!
" https://www.reddit.com/r/vim/comments/5iop1e/disable_all_italic_highlights/

function! disable_italics#RemoveItalicFromHighlightCommand(somestring)
	let cmd=a:somestring . " "
	let cmd=substitute(cmd, "italic", "", "g") " remove italics
	let cmd=substitute(cmd, ",,", ",", "g") " when italic occurs in middle of list, delete extraneous comma 
	let cmd=substitute(cmd, ", ", " ", "g") " when italic at end of list, delete extraneous comma
	let cmd=substitute(cmd, "gui\= ", " ", "g") " when italic is only item in list, delete arg to avoid error 
	let cmd=substitute(cmd, "cterm\= ", " ", "g") " when italic is only item in list, delete arg to avoid error 
	let cmd=substitute(cmd, "term\= ", " ", "g") " when italic is only item in list, delete arg to avoid error
	return cmd
endfunction 

function! disable_italics#Apply()
	redir @a | silent hi | redir END 
	let @a=substitute(@a, "xxx", "", "g") " The :hi command displays 'xxx' to show what the groups look like 
	let cmdlist = split(@a, "\n") 
	call filter(cmdlist, 'v:val =~ "italic"') 
	call map(cmdlist, 'disable_italics#RemoveItalicFromHighlightCommand(v:val)') 
	for cmd in cmdlist 
		let groupname=split(cmd, " ")[0] 
		silent execute "hi clear ".groupname
		silent execute "hi default ".cmd
	endfor
endfunction

