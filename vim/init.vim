" Felix vimrc: owes a debt to SPF-13 amongst others
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

set nocompatible        " Must be first line


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
    "set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
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

" }

"  MAPPINGS {
    " Leader Bindings {
        " Registers
        nnoremap <leader>r :registers<CR>

        " toggle highlighting
        nmap <silent> <leader>/ :nohlsearch<CR>

        " <leader>b lists buffers and opens up switching
        nnoremap <leader>b :ls<CR>:b<space>

        " Open Ag
        nnoremap <leader>a :Ack<space>

        " Key for easy vimrc access
        nnoremap <leader>f :vsplit ~/.dotfiles/init.vim<CR>

        " Switch to alternate buffer
        nnoremap <leader><tab> <C-^>
    " }

    " Open help in new tab
    :cabbrev help tab help

    " shift tabs using H and L
    map <S-H> gT
    map <S-L> gt

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

    " NEOTERM
    nnoremap <leader>r :TREPLSendLine<cr>
" }

" Initialise Directories Function {

    function! InitializeDirectories()
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " Use standard XDG settings
        let common_dir = $HOME . '/.local/share/vim/'
        if exists("*mkdir")
            if !isdirectory(common_dir)
                call mkdir(common_dir)
            endif
        endif

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
                let directory = substitute(directory, " ", "\\\\ ", "g")  " replace spaces
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
" }
