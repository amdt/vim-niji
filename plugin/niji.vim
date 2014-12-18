"
" vim-niji - Yet another rainbow parentheses plugin.
"
"  Maintainer: Alastair Touw <alastair@touw.me.uk>
"     Website: http://github.com/amdt/vim-niji
"     License: Distributed under the same terms as Vim. See ':h license'.
"     Version: 1.0.6
" Last Change: 2014 Dec 18
"       Usage: See 'doc/niji.txt' or ':help niji' if installed.
"
" Niji follows the Semantic Versioning specification (http://semver.org).
"
" GetLatestVimScripts: 4580 21966 :AutoInstall: vim-niji
"

scriptencoding utf-8

if exists("g:loaded_niji")
	finish
endif
let g:loaded_niji = 1

if !exists('g:niji_matching_filetypes')
	let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure', 'racket']
endif

function! s:load()
	if count(g:niji_matching_filetypes, &ft) > 0
		call niji#rainbow_parenthesise()
	endif
endfunction

augroup niji
	autocmd!
	autocmd FileType,BufNewFile,BufReadPost,FilterReadPost,FileReadPost,ColorScheme,BufWinEnter,Syntax * nested call s:load()
augroup END

" vim: set noexpandtab
