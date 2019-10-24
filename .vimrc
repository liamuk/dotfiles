execute pathogen#infect()

filetype plugin indent on
syntax on

set nocompatible
set rnu
set ruler

set nowrap
set tw=80
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set incsearch
set mouse=a
set clipboard=unnamed
set conceallevel=2
set backspace=indent,eol,start

set background=dark
colors solarized

"hi NonText ctermfg=bg
"hi clear SignColumn
"set signcolumn=yes

let NERDTreeIgnore = ['\.pyc$']
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'

"trailing whitespace is bad
"autocmd InsertLeave,BufWinEnter * if &l:modifiable | %s/\s\+$//ge | endif
highlight ExtraWhitespace ctermbg=red guibg=red

"augroup filetype_LaTeX
"    autocmd BufRead,BufNewFile *.tex autocmd InsertLeave,TextChanged <buffer> w
"augroup END

"autocmd filetype crontab setlocal nobackup nowritebackup
"autocmd BufRead,BufNewFile *.less set filetype=css

nmap <left> :wincmd h<CR>
nmap <right> :wincmd l<CR>
nmap <up> :wincmd k<CR>
nmap <down> :wincmd j<CR>
nmap <C-n> :NERDTreeToggle<CR>

"Run line(s) as command. Useful for per-file config
"nmap <C-b> "zyy:@z<CR>
"nmap <C-t> :set ts=4 sts=4 noet<CR>:retab!<CR>:set ts=2 sts=2 et<CR>:retab<CR>
"nmap <C-l> :lwindow<CR>

"inoremap ( (

"set statusline+=%#warningmsg#
"set statusline+=%*
