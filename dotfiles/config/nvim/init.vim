set clipboard^=unnamed,unnamedplus

set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.
set mouse=a                     " enable using the mouse if terminal emulator

set autoindent             " Indent according to previous line.
set copyindent             " copy the previous indentation on autoindenting
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.

set noshowmode             " Don't show mode since we have lightline
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set wrapscan               " Searches wrap around end-of-file.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set number relativenumber  " enable line numbers
set cursorline             " Find the current line quickly.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set scrolloff=4            " keep 4 lines off the edges of the screen when scrolling
"set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nobackup                    " do not keep backup files, it's 70's style cluttering
set nowritebackup               " do not write out changes via backup files
set noswapfile                  " do not write annoying intermediate swap files,
set undofile                    " keep a persistent undo file
set undodir=$HOME/.local/share/nvim/undo

"some things coc needs
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set guifont=DroidSansMono\ Nerd\ Font\ 11


"------  Disable Annoying Features  ------
" Wtf is Ex Mode anyways?
nnoremap Q <nop>

" Annoying window
map q: :q

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

let g:mapleader = "\<Space>"

" Plugins
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

"-------------------------------VISUALS
" Colorscheme
Plug 'joshdick/onedark.vim'
" A thingy at the bottom
Plug 'itchyny/lightline.vim'

" Because the qoutes are funny / starts vim with a fancy screen
Plug 'mhinz/vim-startify'

" cuz we want pretty icons in tree
Plug 'ryanoasis/vim-devicons'

"-------------------------------FUNCTIONAL
" Formatter for PHP
Plug 'aeke/vim-php-cs-fixer' 

" Commenting plugin by Tim!
Plug 'tpope/vim-commentary'

" The one and only
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Autocompleter, little bit of an overkill tbh
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" experimental, dont know if i'll use it enough
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'idanarye/vim-merginal'

" I would love an native solution, but can't find one FeelsBadMan
Plug 'lambdalisue/suda.vim'

" Snippetttss
Plug 'honza/vim-snippets'

" me want fancy ui me cool 
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

let g:coc_global_extensions = [
    \'@yaegassy/coc-intelephense',
    \'@yaegassy/coc-nginx',
    \'@yaegassy/coc-volar',
    \'coc-css',
    \'coc-docker',
    \'coc-eslint', 
    \'coc-explorer',
    \'coc-html', 
    \'coc-java',
    \'coc-json', 
    \'coc-php-cs-fixer', 
    \'coc-prettier', 
    \'coc-reacy-refactor', 
    \'coc-snippets', 
    \'coc-tsserver'
\]

set background=dark
colorscheme onedark

if !has('gui_running')
  set t_Co=256
endif

" ------ plugin options ------

"------------------- LIGHTLINE
let g:lightline = {
      \ 'colorscheme' : 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \   'right': [ ['gitbranch'] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"------------------- END LIGHTLINE

"------------------- COC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> ]g <Plug>(coc-diagnostic-prev)
nmap <silent> [g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"------------------- END COC

nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call CocAction('format')<CR>
autocmd BufWritePost *.php silent! call CocAction('format')

" ------ commands ------
"
cmap W w suda://%

" ------ basic maps ------
"These are to cancel the default behavior of x, X, c, C
"  to put the text they delete in the default register.
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
xnoremap P "_dP

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
nnoremap < <<
nnoremap > >>

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
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Ayy
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Ignore filenames when recursive searching
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <C-n> :CocCommand explorer<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>


" ------------- Vim-vugitive
nnoremap <Leader>gs :Git<CR> :Dispatch git fetch<CR>
nnoremap <Leader>gf :Dispatch git fetch<CR>
nnoremap <Leader>gl :0Gclog<CR>
nnoremap <Leader>gL :Gclog<CR>
nnoremap <Leader>gb :Git blame<CR>

" ------ autocmd ------

" Set tabsize on js/vue files
autocmd filetype javascript setlocal ts=2 sts=2 sw=2
autocmd filetype json setlocal ts=2 sts=2 sw=2
autocmd filetype typescript setlocal ts=2 sts=2 sw=2
autocmd filetype vue syntax sync fromstart
autocmd filetype vue setlocal ts=2 sts=2 sw=2
autocmd FileType scss setl iskeyword+=@-@


autocmd BufWritePost *.scss silent! call CocAction('format') 

" Make the dir if editing a file wihtout parent folder 
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

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
    au BufWritePost $HOME/.config/nvim/init.vim so $HOME/.config/nvim/init.vim
augroup END

" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "! gcc % -o %<; time ./%<"
        exec "! gcc % -o %<; ./%<"
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

" Prevent FZF commands from opening in none modifiable buffers
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree or Quickfix type
    if winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree' || &ft == 'qf')
        " Move one window to the right, then up
        wincmd l
        wincmd k
    endif
    exe a:cmd
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
