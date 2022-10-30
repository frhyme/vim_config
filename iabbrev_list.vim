" 20221012 - frhyme
" :helpgrep Eatchar
" https://stackoverflow.com/questions/11858927/preventing-trailing-whitespace-when-using-vim-abbreviations
func Eatchar(pat)
    " 2022-10-14 (Fri) - frhyme
    " pat stands for pattern
    " nr2char: returns the character the the given ASCII value represents
    " =~ means matches with pattern
    " \s means any white space pattern
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

function GetTodayDate()
    " local이 kor로 설정되어 있어서, 요일이 '토'와 같은 한글값으로 나온다.
    "
    " Sat 와 같이 나오도록 하려면, locale을 변경해야 할 것 같은데, 이건 너무 큰
    " 변경점을 발생시키는 것으로 보인다.
    " 따라서 vimscript를 사용하여 다음처럼 변경해준다
    " 20220402 - sng_hn.lee - Init
    " vim script에서는 . 를 사용하여 string concatenation을 사용합니다.
    " remove new line by cutting tail
    let today = system('date +%Y-%m-%d')[:-2] . ' ('
    let weekday = system('date +%u')[:-2]

    if weekday=='1'
        let today = today .'Mon'
    elseif weekday=='2'
        let today = today .'Tue'
    elseif weekday=='3'
        let today = today .'Wed'
    elseif weekday=='4'
        let today = today .'Thu'
    elseif weekday=='5'
        let today = today .'Fri'
    elseif weekday=='6'
        let today = today .'Sat'
    elseif weekday=='7'
        let today = today .'Sun'
    endif
    return today . ')'
endfunction

function GetCurrentFileName()
    " 2022-10-30 (Sun): get current file name
    " expand: type "help expand" for more info
    " - % means curent file
    " - :p means absolute path
    " split: split string ex) split("a,b,c", ',')
    " substitute: ex) substitute(target_str, pattern, replace_pattern, flags)
    " flag g means global
    " . means meta character in regex, so, for expressing dot character, use
    " \\.
    " ISSUE:
    " why first character of function name in vim should be upper case?
    let current_file_name = expand("%:p")
    let current_file_name = split(current_file_name , '/')[-1]
    let current_file_name = substitute(current_file_name, "_", " ", "g")
    let current_file_name = split(current_file_name , "\\.")[0]
    return current_file_name
endfunction
"====================================
" 2022-10-15 (Sat): sample iabbrev for removing trailing_space
" <CR> meand Carriabe Return
" <C-R>=, Ctrl + R= is used to insert the result of an expression at the
" cursor.
" <silent> means "it doesn't show any message while command is being executed
" iabbrev <silent> __test_shortcut target_full_word<C-R>=Eatchar('\s')<CR>
"====================================
" 2022-10-15 (Sat): for markdown code block
autocmd FileType markdown iabbrev <silent> __code ```<CR><CR>```<UP><C-R>=Eatchar('\s')<CR>
" 20221015 - <expr> doesn need C-R.
iabbrev <expr> __today GetTodayDate().Eatchar('\s')
"====================================================
" Abbreviation - 20220105 - sng_hn.lee
" abbreviate 를 줄여서 ab 로 써도 문제가 없습니다.
" 하지만 저는 가독성을 위해 가능하면 full world를 쓰기 때문에 다음처럼
" word의 충돌을 피하기 위해서, 시작은 __ 로 통일해줄 것
" 사용하였습니다.
" for Single word
" iabbrev: valid in insert mode
" cabbrev: valid in command mode
" for Multi line
" \: bash에서 multiline을 표시할 때는 앞에 backslash
" <CR>: linebreak
" Front Matter for Markdown
autocmd FileType markdown iabbrev __fmt ---
\<CR>title:
\<SPACE><C-R>=GetCurrentFileName()<CR>
\<CR>category:
\<CR>tags:
\<CR>---<CR>
\<CR>## <C-R>=GetCurrentFileName()<CR>
\<UP><UP><UP><UP><UP><END>
\<C-R>=Eatchar('\s')<CR>
" command for shell script
iabbrev <expr> __pwd system('pwd')
iabbrev <expr> __ls system('ls')

" 2022-10-30 (Sun): get current file name
" in Vim, to excute Ex commands by : is equivalent to commands between <C-R>
autocmd FileType markdown iabbrev __current_file_name <C-R>=GetCurrentFileName().Eatchar('\s')<CR>

" 2022-10-20 (Thu) - for html comment
autocmd FileType html iabbrev __comment <!--  --><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
