-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()
require('Comment').setup()
require("which-key").setup()
require('crates').setup()
require("fidget").setup()
require("nvim-autopairs").setup({})

--<harpoon>--
; (function()
  local ui = require("harpoon.ui")
  local mark = require("harpoon.mark")

  keymap({ "<leader>a", mark.add_file })
  keymap({ "<leader>m", ui.toggle_quick_menu })

  keymap({ "<C-1>", function() ui.nav_file(1) end })
  keymap({ "<C-2>", function() ui.nav_file(2) end })
  keymap({ "<C-3>", function() ui.nav_file(3) end })
  keymap({ "<C-4>", function() ui.nav_file(4) end })
  keymap({ "<C-5>", function() ui.nav_file(5) end })
  keymap({ "<C-6>", function() ui.nav_file(6) end })
end)()
--<harpoon>--

--<gomove>--
; (function()
  --- Move
  keymap({ '<A-j>', ':MoveLine(1)<CR>', opts = { noremap = true, silent = true } })
  keymap({ '<A-k>', ':MoveLine(-1)<CR>', opts = { noremap = true, silent = true } })
  keymap({ '<A-h>', ':MoveHChar(-1)<CR>', opts = { noremap = true, silent = true } })
  keymap({ '<A-l>', ':MoveHChar(1)<CR>', opts = { noremap = true, silent = true } })

  keymap({ '<A-j>', ':MoveBlock(1)<CR>', mode = 'v', opts = { noremap = true, silent = true } })
  keymap({ '<A-k>', ':MoveBlock(-1)<CR>', mode = 'v', opts = { noremap = true, silent = true } })
  keymap({ '<A-h>', ':MoveHBlock(-1)<CR>', mode = 'v', opts = { noremap = true, silent = true } })
  keymap({ '<A-l>', ':MoveHBlock(1)<CR>', mode = 'v', opts = { noremap = true, silent = true } })

  --- Duplicate
  keymap({ '<S-A-j>', 'Vyp', opts = { noremap = true, silent = true } })
  keymap({ '<S-A-k>', 'Vypk', opts = { noremap = true, silent = true } })

  keymap({ '<S-A-j>', 'Vyp', mode = 'v', opts = { noremap = true, silent = true } })
  keymap({ '<S-A-k>', 'Vypk', mode = 'v', opts = { noremap = true, silent = true } })
end)()
--<gomove>--

--<indent blank line>--
; (function()
  local hooks = require 'ibl.hooks'
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'ctpRed', { fg = '#F38BA8', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpPeach', { fg = '#FAB387', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpYellow', { fg = '#F9E2AF', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpGreen', { fg = '#A6E3A1', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpSky', { fg = '#89DCEB', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpBlue', { fg = '#89B4FA', blend = 100 })
    vim.api.nvim_set_hl(0, 'ctpMauve', { fg = '#CBA6F7', blend = 100 })
  end)

  local highlight = {
    'ctpRed',
    'ctpPeach',
    'ctpYellow',
    'ctpGreen',
    'ctpSky',
    'ctpBlue',
    'ctpMauve',
  }

  require('ibl').setup({
    indent = { highlight = highlight, char = '┊' },
    scope = {
      enabled = false,
      -- show_start = true,
      -- show_end = false,
      -- injected_languages = false,
      -- highlight = highlight,
      -- priority = 500,
    },
  })
end)()
--<indent blank line>--

--<ufo>--
; (function()
  vim.opt.foldcolumn = '0' -- '0' is not bad
  vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
  vim.opt.foldlevelstart = 99
  vim.opt.foldenable = true
  vim.opt.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:▶]]
  vim.cmd("highlight Folded guibg=none")

  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  keymap({ 'zR', require('ufo').openAllFolds })
  keymap({ 'zM', require('ufo').closeAllFolds })

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end

  ---@diagnostic disable-next-line: missing-fields
  require('ufo').setup({
    provider_selector = function(_, _, _) -- (bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    fold_virt_text_handler = handler,
    open_fold_hl_timeout = 10,
  })
end)()
--<ufo>--

--<lsp_signature>--
; (function()
  require("lsp_signature").setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    },
    hint_prefix = "~~> ",
  })
end)()
--<lsp_signature>--
