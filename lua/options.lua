vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.numberwidth = 4
vim.opt.cursorline = false
vim.opt.breakindent = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.showmode = false
vim.opt.conceallevel = 0

vim.opt.updatetime = 50
vim.opt.timeoutlen = 500

vim.opt.signcolumn = 'yes'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
-- vim.opt.guicursor = 'a:hor25,v:block,i:ver25'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.backspace = 'indent,eol,nostop'
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

vim.diagnostic.config({
    signs = true,
    update_in_insert = true,
    severity_sort = true,
})

vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.cmd([[
--   autocmd FileType go setlocal tabstop=2 shiftwidth=2 expandtab
-- ]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


