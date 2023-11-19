-- mode
--  "n" - normal mode
--  "i" - insert mode
--  "x" - visual mode
--  "v" - visual and select mode

-- keymap object is { lhs, rhs, opts = {}, mode = string }
keymap = function(keymap)
  keymap.opts = vim.tbl_deep_extend('force', keymap.opts or {}, { noremap = true, silent = true })
  ---@diagnostic disable-next-line: param-type-mismatch
  keymap.mode = keymap.mode and vim.split(keymap.mode, ' ', {}) or 'n'

  vim.keymap.set(keymap.mode, keymap[1], keymap[2], keymap.opts)
end

-- disable arrow keys
-- keymap({ '<Down>', '<Nop>', mode = 'n i' })
-- keymap({ '<Up>', '<Nop>', mode = 'n i' })
-- keymap({ '<Left>', '<Nop>', mode = 'n i' })
-- keymap({ '<Right>', '<Nop>', mode = 'n i' })

keymap({ '<C-S-k>', '<cmd>bnext<CR>', mode = 'n i' })
keymap({ '<C-S-j>', '<cmd>bprev<CR>', mode = 'n i' })

keymap({ '<C-h>', '<C-w>h', mode = 'n i' })
keymap({ '<C-j>', '<C-w>j', mode = 'n i' })
keymap({ '<C-k>', '<C-w>k', mode = 'n i' })
keymap({ '<C-l>', '<C-w>l', mode = 'n i' })

keymap({ '<', '<gv', mode = 'x' })
keymap({ '>', '>gv', mode = 'x' })

keymap({ '<C-s>', '<cmd>w<CR>', mode = 'n x i' })

keymap({ '<C-u>', '<C-u>zz', mode = 'n x i' })
keymap({ '<C-d>', '<C-d>zz', mode = 'n x i' })

keymap({ '<A-k>', '<cmd>move -2<CR>', mode = 'n x i' })
keymap({ '<A-j>', '<cmd>move +1<CR>', mode = 'n x i' })

keymap({ '<leader>x', [["_x]], mode = 'n x' })
keymap({ '<leader>d', [["_d]], mode = 'n x' })

keymap({ 'Q', '<nop>', mode = 'n x' })
keymap({ 'q:', '<nop>', mode = 'n x' })

keymap({ '<C-r>', 'nop' })
keymap({ '<S-u>', '<cmd>redo<CR>' })

-- keymap({ '-', '<cmd>Oil<CR>' })
-- '<leader>f', vim.lsp.buf.format

-- Remap for dealing with word wrap
keymap({ 'k', "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, silent = true } })
keymap({ 'j', "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, silent = true } })

-- Diagnostic keymaps
-- keymap({ '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' } })
-- keymap({ ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' } })
keymap({ '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' } })
keymap({ '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' } })

-- Remap Esc to switch to normal mode and Ctrl-Esc to pass Esc to terminal
keymap({ '<Esc>', '<C-\\><C-n>', mode = 't', opts = { desc = 'switch to normal mode' } })
keymap({ '<C-Esc>', '<Esc>', mode = 't', opts = { desc = 'send Esc to terminal' } })

keymap({ '<C-d>', '<C-d>zz', mode = 'n x', opts = { desc = 'move down half-page and center' } })
keymap({ '<C-u>', '<C-u>zz', mode = 'n x', opts = { desc = 'move up half-page and center' } })
keymap({ '<C-f>', '<C-f>zz', mode = 'n x', opts = { desc = 'move down full-page and center' } })
keymap({ '<C-b>', '<C-b>zz', mode = 'n x', opts = { desc = 'move up full-page and center' } })

keymap({ 'p', 'P', mode = 'x', opts = { desc = 'do not copy the text, that was pasted over' } })
keymap({ '<C-z>', '<NOP>', opts = { desc = 'do not suspend' } })
keymap({ '-', '<NOP>' })
keymap({ '+', '<NOP>' })
keymap({ '=', '<NOP>' })
