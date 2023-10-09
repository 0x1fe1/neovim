local lsp0 = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, buf)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = buf })

        keymap({ 'gd', vim.lsp.buf.definition, opts = { buffer = buf, desc = '[G]oto [D]efinition' } })
        keymap({ 'gD', vim.lsp.buf.declaration, opts = { buffer = buf, desc = '[G]oto [D]eclaration' } })
        keymap({ '<leader>D', vim.lsp.buf.type_definition, opts = { buffer = buf } })
        keymap({ 'K', vim.lsp.buf.hover, opts = { buffer = buf } })
        keymap({ 'gi', vim.lsp.buf.implementation, opts = { buffer = buf } })
        keymap({ 'gl', vim.diagnostic.open_float, opts = { buffer = buf } })

        keymap({ '<F2>', vim.lsp.buf.rename, opts = { buffer = buf } })
        keymap({ '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts = { buffer = buf } })
        keymap({ '<F4>', vim.lsp.buf.code_action, { buffer = buf, desc = '[C]ode [A]ction' } })

        keymap({ 'gr', require('telescope.builtin').lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' } })
        keymap({ 'gI', require('telescope.builtin').lsp_implementations,
            { buffer = buf, desc = '[G]oto [I]mplementation' } })
        keymap({ '<leader>ds', require('telescope.builtin').lsp_document_symbols,
            { buffer = buf, desc = '[D]ocument [S]ymbols' } })
        keymap({ '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = '[W]orkspace [S]ymbols' } })
    end)

    local lua_opts = lsp_zero.nvim_lua_ls()
    require('lspconfig').lua_ls.setup(lua_opts)

    local servers = {
        'rust_analyzer',
        'tsserver',
        'nil_ls',
        'svelte',
        'gopls',
        'zls',
    }
    lsp_zero.setup_servers(servers)

    local luasnip = require('luasnip')
    local cmp = require('cmp')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            { name = "crates" },
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
    })
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
        'folke/neodev.nvim',
    },
    config = function()
        lsp0()
        -- Switch for controlling whether you want autoformatting.
        --  Use :KickstartFormatToggle to toggle autoformatting on or off
        local format_is_enabled = true
        vim.api.nvim_create_user_command('KickstartFormatToggle', function()
            format_is_enabled = not format_is_enabled
            print('Setting autoformatting to: ' .. tostring(format_is_enabled))
        end, {})

        -- Create an augroup that is used for managing our formatting autocmds.
        --      We need one augroup per client to make sure that multiple clients
        --      can attach to the same buffer without interfering with each other.
        local _augroups = {}
        local get_augroup = function(client)
            if not _augroups[client.id] then
                local group_name = 'kickstart-lsp-format-' .. client.name
                local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                _augroups[client.id] = id
            end

            return _augroups[client.id]
        end

        -- Whenever an LSP attaches to a buffer, we will run this function.
        --
        -- See `:help LspAttach` for more information about this autocmd event.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
            -- This is where we attach the autoformatting for reasonable clients
            callback = function(args)
                local client_id = args.data.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local bufnr = args.buf

                -- Only attach to clients that support document formatting
                if not client.server_capabilities.documentFormattingProvider then
                    return
                end

                -- Tsserver usually works poorly. Sorry you work with bad languages
                -- You can remove this line if you know what you're doing :)
                if client.name == 'tsserver' then
                    return
                end

                -- Create an autocmd that will run *before* we save the buffer.
                --  Run the formatting command for the LSP that has just attached.
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = get_augroup(client),
                    buffer = bufnr,
                    callback = function()
                        if not format_is_enabled then
                            return
                        end

                        vim.lsp.buf.format {
                            async = false,
                            filter = function(c)
                                return c.id == client.id
                            end,
                        }
                    end,
                })
            end,
        })
    end
}
