" system clipboard (requires +clipboard)
set clipboard^=unnamed,unnamedplus

" additional settings
set modeline                " enable vim modelines
set hlsearch                " highlight search items
set incsearch               " searches are performed as you type
set number relativenumber   " enable line numbers
set confirm                 " ask confirmation like save before quit.
set wildmenu                " Tab completion menu when using command mode
set expandtab               " Tab key inserts spaces not tabs
set softtabstop=4           " spaces to enter for each tab
set shiftwidth=4            " amount of spaces for indentation
set shortmess+=aAcIws       " Hide or shorten certain messages
set mouse=a                 " enable mouse
syntax enable               " syntax highlighting
set linebreak breakindent
set list listchars=tab:>>,trail:~

let g:mapleader = "\<Space>"

" Plugins
call plug#begin()

"-------------------------------VISUALS
" Vue highlighting plugin
Plug 'posva/vim-vue'

" Colorscheme
" Plug 'tyrannicaltoucan/vim-quantum'
Plug 'joshdick/onedark.vim'

" A thingy at the bottom
Plug 'itchyny/lightline.vim'

" Because the qoues are funny / starts vim with a fancy screen
Plug 'mhinz/vim-startify'

"-------------------------------FUNCTIONAL
" linter
Plug 'w0rp/ale'

" File openeer because im too lazy to learn it the native way
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" To see npm versions in a package.json
Plug 'meain/vim-package-info'

" Commenting plugin by Tim!
Plug 'tpope/vim-commentary'

" The one and only
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" experimental, dont know if i'll use it enough
Plug 'tpope/vim-fugitive'

call plug#end()

set background=dark
colorscheme onedark

" ------ plugin options ------
map <C-n> :NERDTreeToggle<CR>

"------------------- ALE
" The fixers ALE is allowed to use
let g:ale_fixers = ['eslint']

" LET ALE fix on save
let g:ale_fix_on_save = 1

" ------ commands ------
"
command Wsudo w !sudo tee "%" > /dev/null
command W w

" ------ basic maps ------
"These are to cancel the default behavior of d, D, c, C
"  to put the text they delete in the default register.
"  Note that this means e.g. "ad won't copy the text into
"  register a anymore.  You have to explicitly yank it.
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" Also dont overwrite on paste, super annoying
xnoremap p "_dP

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" alt defaults
nnoremap 0 ^
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv

" re-visual text after changing indent
vnoremap > >gv
vnoremap < <gv

" gj/k but preserve numbered jumps ie: 12j or 45k
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'

" Disable previous highlight
nnoremap <esc> :noh<return><esc>

" tab control
nnoremap <silent> <M-j> :tabmove -1<CR>
nnoremap <silent> <M-k> :tabmove +1<CR>
nnoremap <silent> <Leader>ti :tabnew<CR>
nnoremap <silent> <Leader>tn :tabnext<CR>
nnoremap <silent> <Leader>tf :tabfirst<CR>
nnoremap <silent> <Leader>tp :tabprevious<CR>

" Ayy
nnoremap <C-p> :Files<CR>

nnoremap <C-f> :Ag<CR>

" ------ autocmd ------
" Set tabsize on js/vue files
autocmd filetype javascript setlocal ts=2 sts=2 sw=2
autocmd FileType vue syntax sync fromstart
autocmd Filetype vue setlocal ts=2 sts=2 sw=2

" Reload changes if file changed outside of vim requires autoread
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END

" when quitting a file, save the cursor position
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

augroup load_vimrc_when_changed
    au!
    au BufWritePost $XDG_CONFIG_HOME/nvim/init.vim so $XDG_CONFIG_HOME/nvim/init.vim 
augroup END

" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "! time bash %"
    elseif &filetype == 'python'
       exec "! time python %"
    endif
endfunction

" strip trailing whitespace, ss (strip space)
nnoremap <silent> <Leader>ss
    \ :let b:_p = getpos(".") <Bar>
    \  let b:_s = (@/ != '') ? @/ : '' <Bar>
    \  %s/\s\+$//e <Bar>
    \  let @/ = b:_s <Bar>
    \  nohlsearch <Bar>
    \  unlet b:_s <Bar>
    \  call setpos('.', b:_p) <Bar>
    \  unlet b:_p <CR>

" global replace
vnoremap <Leader>rw "hy
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep."/".b:sub.'/g' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>
nnoremap <Leader>sw
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/g' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>

" prompt before each replace
vnoremap <Leader>cw "hy
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep.'/'.b:sub.'/gc' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>

nnoremap <Leader>cw
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/gc' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>
