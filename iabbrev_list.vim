" 20221012 - frhyme
" :helpgrep Eatchar
" https://stackoverflow.com/questions/11858927/preventing-trailing-whitespace-when-using-vim-abbreviations
func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

iabbr <silent> __a abcde<C-R>=Eatchar('\s')<CR>

iabbrev <silent> __code ```<CR>```<C-R>=Eatchar('\s')<CR>

function GetTodayDate()
    " local이 kor로 설정되어 있어서, 요일이 '토'와 같은 한글값으로 나온다.
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

iabbrev <expr> __today GetTodayDate()
