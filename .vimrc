

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

set nu rnu
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug Plugins

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" leave some space in between
if (has('nvim') && v:version > 500)
	Plug 'projekt0n/github-nvim-theme'
endif

Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'NLKNguyen/papercolor-theme'

if has('nvim') || (!has('nvim') && v:version > 900)
	Plug 'github/copilot.vim'
endif
if (has('nvim') && v:version > 400) || (!has('nvim') && v:version > 800)
	Plug 'neoclide/coc.nvim'
endif

call plug#end()

" we will add keybinds below this comment.
"Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = 'â–¸'
let g:NERDTreeDirArrowCollapsible = 'â–¾'

nnoremap <C-t> :NERDTreeToggle<CR>
if (has('nvim') && v:version > 400) || (!has('nvim') && v:version > 800)

	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gr <Plug>(coc-references)
	
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
	
	nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

	nmap <leader>do <Plug>(coc-codeaction)
	
	nmap <leader>rn <Plug>(coc-rename)

endif

" color scheme 
if (has('termguicolors'))
  set termguicolors
endif
if has('nvim')
	colorscheme github_dark_default
endif
if !has('nvim')
	" pass
	set laststatus=2
	set background=dark
	colorscheme PaperColor
	set encoding=UTF-8
endif



" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
if !has('nvim')
	source $VIMRUNTIME/defaults.vim
endif


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

