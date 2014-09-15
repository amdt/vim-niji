"
" vim-niji - Yet another rainbow parentheses plugin.
"
"  Maintainer: Alastair Touw <alastair@touw.me.uk>
"     Website: http://github.com/amdt/vim-niji
"     License: Distributed under the same terms as Vim. See ':h license'.
"     Version: 1.0.5
" Last Change: 2014 Aug 11
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

function! niji#base16_3024_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#db2d20'],
	      \ [s:cterm09, '#e8bbd0'],
	      \ ['03', '#fded02'],
	      \ ['02', '#01a252'],
	      \ ['06', '#b5e4f4'],
	      \ ['04', '#01a0e4'],
	      \ ['05', '#a16a94'],
	      \ [s:cterm0F, '#cdab53']]
endfunction

function! niji#base16_ashes_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#C7AE95'],
	      \ [s:cterm09, '#C7C795'],
	      \ ['03', '#AEC795'],
	      \ ['02', '#95C7AE'],
	      \ ['06', '#95AEC7'],
	      \ ['04', '#AE95C7'],
	      \ ['05', '#C795AE'],
	      \ [s:cterm0F, '#C79595']]
endfunction

function! niji#base16_atelierdune_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#d73737'],
	      \ [s:cterm09, '#b65611'],
	      \ ['03', '#cfb017'],
	      \ ['02', '#60ac39'],
	      \ ['06', '#1fad83'],
	      \ ['04', '#6684e1'],
	      \ ['05', '#b854d4'],
	      \ [s:cterm0F, '#d43552']]
endfunction

function! niji#base16_atelierforest_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#f22c40'],
	      \ [s:cterm09, '#df5320'],
	      \ ['03', '#d5911a'],
	      \ ['02', '#5ab738'],
	      \ ['06', '#00ad9c'],
	      \ ['04', '#407ee7'],
	      \ ['05', '#6666ea'],
	      \ [s:cterm0F, '#c33ff3']]
endfunction

function! niji#base16_atelierheath_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#ca402b'],
	      \ [s:cterm09, '#a65926'],
	      \ ['03', '#bb8a35'],
	      \ ['02', '#379a37'],
	      \ ['06', '#159393'],
	      \ ['04', '#516aec'],
	      \ ['05', '#7b59c0'],
	      \ [s:cterm0F, '#cc33cc']]
endfunction

function! niji#base16_atelierlakeside_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#d22d72'],
	      \ [s:cterm09, '#935c25'],
	      \ ['03', '#8a8a0f'],
	      \ ['02', '#568c3b'],
	      \ ['06', '#2d8f6f'],
	      \ ['04', '#257fad'],
	      \ ['05', '#5d5db1'],
	      \ [s:cterm0F, '#b72dd2']]
endfunction

function! niji#base16_atelierseaside_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#e6193c'],
	      \ [s:cterm09, '#87711d'],
	      \ ['03', '#c3c322'],
	      \ ['02', '#29a329'],
	      \ ['06', '#1999b3'],
	      \ ['04', '#3d62f5'],
	      \ ['05', '#ad2bee'],
	      \ [s:cterm0F, '#e619c3']]
endfunction

function! niji#base16_bespin_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#cf6a4c'],
	      \ [s:cterm09, '#cf7d34'],
	      \ ['03', '#f9ee98'],
	      \ ['02', '#54be0d'],
	      \ ['06', '#afc4db'],
	      \ ['04', '#5ea6ea'],
	      \ ['05', '#9b859d'],
	      \ [s:cterm0F, '#937121']]
endfunction

function! niji#base16_brewer_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#e31a1c'],
	      \ [s:cterm09, '#e6550d'],
	      \ ['03', '#dca060'],
	      \ ['02', '#31a354'],
	      \ ['06', '#80b1d3'],
	      \ ['04', '#3182bd'],
	      \ ['05', '#756bb1'],
	      \ [s:cterm0F, '#b15928']]
endfunction

function! niji#base16_bright_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#fb0120'],
	      \ [s:cterm09, '#fc6d24'],
	      \ ['03', '#fda331'],
	      \ ['02', '#a1c659'],
	      \ ['06', '#76c7b7'],
	      \ ['04', '#6fb3d2'],
	      \ ['05', '#d381c3'],
	      \ [s:cterm0F, '#be643c']]
endfunction

function! niji#base16_chalk_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#fb9fb1'],
	      \ [s:cterm09, '#eda987'],
	      \ ['03', '#ddb26f'],
	      \ ['02', '#acc267'],
	      \ ['06', '#12cfc0'],
	      \ ['04', '#6fc2ef'],
	      \ ['05', '#e1a3ee'],
	      \ [s:cterm0F, '#deaf8f']]
endfunction

function! niji#base16_codeschool_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#2a5491'],
	      \ [s:cterm09, '#43820d'],
	      \ ['03', '#a03b1e'],
	      \ ['02', '#237986'],
	      \ ['06', '#b02f30'],
	      \ ['04', '#484d79'],
	      \ ['05', '#c59820'],
	      \ [s:cterm0F, '#c98344']]
endfunction

function! niji#base16_default_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#ac4142'],
	      \ [s:cterm09, '#d28445'],
	      \ ['03', '#f4bf75'],
	      \ ['02', '#90a959'],
	      \ ['06', '#75b5aa'],
	      \ ['04', '#6a9fb5'],
	      \ ['05', '#aa759f'],
	      \ [s:cterm0F, '#8f5536']]
endfunction

function! niji#base16_eighties_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#f2777a'],
	      \ [s:cterm09, '#f99157'],
	      \ ['03', '#ffcc66'],
	      \ ['02', '#99cc99'],
	      \ ['06', '#66cccc'],
	      \ ['04', '#6699cc'],
	      \ ['05', '#cc99cc'],
	      \ [s:cterm0F, '#d27b53']]
endfunction

function! niji#base16_embers_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#826D57'],
	      \ [s:cterm09, '#828257'],
	      \ ['03', '#6D8257'],
	      \ ['02', '#57826D'],
	      \ ['06', '#576D82'],
	      \ ['04', '#6D5782'],
	      \ ['05', '#82576D'],
	      \ [s:cterm0F, '#825757']]
endfunction

function! niji#base16_flat_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#E74C3C'],
	      \ [s:cterm09, '#E67E22'],
	      \ ['03', '#F1C40F'],
	      \ ['02', '#2ECC71'],
	      \ ['06', '#1ABC9C'],
	      \ ['04', '#3498DB'],
	      \ ['05', '#9B59B6'],
	      \ [s:cterm0F, '#be643c']]
endfunction

function! niji#base16_google_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#CC342B'],
	      \ [s:cterm09, '#F96A38'],
	      \ ['03', '#FBA922'],
	      \ ['02', '#198844'],
	      \ ['06', '#3971ED'],
	      \ ['04', '#3971ED'],
	      \ ['05', '#A36AC7'],
	      \ [s:cterm0F, '#3971ED']]
endfunction

function! niji#base16_grayscale_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#7c7c7c'],
	      \ [s:cterm09, '#999999'],
	      \ ['03', '#a0a0a0'],
	      \ ['02', '#8e8e8e'],
	      \ ['06', '#868686'],
	      \ ['04', '#686868'],
	      \ ['05', '#747474'],
	      \ [s:cterm0F, '#5e5e5e']]
endfunction

function! niji#base16_greenscreen_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#007700'],
	      \ [s:cterm09, '#009900'],
	      \ ['03', '#007700'],
	      \ ['02', '#00bb00'],
	      \ ['06', '#005500'],
	      \ ['04', '#009900'],
	      \ ['05', '#00bb00'],
	      \ [s:cterm0F, '#005500']]
endfunction

function! niji#base16_isotope_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#ff0000'],
	      \ [s:cterm09, '#ff9900'],
	      \ ['03', '#ff0099'],
	      \ ['02', '#33ff00'],
	      \ ['06', '#00ffff'],
	      \ ['04', '#0066ff'],
	      \ ['05', '#cc00ff'],
	      \ [s:cterm0F, '#3300ff']]
endfunction

function! niji#base16_londontube_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#ee2e24'],
	      \ [s:cterm09, '#f386a1'],
	      \ ['03', '#ffd204'],
	      \ ['02', '#00853e'],
	      \ ['06', '#85cebc'],
	      \ ['04', '#009ddc'],
	      \ ['05', '#98005d'],
	      \ [s:cterm0F, '#b06110']]
endfunction

function! niji#base16_marrakesh_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#c35359'],
	      \ [s:cterm09, '#b36144'],
	      \ ['03', '#a88339'],
	      \ ['02', '#18974e'],
	      \ ['06', '#75a738'],
	      \ ['04', '#477ca1'],
	      \ ['05', '#8868b3'],
	      \ [s:cterm0F, '#b3588e']]
endfunction

function! niji#base16_mocha_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#cb6077'],
	      \ [s:cterm09, '#d28b71'],
	      \ ['03', '#f4bc87'],
	      \ ['02', '#beb55b'],
	      \ ['06', '#7bbda4'],
	      \ ['04', '#8ab3b5'],
	      \ ['05', '#a89bb9'],
	      \ [s:cterm0F, '#bb9584']]
endfunction

function! niji#base16_monokai_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#f92672'],
	      \ [s:cterm09, '#fd971f'],
	      \ ['03', '#f4bf75'],
	      \ ['02', '#a6e22e'],
	      \ ['06', '#a1efe4'],
	      \ ['04', '#66d9ef'],
	      \ ['05', '#ae81ff'],
	      \ [s:cterm0F, '#cc6633']]
endfunction

function! niji#base16_ocean_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#bf616a'],
	      \ [s:cterm09, '#d08770'],
	      \ ['03', '#ebcb8b'],
	      \ ['02', '#a3be8c'],
	      \ ['06', '#96b5b4'],
	      \ ['04', '#8fa1b3'],
	      \ ['05', '#b48ead'],
	      \ [s:cterm0F, '#ab7967']]
endfunction

function! niji#base16_paraiso_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#ef6155'],
	      \ [s:cterm09, '#f99b15'],
	      \ ['03', '#fec418'],
	      \ ['02', '#48b685'],
	      \ ['06', '#5bc4bf'],
	      \ ['04', '#06b6ef'],
	      \ ['05', '#815ba4'],
	      \ [s:cterm0F, '#e96ba8']]
endfunction

function! niji#base16_pop_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#eb008a'],
	      \ [s:cterm09, '#f29333'],
	      \ ['03', '#f8ca12'],
	      \ ['02', '#37b349'],
	      \ ['06', '#00aabb'],
	      \ ['04', '#0e5a94'],
	      \ ['05', '#b31e8d'],
	      \ [s:cterm0F, '#7a2d00']]
endfunction

function! niji#base16_railscasts_colours()
	if exists('base16colorspace') && base16colorspace == '256'
		let s:cterm09 = '16'
		let s:cterm0F = '17'
	else
		let s:cterm09 = '09'
		let s:cterm0F = '14'
	endif

	return [['01', '#da4939'],
	      \ [s:cterm09, '#cc7833'],
	      \ ['03', '#ffc66d'],
	      \ ['02', '#a5c261'],
	      \ ['06', '#519f50'],
	      \ ['04', '#6d9cbe'],
	      \ ['05', '#b6b3eb'],
	      \ [s:cterm0F, '#bc9458']]
endfunction

function! niji#hemisu_colours()
	return {'light_colours': [['246', '#999999'],
	                        \ ['241', '#777777'],
	                        \ ['249', '#BBBBBB'],
	                        \ ['24', '#538192'],
	                        \ ['64', '#739200'],
	                        \ ['197', '#FF0055'],
	                        \ ['52', '#503D15'],
	                        \ ['197', '#FF0055'],
	                        \ ['64', '#739200'],
	                        \ ['24', '#538192'],
	                        \ ['217', '#FFAFAF'],
	                        \ ['157', '#BBFFAA'],
	                        \ ['195', '#CBE4EE']],
	      \ 'dark_colours': [['241', '#777777'],
	                       \ ['246', '#999999'],
	                       \ ['238', '#444444'],
	                       \ ['116', '#9FD3E6'],
	                       \ ['149', '#B1D631'],
	                       \ ['157', '#BBFFAA'],
	                       \ ['230', '#ECE1C8'],
	                       \ ['167', '#D65E76'],
	                       \ ['149', '#B1D631'],
	                       \ ['116', '#9FD3E6'],
	                       \ ['88', '#63001C'],
	                       \ ['58', '#5F5F00'],
	                       \ ['24', '#005F87']]}
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
	elseif exists('g:colors_name') && exists('g:niji_' . substitute(g:colors_name, '-', '_', 'g') . '_colours')
		let l:colour_set = eval('g:niji_' . substitute(g:colors_name, '-', '_', 'g') . '_colours')
	elseif exists('g:colors_name') && exists('*niji#' . substitute(g:colors_name, '-', '_', 'g') . '_colours')
		let l:colour_set = call('niji#' . substitute(g:colors_name, '-', '_', 'g') . '_colours', [])
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
