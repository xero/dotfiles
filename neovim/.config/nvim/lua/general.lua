--                                     ██
--                                    ░░
--  ███████   █████   ██████  ██    ██ ██ ██████████
-- ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
--  ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
--  ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
--  ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
-- ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ xero <x@xero.style>
-- ░▓ code   ▓ https://code.x-e.ro/dotfiles
-- ░▓ mirror ▓ https://git.io/.files
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░
--
-- security
vim.opt.modelines = 0

-- hide buffers, not close them
vim.opt.hidden = true

-- maintain undo history between sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.swapfile = false

-- fuzzy find
vim.opt.path:append '**'
-- lazy file name tab completion
vim.opt.wildmode = 'longest,list,full'
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
-- ignore files vim doesnt use
vim.opt.wildignore:append '.git,.hg,.svn'
vim.opt.wildignore:append '.aux,*.out,*.toc'
vim.opt.wildignore:append '.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class'
vim.opt.wildignore:append '.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp'
vim.opt.wildignore:append '.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg'
vim.opt.wildignore:append '.mp3,*.oga,*.ogg,*.wav,*.flac'
vim.opt.wildignore:append '.eot,*.otf,*.ttf,*.woff'
vim.opt.wildignore:append '.doc,*.pdf,*.cbr,*.cbz'
vim.opt.wildignore:append '.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb'
vim.opt.wildignore:append '.swp,.lock,.DS_Store,._*'

-- case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

-- make backspace behave in a sane manner
vim.opt.backspace = 'indent,eol,start'

-- searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- use indents of 2 spaces
vim.opt.shiftwidth = 2

-- tabs are tabs
vim.opt.expandtab = false

-- an indentation every 2 columns
vim.opt.tabstop = 2

-- let backspace delete indent
vim.opt.softtabstop = 2

-- enable auto indentation
vim.opt.autoindent = true

-- remove trailing whitespaces and ^M chars
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- set leader key to comma
vim.g.mapleader = ","

-- ipad
vim.opt.mouse = a