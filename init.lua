-- General
vim.opt.number = true                           -- add line numbers
vim.opt.ruler = true                            -- show column number
vim.opt.splitbelow = true                       -- split below
vim.opt.splitright = true                       -- vsplit right
vim.opt.encoding = "utf-8"                      -- always use UTF-8
vim.opt.mouse = ""                              -- disable mouse
vim.opt.backup = false                          -- prevent tilde files from being generated
vim.opt.wildmode = { "longest", "list", "full" } -- longest/list are for bash-like tab completions. full is for wildmenu.
vim.opt.backspace = { "indent", "eol", "start" } -- fixes backspace on windows version of vim
vim.cmd("syntax on")                            -- syntax highlighting

vim.opt.guicursor:append("i:block-blinkon500-blinkoff500-blinkwait1000")
vim.opt.guicursor:append("n:block-blinkon500-blinkoff500-blinkwait1000")
vim.opt.guicursor:append("ci:block-blinkon500-blinkoff500-blinkwait1000")
vim.opt.guicursor:append("ve:block-blinkon500-blinkoff500-blinkwait1000")

-- Tab settings to ensure no tab characters
-- https://vim.fandom.com/wiki/Indenting_source_code
vim.opt.softtabstop = 2                         -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.shiftwidth = 2                          -- determines the amount of whitespace to insert or remove for indentation
vim.opt.expandtab = true                        -- converts tabs to white space

-- Search settings
vim.opt.showmatch = true                        -- show matching
vim.opt.ignorecase = true                       -- case insensitive
vim.opt.incsearch = true                        -- incremental search
vim.opt.path:append("**")                       -- provides tab-completion for all file-related tasks
vim.opt.wildmenu = true                         -- display matches when we tab complete

-- Key mappings
-- backslash is not needed for escaping pipe characters in Lua
vim.keymap.set({ "n", "v" }, "<F3>", "<cmd>Explore<CR>")

-- On save rm trailing whitespace
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[:%s/\s\+$//e]],
})

-- Explore settings
vim.g.netrw_banner = 0                          -- disable netrw banner
vim.g.netrw_liststyle = 3                       -- tree view

-- Plugins
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Appearance
Plug("vim-airline/vim-airline")
Plug("folke/tokyonight.nvim", { ["branch"] = "main" })

-- Git
Plug("airblade/vim-gitgutter")

-- Fuzzy finder (Ctrl-P)
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })

vim.call("plug#end")

-- Keymap for Ctrl-P (Telescope)
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files (Ctrl-P)" })

-- Colorscheme
vim.cmd.colorscheme("tokyonight")
