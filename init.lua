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

-- Terminal toggle (F4)
local function toggle_terminal()
  if vim.bo.buftype == "terminal" then
    vim.cmd("wincmd p")
  else
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_set_current_win(win)
        vim.cmd("startinsert")
        return
      end
    end
    vim.cmd("split | resize 10 | terminal pwsh.exe -NoLogo")
    vim.cmd("startinsert")
  end
end

vim.keymap.set({ "n", "v" }, "<F4>", toggle_terminal, { desc = "Toggle terminal split (pwsh)" })
vim.keymap.set("t", "<F4>", "<C-\\><C-n><C-w>p", { desc = "Switch from terminal to editor" })

-- Terminal configuration
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Automatically enter insert mode and hide line numbers in terminal",
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Automatically enter insert mode when focusing terminal",
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

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

-- LSP & Language Servers
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")

-- Autocompletion & Dropdown Menu (IntelliSense)
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")

vim.call("plug#end")

-- Keymap for Ctrl-P (Telescope)
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files (Ctrl-P)" })

-- Colorscheme
vim.cmd.colorscheme("tokyonight")

-- =============================================================================
-- LSP & Autocompletion (IntelliSense)
-- =============================================================================
local cmp_status, cmp = pcall(require, "cmp")
local luasnip_status, luasnip = pcall(require, "luasnip")
local mason_status, mason = pcall(require, "mason")
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_status and mason_lspconfig_status then
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { "pyright", "rust_analyzer", "powershell_es", "gopls" },
  })
end

-- Keymaps when LSP connects to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keybindings",
  callback = function(event)
    local opts = { buffer = event.buf }
    -- Hover doc / info (more info on class/function)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-Space>", vim.lsp.buf.hover, opts)

    -- Code navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Rename & diagnostics
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- Autocompletion (nvim-cmp)
if cmp_status and luasnip_status then
  local cmp_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = cmp_lsp_status and cmp_nvim_lsp.default_capabilities() or {}

  -- Pass completion capabilities globally to all LSP servers
  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  -- Enable configured language servers
  vim.lsp.enable({ "pyright", "rust_analyzer", "powershell_es", "gopls" })

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- Ctrl+Space to manually trigger dropdown / parameter info
      ["<C-Space>"] = cmp.mapping.complete(),
      -- Enter to confirm selection
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      -- Tab / Shift-Tab to cycle through dropdown options
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),
  })
end
