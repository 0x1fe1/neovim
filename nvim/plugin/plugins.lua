-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()
require('Comment').setup()
require("which-key").setup()

-- <harpoon>
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<C-5>", function() ui.nav_file(5) end)
vim.keymap.set("n", "<C-6>", function() ui.nav_file(6) end)
-- </harpoon>

-- <move>
-- Normal-mode commands
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', { noremap = true, silent = true })

-- Visual-mode commands
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', { noremap = true, silent = true })
-- </move>
