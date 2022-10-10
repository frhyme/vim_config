"====================================================
" 20220125 - for syntastic configuration
" pylint, flake8
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8', 'pycodestyle']
let g:syntastic_cpp_compiler = 'gcc'
" ---------------------------------
" 20220305 - sng_hn.lee - syntax checker for javascript
" 20220305 - sng_hn.lee temporary disabled JS linter
" let g:syntastic_javascript_checkers = ['eslint']
" ---------------------------------
" 20220305 - sng_hn.lee - syntax checker for markdown
" let g:syntastic_markdown_checker = 'markdownlint'
" gem install mdl before below line
let g:syntastic_markdown_mdl_exec = 'mdl'
" RESTRICT MD013 for Line length, for restriction use tilde(~)
" RESTRICT MD002 - First header should be a top level header, not adequate
let g:syntastic_markdown_mdl_args = "-r '~MD013','~MD002' "
" ---------------------------------
" 20220501 - sng_hn.lee - syntax checker for python
" E501 line too long (145 > 79 characters)
let g:syntastic_python_pycodestyle_args='--ignore=E501'
