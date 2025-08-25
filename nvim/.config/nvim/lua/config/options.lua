-- Basic Settings
vim.opt.number = true -- line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- keep 8 columns left/right of the cursor
vim.opt.wrap = false -- don't wrap lines
vim.opt.cmdheight = 1 -- command line height
vim.opt.spelllang = { "en" } -- set language for spellchecking


-- Personal preferences
vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop
vim.opt.smartindent = true -- smart auto indenting
vim.opt.autoindent = true -- copy indent from current line
vim.opt.grepprg =  "rg --vimgrep" -- use ripgrep if available
vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line num, column, content

-- Search settings
vim.opt ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- case-sensitive if uppercase in search
vim.opt hlsearch = false -- don't highlight search results
vim.opt.incsearch = true -- show matches as you type

-- Visual Settings
vim.opt.termguicolors = true -- enable 24-bit colors
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.colorcolumn = "100" -- show column at 100 characters
vim.opt.showmatch = true -- highlight matching bracket
vim.opt.matchtime = 2 -- how long to show matching brackets
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- don't hide markup
vim.opt.concealcursor = " " -- show markup even on cursor line
vim.opt.lazyredraw = false -- redraw while executing macros, better UX
vim.opt.redrawtime = 10000 -- timeout for syntax highlighting redraw
vim.opt.maxmempattern = 20000 -- max memory for pattern matching
vim.opt.synmaxcol = 300 -- syntax matching column limit

-- File Handling
vim.opt.backup = false -- don't create backup files
vim.opt.writebackup = false -- don't backup before overwriting
vim.opt.swapfile = false -- don't create swap files
vim.opt.undofile = true -- persistent undo
vim.opt.updatetime = 300 -- time in ms to trigger CursorHold
vim.opt.timeoutlen = 500 -- time in ms to wait for mapped sequence
vim.opt.ttimeoutlen = 0 -- no wait for key code sequences
vim.opt.autoread = true -- auto reload file if changed outside
vim.opt.autowrite =  false -- don't autosave on some events
vim.opt.diffopt:append("vertical") -- vertical diff splits
vim.opt.diffopt:append("algorithm:patience") -- better diff algorithm
vim.opt.diffopt:append("linematch:60") -- better diff highlighting (smart line matching)

-- Set undodirectory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p") -- create if doesn't exist
end

-- Behavior Settings
vim.opt.errorbells = false -- disable error sounds
vim.opt.backspace = "indent,eol,start" -- make backspace behave naturally
vim.opt.autochdir = false -- don't change directory automatically
vim.opt.iskeyword:append("-") -- treat dash as part of word
vim.opt.path:append("**") -- search into subfolders with 'gf'
vim.opt.selection = "inclusive" -- use inclusive search
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow editing buffers
vim.opt.encoding = "UTF-8" -- use UTF-8 encoding
vim.opt.wildmenu = true -- enable command-line completion menu
vim.opt.wildmode = "longest:full, full" -- completion mode for commandline
vim.opt.wildignorecase = true -- case-insensitive tab completion in commands

-- Cursor Settings
vim.opt.guicursor {
	"n-v-c:block", -- Normal, Visual, Command-line
	"i-ci-ve:block", -- Insert, Command-line Insert, Visual-exclusive
	"r-cr:hor20", -- Replace, Command-line Replace
	"o:hor50", -- Operator-pending
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
}

-- Folding Settings
vim.opt.foldmethod = "expr" 
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- keep all folds open by default

-- Split behavior
vim.opt.splitbelow = true -- horizontal splits open below
vim.opt.splitright = true -- vertical splits open to the right
