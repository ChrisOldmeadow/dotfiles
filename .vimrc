" BASIC SETUP:

" enter the current millenium
set nocompatible

" no need to save biffers before switching
set hidden

set scrolloff=8

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on
set expandtab
set shiftwidth=4
set softtabstop=4
set list
"makefiles need tabstops
autocmd Filetype make setlocal noexpandtab

set nohlsearch
set clipboard+=unnamedplus
" Add format option 'w' to add trailing white space, indicating that paragraph
" " continues on next line. This is to be used with mutt's 'text_flowed'
" option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

autocmd FileType markdown setlocal spell spelllang=en_au
autocmd FileType mail setlocal spell spelllang=en_au

set number relativenumber

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically source vimrc on save.
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmode=longest,list,full

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
nnoremap <leader>dd :Lexplore %:p:h<CR> " open netrw in directory of current file
nnoremap <Leader>da :Lexplore<CR> " open netrw in curretn working directory
" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" SNIPPETS:

" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/templates/skeleton.html<CR>3jwf>a
nnoremap ,rmd :-1read $HOME/.vim/templates/rmarkdown.Rmd<CR>3jwf>a

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)
" assuming you want to use snipmate snippet engine


" PLUGINS:
"
call plug#begin()
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
	Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
        Plug 'SirVer/ultisnips'
        Plug 'ncm2/ncm2-ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'vimwiki/vimwiki'
	Plug 'jalvesaq/Nvim-R'
	Plug 'gaalcaras/ncm-R'
	"Plug 'w0rp/ale'
        Plug 'bling/vim-bufferline'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-eunuch'
        Plug 'gruvbox-community/gruvbox'
        Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'MarcWeber/vim-addon-mw-utils'
	Plug 'tomtom/tlib_vim'
	Plug 'garbas/vim-snipmate'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'jamessan/vim-gnupg'
        Plug 'mattn/calendar-vim'
        Plug 'https://github.com/ap/vim-css-color'
"        Plug 'nvim-lua/popup.nvim'
"        Plug 'nvim-lua/plenary.nvim'
"        Plug 'nvim-telescope/telescope.nvim'
        Plug 'mhinz/vim-startify'
        Plug 'tpope/vim-commentary'
call plug#end()


" airline config
let g:airline_detect_spell=1
let g:airline_detect_iminsert=0


let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#capslock#enabled = 1
"  let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
"  let g:airline_statusline_ontop = 1
let g:airline_theme='dark'
let g:airline#extensions#tabline#buffer_nr_show = 1


" Ultisnp options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']


" SnipMate legacy parser
let g:snipMate = { 'snippet_version' : 0 }

" colour scheme
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
"set background=dark
"highlight Normal guibg=none

" Ale options
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 1
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {
\   'markdown':      ['mdl', 'writegood'],
\   'vimwiki':      [ 'markdownlint', 'proselint', 'redpen', 'remark_lint', 'textlint', 'vale', 'writegood'],
\   'r': ['namesever','lintr'],
\   'rmd': ['namesever','lintr','writegood']
\}

 let g:ale_fixers = {
 \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
 \   'rmd': ['styler'],
 \   'r': ['styler']
 \}

" use quickfix list instead of the loclist
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1


" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" remmaping so Esc works to go back to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

" nvim-r options
let R_term = 'st'
let R_assign = 0

autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
au BufRead,BufNewFile *.R set filetype=r


let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

set textwidth=80
autocmd FileType r setlocal formatoptions+=t
" Use Ctrl+Space to do omnicompletion:
   if has('nvim') || has('gui_running')
       inoremap <C-Space> <C-x><C-o>
   else
       inoremap <Nul> <C-x><C-o>
   endif

   " Press the space bar to send lines and selection to R:
   vmap <Space> <Plug>RDSendSelection
   nmap <Space> <Plug>RDSendLine

if &t_Co == 256
     let rout_color_input    = 'ctermfg=247'
     let rout_color_normal   = 'ctermfg=39'
     " etc.
   endif

let rout_follow_colorscheme = 1

 " vimwiki
 let g:vimwiki_list = [{'path': '~/Nextcloud/Notes/General',
               \ 'syntax': 'markdown', 'ext': '.md'},
               \ {'path': '~/Nextcloud/Notes/Computing',
               \ 'syntax': 'markdown', 'ext': '.md'},
               \ {'path': '~/Nextcloud/Notes/R',
               \ 'syntax': 'markdown', 'ext': '.md'},
               \   {'path': '~/Nextcloud/Notes/Goals',
               \ 'syntax': 'markdown', 'ext': '.md'},
               \   {'path': '~/Nextcloud/Notes/Management',
               \ 'syntax': 'markdown', 'ext': '.md'},
               \ {'path': '~/Nextcloud/Notes/Haskell',
               \ 'syntax': 'markdown', 'ext': '.md'}]


" working with todo lists in vimwiki
function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()    " To enable ncm2 for all buffers.
set completeopt=noinsert,menuone,noselect           " :help Ncm2PopupOpen for more
let g:ncm2#auto_popup = 1

" information
" Vim-gnugpg and encrypted vimwiki pages
let g:GPGDefaultRecipients = ["chris.oldmeadow@protonmail.com"]
let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.md\)\='


" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>g :Rg<CR>

" telescope
" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" navigating buffers

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" navigating quickfix

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" remapping locaiton lists
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>



" Commentry

nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

