return {
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        opts = {
            -- transparent_background = true,
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme('catppuccin')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            options = {
                theme = 'catppuccin',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        opts = {
            highlight = { enable = true },
            auto_install = true,
        },
    },
    -- {
    --     'yamatsum/nvim-cursorline',
    --     opts = {},
    -- },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function()
            local highlight = {
                'ctpRed',
                'ctpPeach',
                'ctpYellow',
                'ctpGreen',
                'ctpSky',
                'ctpBlue',
                'ctpMauve',
            }

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

            require('ibl').setup({
                indent = { highlight = highlight, char = '┊' },
                scope = {
                    enabled = true,
                    show_start = true,
                    show_end = false,
                    injected_languages = false,
                    highlight = highlight,
                    priority = 500,
                },
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
    },
    {
        'NvChad/nvim-colorizer.lua',
        opts = {},
    },
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            highlight = { pattern = [[.*<(KEYWORDS)\s*]] },
            search = { pattern = [[\b(KEYWORDS)\b]] }
        },
    }, {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
},
    { 'mbbill/undotree' },
    { 'nvim-treesitter/playground' },
    { 'folke/zen-mode.nvim' },
    { 'eandrju/cellular-automaton.nvim' },
    {
        'theprimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
        end
    },
    { 'tpope/vim-fugitive' },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { 'xiyaowong/transparent.nvim', opts = {} },
    {
        'fedepujol/move.nvim',
        config = function()
            local opts = { noremap = true, silent = true }
            -- Normal-mode commands
            vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
            vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
            vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
            vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
            -- vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
            -- vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

            -- Visual-mode commands
            vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
            vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
            vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
            vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
        end
    },
}
