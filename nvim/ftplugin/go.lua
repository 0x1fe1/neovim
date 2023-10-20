-- Exit if the language server isn't available
if vim.fn.executable('gopls') ~= 1 then
    return
end

local root_files = {
    "go.work",
    "go.mod",
    ".git",
}

vim.lsp.start {
    name = 'gopls',
    cmd = { 'gopls' },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
}