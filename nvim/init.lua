vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '

vim.cmd.syntax('on')
vim.cmd.syntax('enable')
vim.opt.compatible = false

-- Enable true colour support
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

-- See :h <option> to see what the options do

-- Search down into subfolders
vim.opt.path = vim.o.path .. '**'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.showmatch = false -- Highlight matching parentheses, etc
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.history = 2000
vim.opt.nrformats = 'bin,hex,octal'
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.cmdheight = 0

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.updatetime = 50
vim.opt.timeoutlen = 500

-- vim.g.editorconfig = true -- TODO:
vim.opt.signcolumn = 'yes'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.backspace = { 'indent', 'eol', 'nostop' }
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4

vim.opt.colorcolumn = '120'
vim.cmd.colorscheme('catppuccin')

-- Configure Neovim diagnostic messages
vim.diagnostic.config({
  signs = true,
  update_in_insert = true,
  severity_sort = true,
})

-- Native plugins
vim.cmd.filetype('plugin', 'indent', 'on')
vim.cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
