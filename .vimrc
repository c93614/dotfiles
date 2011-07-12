let g:ctagsdir = "exctags"
let g:backupdir = "~/.vim/backup"

"source /etc/vim/vimrc 
source ~/.vim/vimrc 
"source ~/plugin/taglist.vim
"source ~/project/project.vim

"------------------------------------------------
"=> Custom Vim Set
"------------------------------------------------

"map  :tabn <CR>
"map ^[[D :tabp <CR>

let g:page_key = 0 

map \\ :let g:page_key = eval("!g:page_key") <bar> :echo g:page_key <CR>
function! Page_up_down()
    if g:page_key == 0
        normal   
        echo "Page Down"
    else
        normal  
        echo "Page Up"
    endif
endfunction
map mm :call Page_up_down() <CR>

set hlsearch
set incsearch
set ignorecase
set expandtab
set ts=4
set shiftwidth=4
set bs=2
set fenc=utf8
set textwidth=76

set pastetoggle=<F9>
set mouse=

autocmd FileType sh map <buffer> <leader>r :w!<cr>:!bash %<cr>
autocmd FileType python map <buffer> <leader>r :w!<cr>:!python27 %<cr>
autocmd FileType php map <buffer> <leader>r :w!<cr>:!php %<cr>

"autocmd BufNewFile *.php,*.inc 0r ~/.vim/skeleton.php | normal Gdd3G 


if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
