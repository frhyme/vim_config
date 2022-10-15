"=============================================================
" 2022.08.24 - sng_hn.lee - Add Foldable
" https://velog.io/@ggg/vim-folding
set foldenable          " enable folding
set foldlevelstart=10
set foldnestmax=10
" nnoremap only works in normal mode but, noremap works normal, visual mode
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" 2022-08-25 (Thu) - save and load folding
"""
"=============================================================
" 2022.09.02 - frhyme - sometime folding doesnt work when below commands ar
" activated. when it happend - remove the file in ~/.vim/view
" it is required to replace BufWinLeave to saved so, BufWineLeave to
" BufWritePost
autocmd FileType python autocmd BufWritePost *.py mkview
autocmd FileType python autocmd BufWinEnter *.py silent loadview
