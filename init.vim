"general
set number                     "add line numbers
set ruler                      "show column number
set splitbelow                 "split below
set splitright                 "vsplit right
set encoding=UTF-8             "always use UTF-8
set mouse=                     "disable mouse"
set nobackup                   "prevent tilde files from being generated
set wildmode=longest,list,full "longest/list are for bash-like tab completions. full is for wildmenu.
set backspace=indent,eol,start "fixes backspace on windows version of vim
syntax on                      "syntax highlighting

"tab settings to ensure no tab characters
"https://vim.fandom.com/wiki/Indenting_source_code
set softtabstop=2          "see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2           "determines the amount of whitespace to insert or remove for indentation
set expandtab              "converts tabs to white space

"search settings
set showmatch              "show matching
set ignorecase             "case insensitive
set incsearch              "incremental search
set path+=**               "provides tab-completion for all file-related tasks
set wildmenu               "display matches when we tab complete

"key mappings
"backslash is needed for escaping pipe characters
map <F3> :Explore<CR>
map <F4> :split \| resize 10 \| terminal<CR>

"on save rm trailing whitespace
"https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

"explore settings
let g:netrw_banner=0     "disable netrw banner
let g:netrw_liststyle=3  "tree view

"Plugins
call plug#begin()
"Appearance
Plug 'vim-airline/vim-airline'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Utilities
Plug 'sheerun/vim-polyglot'

"Completion/linters/formatters
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'plasticboy/vim-markdown'

"Git
Plug 'airblade/vim-gitgutter'
call plug#end()

"Colorscheme
colorscheme tokyonight

"Install coc extensions if they are missing
let g:coc_global_extensions=[ 'coc-snippets', 'coc-powershell' ]

