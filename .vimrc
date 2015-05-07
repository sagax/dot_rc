"" Last update: 01.05.2015 02:42
au! bufwritepre $MYVIMRC call setline(1, '"" Last update: '.strftime("%d.%m.%Y %H:%M"))
au! bufwritepost $MYVIMRC source $MYVIMRC

filetype on
filetype plugin on
filetype indent on
syntax enable

let g:airline_theme='kalisi'
let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_enable_bufferline=1
let g:airline_left_sep = '❱'
let g:airline_right_sep = '❰'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_section_c = '%t'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:vim_markdown_initial_foldlevel=1
let g:python_check_syntax=0
let g:python_auto_complete_modules=0
let g:python_auto_complete_variables=0
let g:python_syntax_fold="indent"
let g:SuperTabDefaultCompletionType="<c-x><c-n>"
let g:colorscheme_switcher_define_mappings=1
let g:curmovse=1
let g:tagbar_sort=0
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_on_fly = 0
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_rope_completion = 0
let g:gitgutter_max_signs = 1500

let g:CoffeeAutoTagDisabled=0     " Disables autotaging on save (Default: 0 [false])
let g:CoffeeAutoTagFile="./tags"  " Name of the generated tag file (Default: ./tags)
let g:CoffeeAutoTagIncludeVars=1  " Includes variables (Default: 0 [false])
let g:CoffeeAutoTagTagRelative=1  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let label = fnamemodify(bufname(buflist[winnr - 1]), ':t')
    if label == ''
        if &buftype == 'quickfix'
          let label = '[Quickfix List]'
        else
          let label = 'NoName'
        endif
    endif
    if getbufvar(buflist[winnr - 1], "&modified")
        let label = "+".label
    endif
    let label = a:n.":".label
    return label
endfunction

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (i + 1) . 'T'
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor
    let s .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif
    return s
endfunction

function! SetColorschemeTime()
    let hour=strftime("%H")
    if 6 <= hour && hour < 19
        colorscheme lilydjwg_dark
    else
        colorscheme github
    endif
endfunction

function! CursorVC()
    set colorcolumn=80
    let numc=0
    exec 'hi CursorLine cterm=NONE ctermbg='numc' ctermfg=NONE'
    exec 'hi CursorColumn cterm=NONE ctermbg='numc' ctermfg=NONE'
    exec 'hi ColorColumn cterm=NONE ctermbg=2 ctermfg=255'
    set cursorline! cursorcolumn!
endfunction

function! EDCursorMovedhl()
    echo g:curmovse
    if g:curmovse == 1
        augroup CursorVMg
            autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))
        augroup end
        let g:curmovse = 0
    else
        autocmd! CursorVMg CursorMoved
        :call clearmatches()
        let g:curmovse = 1
    endif
endfunction

function! FindhlSearch()
    set nohlsearch!
endfunction

function! ToggleFullScreen()
    if &go =~ 'e'
        exec('silent !wmctrl -r :ACTIVE: -b add,fullscreen')
        exec('set go-=e')
    else
        exec('silent !wmctrl -r :ACTIVE: -b remove,fullscreen')
        exec('set go+=e')
    endif
endfunction

hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black
hi Pmenu guibg=white guifg=DodgerBlue3 gui=bold ctermbg=white ctermfg=17
hi PmenuSel guibg=DodgerBlue3 guifg=white gui=bold ctermbg=17 ctermfg=white
hi PmenuSbar guibg=white ctermbg=white
hi PmenuThumb guibg=DarkRed ctermbg=darkred
hi StatusLine gui=reverse cterm=reverse
hi SpellBad ctermfg=Black ctermbg=Red

set guioptions+=e
set guioptions-=r
set guioptions-=R
set guioptions-=b
set guioptions-=l
set guioptions-=L
set guioptions-=T
set guioptions-=m
set background=light
set pumheight=20
set showtabline=2
set clipboard+=unnamed
set tabline=%!MyTabLine()
set gfn=FreeMono\ Bold\ 11
set nocompatible
set scrolloff=3
set t_Co=256
set nowrap
set linebreak
set hidden
set mouse=a
set showcmd
set matchpairs+=<:>
set showmatch
set autoread
set formatoptions+=cro
set laststatus=2
set noruler
set list
set backspace=indent,eol,start
set sessionoptions=curdir,buffers,tabpages
set noswapfile
set visualbell
set title
set history=2048
set undolevels=2048
set whichwrap=b,<,>,[,],l,h
set pastetoggle=
set ignorecase
set smartcase
set incsearch
set autoindent
set cindent
set expandtab
set smartindent
set number
set go+=a
set shiftwidth=4
set tabstop=4
set softtabstop=4
set foldenable
set foldcolumn=4
set foldlevel=1
set foldmethod=indent

au FileType crontab,fstab,make tabstop=4 shiftwidth=4
au FileType python set omnifunc=pythoncomplete#Complete
au FileType ruby,eruby set omnifunc=rubycomplete#Complete
au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
au FileType tt2html set omnifunc=htmlcomplete#CompleteTags
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType c set omnifunc=ccomplete#Complete
au FileType tcl set omnifunc=tclcomplete#CompleteTCL
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType sass set omnifunc=csscomplete#CompleteCSS
au FileType scss set omnifunc=csscomplete#CompleteCSS
au FileType css,html,sass,scss,rb,ruby,erb,php,xml,js,javascript,erb,coffee set expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2
au FileType css,sass,scss setf scss
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript

imap <C-C> <C-X><C-O>
imap <C-V> <C-X><C-N>
nmap <F2> <ESC>:w <CR>
vmap <F2> <ESC>:w <CR>
imap <F2> <ESC>:w <CR>
nmap <F3> <ESC>:q <CR>
vmap <F3> <ESC>:q <CR>
imap <F3> <ESC>:q <CR> i
nmap <F4> <ESC>:call CursorVC() <CR>
vmap <F4> <ESC>:call CursorVC() <CR>
imap <F4> <ESC>:call CursorVC() <CR> i
nmap <F5> <ESC>:bp<CR>
vmap <F5> <ESC>:bp <CR>
imap <F5> <ESC>:bp <CR> i
nmap <F6> <ESC>:bn<CR>
vmap <F6> <ESC>:bn <CR>
imap <F6> <ESC>:bn <CR> i
nmap <F7> <ESC>:MiniBufExplorer <CR>
vmap <F7> <ESC>:MiniBufExplorer <CR>
imap <F7> <ESC>:MiniBufExplorer <CR> i
nmap <F8> <ESC>:bdelete <CR>
vmap <F8> <ESC>:bdelete <CR>
imap <F8> <ESC>:bdelete <CR> i
nmap <C-F5> <ESC>:tabprevious<CR>
vmap <C-F5> <ESC>:tabprevious <CR>
imap <C-F5> <ESC>:tabprevious <CR> i
nmap <C-F6> <ESC>:tabnext<CR>
vmap <C-F6> <ESC>:tabnext <CR>
imap <C-F6> <ESC>:tabnext <CR> i
nmap <C-F7> <ESC>:tabnew <CR>
vmap <C-F7> <ESC>:tabnew <CR>
imap <C-F7> <ESC>:tabnew <CR> i
nmap <C-F8> <ESC>:tabclose <CR>
vmap <C-F8> <ESC>:tabclose <CR>
imap <C-F8> <ESC>:tabclose <CR> i
nmap <A-Up> :wincmd k <CR>
nmap <A-Down> :wincmd j <CR>
nmap <A-Left> :wincmd h <CR>
nmap <A-Right> :wincmd l <CR>
vmap <A-Up> :wincmd k <CR>
vmap <A-Down> :wincmd j <CR>
vmap <A-Left> :wincmd h <CR>
vmap <A-Right> :wincmd l <CR>
imap <A-Up> :wincmd k <CR> i
imap <A-Down> :wincmd j <CR> i
imap <A-Left> :wincmd h <CR> i
imap <A-Right> :wincmd l <CR> i
nmap <F9> <Esc><Esc>:TagbarToggle <CR>
vmap <F9> <Esc><Esc>:TagbarToggle <CR>
imap <F9> <Esc><Esc>:TagbarToggle <CR> i
nmap <F10> <ESC><Esc>:NERDTreeToggle <CR>
vmap <F10> <ESC><Esc>:NERDTreeToggle <CR>
imap <F10> <ESC><Esc>:NERDTreeToggle <CR>
nmap <F12> <ESC><Esc>:Explore <CR>
vmap <F12> <ESC><Esc>:Explore <CR>
imap <F12> <ESC><Esc>:Explore <CR>
nmap <S-F12> <Esc>:Texplore <CR>
vmap <S-F12> <Esc>:Texplore <CR>
imap <S-F12> <Esc>:Texplore <CR> i
nmap <C-F12> <Esc>:Vexplore <CR>
vmap <C-F12> <Esc>:Vexplore <CR>
imap <C-F12> <Esc>:Vexplore <CR> i
nmap <S-F5> <ESC>:call FindhlSearch() <CR>
vmap <S-F5> <ESC>:call FindhlSearch() <CR>
imap <S-F5> <ESC>:call FindhlSearch() <CR> i
nmap <S-F6> <ESC>:call EDCursorMovedhl() <CR>
vmap <S-F6> <ESC>:call EDCursorMovedhl() <CR>
imap <S-F6> <ESC>:call EDCursorMovedhl() <CR> i
nmap <A-F9> <ESC>:TMiniBufExplorer <CR>
vmap <A-F9> <ESC>:TMiniBufExplorer <CR>
imap <A-F9> <ESC>:TMiniBufExplorer <CR> i
nnoremap <F11> <ESC>:call ToggleFullScreen()<CR>
vnoremap <F11> <ESC>:call ToggleFullScreen()<CR>
inoremap <F11> <ESC>:call ToggleFullScreen()<CR> i
nnoremap <S-F11> <ESC>:NextColorScheme<CR>
vnoremap <S-F11> <ESC>:NextColorScheme<CR>
inoremap <S-F11> <ESC>:NextColorScheme<CR>
nnoremap <C-F11> <ESC>:PrevColorScheme<CR>
vnoremap <C-F11> <ESC>:PrevColorScheme<CR>
inoremap <C-F11> <ESC>:PrevColorScheme<CR>
vnoremap <silent>* <ESC>:call VisualSearch()<CR>/<C-R>/<CR>
vnoremap <silent># <ESC>:call VisualSearch()<CR>?<C-R>/<CR>

call SetColorschemeTime()

set go-=T
set go-=l
set go-=e
set go-=L
set go-=r
set go-=R
