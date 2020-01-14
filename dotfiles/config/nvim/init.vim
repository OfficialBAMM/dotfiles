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
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
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
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nobackup                    " do not keep backup files, it's 70's style cluttering
set nowritebackup               " do not write out changes via backup files
set noswapfile                  " do not write annoying intermediate swap files,
set undofile                    " keep a persistent undo file
set undodir=$HOME/.local/share/nvim/undo


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
Plug 'dense-analysis/ale'

" File openeer because im too lazy to learn it the native way
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" To see npm versions in a package.json
Plug 'meain/vim-package-info'

" Commenting plugin by Tim!
Plug 'tpope/vim-commentary'

" The one and only
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Autocompleter, little bit of an overkill tbh
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" experimental, dont know if i'll use it enough
Plug 'tpope/vim-fugitive'

" I would love an native solution, but can't find one FeelsBadMan
Plug 'lambdalisue/suda.vim'
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
"------------------- END ALE

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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"------------------- END COC

" ------ commands ------
"
cmap w!! w suda://%
cmap W!! w suda://%

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

" Ayy
nnoremap <C-p> :Files<CR>

nnoremap <C-f> :Ag<CR>

nnoremap <Leader>w :w<CR>

" ------ autocmd ------
" Set tabsize on js/vue files
autocmd filetype javascript setlocal ts=2 sts=2 sw=2
autocmd filetype vue syntax sync fromstart
autocmd filetype vue setlocal ts=2 sts=2 sw=2
autocmd filetype php setlocal ts=4 sts=4 sw=4

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
