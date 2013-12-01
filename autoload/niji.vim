"
" vim-niji - Yet another rainbow parentheses plugin.
"
"  Maintainer: Alastair Touw <alastair@touw.me.uk>
"     Website: http://github.com/amdt/vim-niji
"     License: Distributed under the same terms as Vim. See ':h license'.
"     Version: 1.0.2
" Last Change: 2013 Jun 02
"       Usage: See 'doc/niji.txt' or ':help niji' if installed.
"
" Niji follows the Semantic Versioning specification (http://semver.org).
"

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! niji#association_list_with_keys_and_values(list_a, list_b)
	" Takes two lists and builds a list of list pairs where the 0'th
	" indices are the items of 'list_a' and the 1'th indices are the items
	" of 'list_b'.
	"
	" Assumes 'list_a' and 'list_b' are of equal length.
	let l:list = []

	for each in range(1, len(a:list_a))
		let l:list += [[a:list_a[each -1], a:list_b[each -1]]]
	endfor

	return l:list
endfunction

function! niji#normalised_colours(colour_set)
	" Takes a colour set in one of three formats and returns it in a
	" fourth. The four formats are described as follows:
	"
	" 1. A single list of colours: the same colours are used for both
	"    light and dark backgrounds, and both terminal and graphical
	"    variants of Vim.
	"
	"        [red, blue, green]
	"
	" 2. A list of a list of pairs: the same colours are used for both
	"    light and dark backgrounds, but different colours for terminal and
	"    graphical variants of Vim.
	"
	"        [[red, red1], [blue, blue1], [green, green1]]
	"
	" 3. A dictionary of two lists of colours: different colours are used
	"    for light and dark backgrounds, but the same colours are used for
	"    both terminal and graphical variants of Vim.
	"
	"        {‘light_colours’: [red, blue, green],
	"        \ ‘dark_colours’: [orange, purple, yellow]}
	"
	" 4. A dictionary of two lists of a list of pairs: different colours
	"    are used for both light and dark backgrounds, and both terminal
	"    and graphical variants of vim.
	"
	"        {‘light_colours’: [[red, red1], [blue, blue1], [green, green1]],
	"        \ ‘dark_colours’: [[orange, orange1], [purple, purple1], [yellow, yellow1]]}
	"
	" Assumes the colour sets are correctly formed.
	if type(a:colour_set) == type({})
		if type(a:colour_set['light_colours'][0]) == type('')
			return {'light_colours': niji#association_list_with_keys_and_values(a:colour_set.light_colours, a:colour_set.light_colours),
			      \ 'dark_colours': niji#association_list_with_keys_and_values(a:colour_set.dark_colours, a:colour_set.dark_colours)}
		else
			return a:colour_set
		endif
	elseif type(a:colour_set) == type([])
		if type(a:colour_set[0]) == type([])
			return {'light_colours': a:colour_set,
			      \ 'dark_colours': a:colour_set}
		elseif type(a:colour_set[0]) == type('')
			return {'light_colours': niji#association_list_with_keys_and_values(a:colour_set, a:colour_set),
			      \ 'dark_colours': niji#association_list_with_keys_and_values(a:colour_set, a:colour_set)}
		endif
	endif
endfunction

function! niji#solarized_colours()
	" Solarized (magenta, red, orange, yellow, cyan, violet, blue, green)
	if g:solarized_degrade == 1
		let l:solarized_guifg_colours = ['#af005f',
		                               \ '#af0000',
		                               \ '#d75f00',
		                               \ '#af8700',
		                               \ '#00afaf',
		                               \ '#5f5faf',
		                               \ '#0087ff',
		                               \ '#5f8700']
	else
		let l:solarized_guifg_colours = ['#d33682',
		                               \ '#dc322f',
		                               \ '#cb4b16',
		                               \ '#b58900',
		                               \ '#719e07',
		                               \ '#2aa198',
		                               \ '#6c71c4',
		                               \ '#268bd2']
	endif

	if g:solarized_termcolors != 256 && &t_Co >= 16
		let l:solarized_ctermfg_colours = [5, 1, 9, 3, 2, 6, 13, 4]
	elseif g:solarized_termcolors == 256
		let l:solarized_ctermfg_colours = [135, 124, 166, 136, 64, 37, 61, 33]
	else
		let l:solarized_ctermfg_colours = ['DarkMagenta',
		                                 \ 'DarkRed',
		                                 \ 'LightRed',
		                                 \ 'DarkYellow',
		                                 \ 'DarkGreen',
		                                 \ 'DarkCyan',
		                                 \ 'LightMagenta',
		                                 \ 'DarkBlue']
	endif

	return {'light_colours': niji#association_list_with_keys_and_values(reverse(copy(l:solarized_ctermfg_colours)),
	                                                                  \ reverse(copy(l:solarized_guifg_colours))),
	      \ 'dark_colours': niji#association_list_with_keys_and_values(l:solarized_ctermfg_colours,
	                                                                 \ l:solarized_guifg_colours)}
endfunction

function! niji#badwolf_colours()
	let l:mediumgravel = [241, '#666462']
	let l:dalespale = [221, '#fade3e']
	let l:dress = [211, '#ff9eb8']
	let l:orange = [214, '#ffa724']
	let l:tardis = [39, '#0a9dff']
	let l:lime = [154, '#aeee00']
	let l:toffee = [137, '#b88853']
	let l:saltwatertaffy = [121, '#8cffba']
	let l:coffee = [173, '#c7915b']

	return [l:mediumgravel,
	      \ l:dalespale,
	      \ l:dress,
	      \ l:orange,
	      \ l:tardis,
	      \ l:lime,
	      \ l:toffee,
	      \ l:saltwatertaffy,
	      \ l:coffee,
	      \ l:dalespale,
	      \ l:dress,
	      \ l:orange,
	      \ l:tardis,
	      \ l:lime,
	      \ l:toffee,
	      \ l:saltwatertaffy]
endfunction

function! niji#lisp_colours()
	" As they appear in Vim's packaged Lisp.vim syntax file.
	return {'light_colours': [['red', 'red3'],
	                        \ ['darkyellow', 'orangered3'],
	                        \ ['darkgreen', 'orange2'],
	                        \ ['blue', 'yellow3'],
	                        \ ['darkmagenta', 'olivedrab4'],
	                        \ ['red', 'green4'],
	                        \ ['darkyellow', 'paleturquoise3'],
	                        \ ['darkgreen', 'deepskyblue4'],
	                        \ ['blue', 'darkslateblue'],
	                        \ ['darkmagenta', 'darkviolet']],
	      \ 'dark_colours': [['red', 'red1'],
	                       \ ['yellow', 'orange1'],
	                       \ ['green', 'yellow1'],
	                       \ ['cyan', 'greenyellow'],
	                       \ ['magenta', 'green1'],
	                       \ ['red', 'springgreen1'],
	                       \ ['yellow', 'cyan1'],
	                       \ ['green', 'slateblue1'],
	                       \ ['cyan', 'magenta1'],
	                       \ ['magenta', 'purple1']]}
endfunction

function! niji#legacy_colours()
	" As they appear in most rainbow parentheses scripts release before
	" this one.
	return [['brown', 'RoyalBlue3'],
	      \ ['Darkblue', 'SeaGreen3'],
	      \ ['darkgray', 'DarkOrchid3'],
	      \ ['darkgreen', 'firebrick3'],
	      \ ['darkcyan', 'RoyalBlue3'],
	      \ ['darkred', 'SeaGreen3'],
	      \ ['darkmagenta', 'DarkOrchid3'],
	      \ ['brown', 'firebrick3'],
	      \ ['gray', 'RoyalBlue3'],
	      \ ['black', 'SeaGreen3'],
	      \ ['darkmagenta', 'DarkOrchid3'],
	      \ ['Darkblue', 'firebrick3'],
	      \ ['darkgreen', 'RoyalBlue3'],
	      \ ['darkcyan', 'SeaGreen3'],
	      \ ['darkred', 'DarkOrchid3'],
	      \ ['red', 'firebrick3']]
endfunction

function! niji#reverse_even_items(list)
	let l:even_items = filter(copy(a:list), 'v:key % 2')

	call reverse(l:even_items)

	call map(a:list, 'v:key % 2 ? get(l:even_items, v:key / 2) : v:val')
endfunction

function! niji#rainbow_parenthesise()
	" Prepare appropriate sets of matching characters and colours, for the
	" current filetype and colorscheme, respectively. Attempts to choose
	" these in the following order:
	"
	" 1. A set the user wants loaded always.
	" 2. A set the user wants loaded for the current filetype
	"    or colorscheme.
	" 3. A set appropriate to the current filetype or colorscheme.
	" 4. An otherwise sensible default.
	let l:lisp_characters = [['`\=(', ')']]
	let l:scheme_characters = [['(', ')'], ['\[', '\]']]
	let l:clojure_characters = [['(', ')'], ['\[', '\]'], ['{', '}']]
	let l:racket_characters = [['(', ')'], ['\[', '\]'], ['{', '}']]

	if exists('g:niji_always_match')
		let l:matching_characters = g:niji_always_match
	elseif exists('g:niji_' . &ft . '_characters')
		let l:matching_characters = eval('g:niji_' . &ft . '_characters')
	else
		let l:matching_characters = eval('l:' . &ft . '_characters')
	endif

	if exists('g:niji_always_highlight')
		let l:colour_set = g:niji_always_highlight
	elseif exists('g:colors_name') && exists('g:niji_' . g:colors_name . '_colours')
		let l:colour_set = eval('g:niji_' . g:colors_name . '_colours')
	elseif exists('g:colors_name') && exists('*niji#' . g:colors_name . '_colours')
		let l:colour_set = call('niji#' . g:colors_name . '_colours', [])
	elseif exists('g:niji_use_legacy_colours')
		let l:colour_set = call('niji#legacy_colours', [])
	else
		let l:colour_set = call('niji#lisp_colours', [])
	endif

	let l:colours = reverse(niji#normalised_colours(l:colour_set)[&bg == 'light' ? 'light_colours' : 'dark_colours'])

	if exists('g:niji_weave_colours')
		call niji#reverse_even_items(l:colours)
	endif

	call niji#highlight(l:matching_characters, l:colours)
endfunction

function! niji#highlight(matching_characters, colour_set)
	" Creates syntax and highlight groups for each set of pairs of
	" characters and colours, respectively.
	"
	" The definition of syntax groups differs from the included Lisp.vim
	" and rainbow parentheses plugins released previously to this one:
	" uses the ALLBUT syntax to exclude all parentheses except the next
	" level. This resolves a bug found in all previous implementations
	" where there is a single extra level of un-styled parentheses.
	for character_pair in a:matching_characters
		for each in range(1, len(a:colour_set))
			execute printf('syntax region Niji_paren%s matchgroup=Niji_paren_level%s start=/%s/ end=/%s/ contains=ALLBUT,racketSymbol,%s',
			          \ string(each),
			          \ string(each),
			          \ character_pair[0],
			          \ character_pair[1],
			          \ join(map(filter(range(1, len(a:colour_set)),
			                          \ each == 1 ? 'v:val != len(a:colour_set)' : 'v:val != each - 1'),
			                   \ '"Niji_paren" . v:val'),
			               \ ','))
		endfor
	endfor

	for each in range(1, len(a:colour_set))
		execute printf('highlight default Niji_paren_level%s ctermfg=%s guifg=%s',
		             \ string(each),
		             \ a:colour_set[each - 1][0],
		             \ a:colour_set[each - 1][1])
	endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set noexpandtab
