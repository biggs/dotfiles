" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

set nocompatible        " Must be first line

" PATHOGEN {

    " include vim plugins in ./vim/bundle
    " To use with neovim and vim, use explicit ~/.vim paths
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('~/.vim/bundle/{}')
    call pathogen#helptags()

" }



" BASIC UI AND FORMATTING {
    set background=dark         " Assume a dark background
    colorscheme molokai
    set shell=/bin/zsh

    " Should be set automatically by neovim??
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set spell
    set spelllang=en_gb
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    "}


    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif


    if has('statusline')
        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    " Formatting
    set nowrap                      " Do not wrap long lines
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " Set the leader to space!
    let mapleader = ' '

    " vim has markdown syntax, but detects wrong filetype, fix here
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    " Strip whitespace on save {
    autocmd FileType c,cpp,java,php,javascript,lisp,python,xml,perl,sql autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

    function! StripTrailingWhitespace()
        " save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }
" }



"  MAPPINGS {
	" Open help in new tab
	:cabbrev help tab help

    " shift tabs using H and L
    map <S-H> gT
    map <S-L> gt

    " toggle highlighting
    nmap <silent> <leader>/ :nohlsearch<CR>

    " close fixit (sytastic) window
    nnoremap <leader>z :lclose<CR>

    " <leader>l lists buffers and opens up switching
    nnoremap <leader>l :ls<CR>:b<space>

    " Open Ag
    nnoremap <leader>a :Ack<space>

    " Set C-s to save. Needs stty -ixon option on
    nmap <c-s> :wa<CR>

    " Set Alt for easy window switching
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-l> <C-W>l
    map <C-h> <C-W>h


    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Yank from the cursor to EOL, now consistent with C and D.
    nnoremap Y y$

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>
" }



" PLUGINS CUSTOMISATIONS {

    " Airline
    let g:airline_exclude_preview = 0  " no change to popups
    let g:airline#extensions#bufferline#enabled = 0  " no buffer list in statusline
    let g:airline#extensions#bufferline#overwrite_variables = 0


    " Pymode
    let g:pymode_lint_checkers = ['pyflakes', 'mccabe']

    " ack.vim uses ag if exists {
        if executable('ag')
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
        endif
    " }

    " UndoTree toggle with <leader>u {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Python highlighting
    let python_highlight_all = 1

    " Set rainbow brackets on to start
    let g:rainbow_active = 1  " toggle with :RainbowToggle

    "Plugin 'tmhedberg/SimpylFold'
    let g:SimpylFold_fold_docstring = 0
    let g:SimpylFold_fold_import = 0

    " Syntastic settings {
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
        let g:syntastic_python_checkers = ['flake8']
    " }
    "
    "
    " NEOTERM
    nnoremap <leader>r :TREPLSendLine<cr>
" }








" Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
" }

