"
" vim-niji - Yet another fork of RainbowParenthsis.vim
"
"  Maintainer: Alastair Touw <alastair@touw.me.uk>
"     Website: http://github.com/amdt/vim-niji
"     License: Distributed under the same terms as Vim. See ':h license'.
"     Version: 1.0.0
" Last Change: 2013 May 4
"       Usage: See 'doc/niji.txt' or ':help niji' if installed.
"
" Niji follows the Semantic Versioning specification (http://semver.org).
"

scriptencoding utf-8

if exists("g:loaded_niji")
	finish
endif
let g:loaded_niji = 1

let s:matching_filetypes = ['lisp', 'scheme', 'clojure']
let s:matching_filetypes = exists('g:niji_matching_filetypes') ? g:niji_matching_filetypes : s:matching_filetypes

function s:load()
	if count(s:matching_filetypes, &ft) > 0
		call niji#highlight()
	endif
endfunction

autocmd BufReadPost * nested call s:load()
