local configs = require('nvim-treesitter.configs')
configs.setup {
  -- ensure_installed = 'all',
  auto_install = false, -- Do not automatically install missing parsers when entering buffer
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KiB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

-- require('treesitter-context').setup({
--   max_lines = 3,
-- })

-- Tree-sitter based folding
-- vim.opt.foldmethod = 'expr'
vim.g.skip_ts_context_commentstring_module = true
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
