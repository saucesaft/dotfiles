scriptencoding utf-8
set encoding=utf-8

" mouse compatibility
set mouse=a

" line number
set number

" true colors
set termguicolors

" plugins
call plug#begin()

Plug 'levelone/tequila-sunrise.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ianks/vim-tsx'
Plug 'dense-analysis/ale'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'skywind3000/asyncrun.vim'

call plug#end()


" E F F I C I E N C Y
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" switch between files easily
nnoremap <Tab> :e# <CR>

" move tabs around
noremap <A-Left>  :tabmove -1<cr>
noremap <A-Right> :tabmove +1<cr>

" neovim cursor
" set guicursor=
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

" close tab/buffer
noremap <A-w>  :bd<cr>

" enable deoplete completion at startup
let g:deoplete#enable_at_startup = 1

" colorscheme
colorscheme tequila-sunrise

let g:airline#extensions#ale#enabled = 1

" magic to dissapear status
set noshowmode
set showcmd
set laststatus=2

let bn=len(getbufinfo({'buflisted':1}))

if bn > 1
	let g:airline#extensions#tabline#enabled = 1	
else
	let g:airline#extensions#tabline#enabled = 0
endif

let g:airline#extensions#tabline#buffer_nr_show = 0

nnoremap . :
nnoremap : .
"imap \| <esc>

let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
"let g:airline_extensions = []

" magic keybinds
source ~/.config/nvim/mswin.vim
behave mswin


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set shiftwidth=4

function! RunWithComment()
    let o = system('head -1 '. expand('%'))

    if &ft == 'py'
        let o = split(o, '# ')
    elseif &ft == 'go'
	let o = split(o, '// ')
    endif

    execute 'AsyncRun '. o[0]
endfunction

nnoremap <silent> <F5> :call RunWithComment()<CR>
