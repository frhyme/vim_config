" 20211203: Install Vundle
set encoding=UTF-8
syntax on
filetype off
set ruler
set history=1000 "vim 기록 1000개까지
" 줄의 들여쓰기, 끝, 시작에서 backspace시 이전 줄로
set backspace=indent,eol,start
"===============================================================
colorscheme jellybeans
set number
" vim 외에서 가져온 복사내용도 붙여넣을 수 있도록 설정
set clipboard=unnamed
" 20211230 - sng_hn.lee - for indeting
set smartindent
" 20220306 - sng_hn.lee
set autoindent
"===============================================================
" kor input을 eng input 으로 변경
set langmap=ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz
"===============================================================
set tabstop=4 "tab을 눌렀을 때 인식하는 칸 수
set softtabstop=4
set shiftwidth=4 " >> << 를 사용하여 들여/내여쓰기를 할때의 칸 수
set laststatus=2 " 마지막 상태표시줄을 항상 2줄로
set expandtab " tab 대신 space
" ignorecase: 대소문자 구분없이 검색
" smartcase: 대문자가 있을 경우 정확히 해당 단어로 검색
set smartcase
set linebreak
set showbreak=...
" 20220106 - 경고 소리를 화면 깜빡임으로 바꾸기
"set visualbell
" 20220228 - javascript tab indentation 2. *.js 로 하면 작동하지 않음
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType markdown setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType lua setlocal ts=2 sts=2 sw=2
"===============================================================
"cursor change for insert, command
" cursor의 모양을 바꿔주는게 아니라, cursor가 위치한 line에 highlight를
" 넣어주는 것.
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
"===============================================================
" change cursor shape for each insert, command mode
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).
" t_SI: Start Insert mode
" t_EI: End Insert mode

let &t_SI = "\<ESC>[6 q"
let &t_EI = "\<ESC>[2 q"

" 20211223 - 기본 언어가 한글로 되어 있어서, 영어로 전환해줌.
" 기본 언어가 한글로 되어 있는 것은, 현재 locale이 KOR로 되어 있어서. 그럼.
set langmenu=en_US.UTF-8
language messages en_US.UTF-8

" ============================================================
" Vundle Plugin List
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" --------------------------
" 20211203 - Install plugin- autopairs
" temporary disable this Plugin
" Plugin 'jiangmiao/auto-pairs'
" --------------------------
" 20211222 - Install Jedi-vim for python autocomplete
" Disable for use coc.nvim in python
" Use python-completer as coc-jedi
"Plugin 'davidhalter/jedi-vim'
" --------------------------
" 20220112 - Install Supertab for Tab completion in Jedi
" without supertab, when popup was shown and you type tab key, inseter tab
" character.
Plugin 'ervandew/supertab'
" --------------------------
" 20220201 - Install nerdtree
Plugin 'https://github.com/preservim/nerdtree'
" --------------------------
" 20220106 - Install powerline
" rtp means RunTime Path
" ~/.vim/bundle/powerline/powerline/bindings/vim
Plugin 'https://github.com/powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" 20220125 - Syntastic for syntax checking
Plugin 'https://github.com/vim-syntastic/syntastic'
" 20220305 - javascript syntax highlight
Plugin 'pangloss/vim-javascript'
" 20220306 - sng_hn.lee - vim indent
Plugin 'nathanaelkane/vim-indent-guides'
" 20220308 - sng_hn.lee - vim emmet
Plugin 'mattn/emmet-vim'
" 20220310 - sng_hn.lee - vim html auto closetag
Plugin 'alvan/vim-closetag'
" 2022-09-28 (Wed) - for markdown preview
" https://github.com/iamcco/markdown-preview.nvim
Plugin 'iamcco/markdown-preview.nvim'
" All of your Plugins must be added before the following line
call vundle#end()            " required

"====================================================
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" --------------------------
" 20220201 - Dev Icons for NerdTree
Plug 'ryanoasis/vim-devicons'
call plug#end()
"====================================================



"====================================================
" 20220106 - sng_hn.lee - PowerLine configurtion
let g:Powerline_symbols = 'fancy'
"====================================================
" 20220121 - for coc popup scroll by mouse
set mouse=a

"=======================================================
" 20220126 - sng_hn.lee - test for tab completion
" use <tab> for trigger completion and navigate to the next complete item
" same mechanism with supertab plugin
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
"=======================================================
" 20220201 - Nerdtree configuration
" normal mode에서 nerd를 type할 경우 NERDTree가 띄워짐.
nnoremap <C-n> :NERDTreeToggle<CR>
" Tree Window Widht
let g:NERDTreeWinSize=60
"=======================================================
" 20220225 - python syntax highlight in markdown
" add vim, json syntax in markdown
let g:markdown_fenced_languages = ['python', 'vim', 'json', 'sh', 'javascript', 'yaml', 'lua', 'go', 'c', 'sql']

"=======================================================
" 20220305 - Plugin AutoPair Config
" filetype별로 설정을 변경함.
" (default) let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
autocmd FileType vim let g:AutoPairs = {}
autocmd FileType markdown let g:AutoPairs = {'(':')', '[':']', '{':'}','```':'```', '"""':'"""', "'''":"'''"}


"=========================
" 20220305 newly add auto bracket manually
" globally 선언해주는 게 필요한데
"autocmd FileType python inoremap { {<CR><CR>}<UP><LEFT><TAB>
" autocmd FileType python inoremap { {}<LEFT>
" autocmd FileType python inoremap " ""<LEFT>
" autocmd FileType python inoremap ' ''<LEFT>

autocmd FileType javascript inoremap { {}<LEFT>
autocmd FileType javascript inoremap [ []<LEFT>
"autocmd FileType javascript inoremap ( ()<LEFT>

" autocmd FileType markdown inoremap ( ()<LEFT>
"autocmd FileType markdown inoremap [ []<LEFT>
"autocmd FileType markdown inoremap ` ``<LEFT>

"autocmd FileType html inoremap " ""<LEFT>
"autocmd FileType html inoremap ' ''<LEFT>

autocmd FileType css inoremap { {}<LEFT>

autocmd FileType go inoremap { {}<LEFT>

autocmd FileType c inoremap { {}<LEFT>


"=========================
" 20220306 - sng_hn.lee - for vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

"=============================================================
" 20220310 - sng_hn.lee - for vim-closetag
" copy and paster from github
source ~/gitRepositories/vim_config/vim_closetag_config.vim
"=============================================================
" 2022.03.25 - sng_hn.lee - trailing space 색깔 변경
" ctermbg = for console version vim
" guibg = for guit version vim
" 따라서,console에서만 사용하는 경우 guibg를 따로 명시하지 않아도 상관이 없다.
highlight TrailingSpace ctermbg=darkred guibg=darkred
match TrailingSpace /\s\+$/
" 2022.03.25 - sng_hn.lee - 저장할 때, 끝에 공백 삭제.
" BufWritePre: 전체 buffer를 file에 쓰기 전 을 의미하는 Event
" 다만 이것도 해석이 필요함.
autocmd FileType markdown,python,html,javascript,go autocmd BufWritePre <buffer> :%s/\s\+$//e

"=============================================================
" 2022.08.24 - sng_hn.lee - Add Foldable
source ~/gitRepositories/vim_config/folding.vim
"=============================================================
" 2022-09-28 (Wed) - MarkdownPreview on vim
source ~/gitRepositories/vim_config/markdownpreview_config.vim
"====================================================
" 20220125 - for syntastic configuration
source ~/gitRepositories/vim_config/syntastic_config.vim
" 20221013 - frhyme - remove trailing space after iabbrev
source ~/gitRepositories/vim_config/iabbrev_list.vim
" 20230820 - frhyme 
source ~/gitRepositories/vim_config/autocmd_markdown.vim
