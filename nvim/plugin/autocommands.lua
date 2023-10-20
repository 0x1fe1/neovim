-- redefined in lsp_zero.lua
local api = vim.api

local tempdirgroup = api.nvim_create_augroup('tempdir', { clear = true })
-- Do not set undofile for files in /tmp
api.nvim_create_autocmd('BufWritePre', {
  pattern = '/tmp/*',
  group = tempdirgroup,
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

-- LSP
local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1])
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local function peek_type_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

--- Don't create a comment string when hitting <Enter> on a comment line
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DisableNewLineAutoCommentString', {}),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

--- `<K>` hover popup
local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ 'vim', 'help' }, filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'man' }, filetype) then
    vim.cmd('Man ' .. vim.fn.expand('<cword>'))
  elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.cmd.setlocal('signcolumn=yes')
    vim.bo[bufnr].bufhidden = 'hide'

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local function desc(description)
      return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc('[G]oto [D]efinition'))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('[G]oto [D]eclaration'))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('[G]oto [I]mplementation'))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc('[G]oto [R]eferences'))
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, desc('[G]oto [T]ype definition'))

    vim.keymap.set('n', '<leader>pd', peek_definition, desc('[P]eek [D]efinition'))
    vim.keymap.set('n', '<leader>pt', peek_type_definition, desc('[P]eek [T]ype definition'))

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, desc('[W]orkspace folder [A]dd'))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc('[W]orkspace folder [R]emove'))
    vim.keymap.set('n', '<leader>wl',
      function() vim.print(vim.lsp.buf.list_workspace_folders()) end, desc('[W]orkspace folders [L]ist'))
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, desc('[W]orkspace [S]ymbol'))

    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, desc('[C]ode [L]ens run'))
    vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.refresh, desc('[C]ode lens [R]efresh'))

    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, desc('[D]ocument [S]ymbol'))
    vim.keymap.set('n', '<leader>ih', function() vim.lsp.inlay_hint(bufnr) end, desc('[I]nlay [H]ints'))

    vim.keymap.set('n', 'K', show_documentation, desc('Hover Help'))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature Help'))

    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, desc('Rename'))
    vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format { async = true } end, desc('Format buffer'))
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, desc('Code Action'))

    -- Auto-refresh code lenses
    if not client then
      return
    end
    local function buf_refresh_codeLens()
      vim.schedule(function()
        if client.server_capabilities.codeLensProvider then
          vim.lsp.codelens.refresh()
          return
        end
      end)
    end
    local group = api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
        group = group,
        callback = buf_refresh_codeLens,
        buffer = bufnr,
      })
      buf_refresh_codeLens()
    end
  end,
})

require('lsp-zero').setup_servers({ 'tsserver', 'rust_analyzer' })
