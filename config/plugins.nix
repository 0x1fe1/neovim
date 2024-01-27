{
  config.plugins = {
    lualine.enable = true;
    luasnip.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    # hardtime.enable = true;
    nvim-autopairs.enable = true;
    comment-nvim.enable = true;
    todo-comments.enable = true;
    undotree.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    lsp-format.enable = true;
    lsp-lines.enable = true;
    indent-blankline.enable = true;

    trouble = {
      enable = true;
      signs = {
        error = "E";
        warning = "W";
        information = "I";
        hint = "H";
        other = "O";
      };
    };

    which-key = {
      enable = true;
      window.winblend = 10;
    };

    illuminate = {
      enable = true;
      delay = 1000;
    };

    nvim-ufo = {
      enable = true;
      preview.winConfig.winblend = 10;
    };

    harpoon = {
      enable = true;
      keymaps = {
        addFile = "<leader>a";
        toggleQuickMenu = "<leader>m";
        navFile = {
          "1" = "<C-1>";
          "2" = "<C-2>";
          "3" = "<C-3>";
          "4" = "<C-4>";
          "5" = "<C-5>";
          "6" = "<C-6>";
        };
      };
    };

    telescope = {
      enable = true;
      keymaps = {
        "<leader>?" = {
          action = "oldfiles";
          desc = "Recent Files (Telescope)";
        };
        "<leader><space>" = {
          action = "buffers";
          desc = "Buffers (Telescope)";
        };
        "<leader>gf" = {
          action = "git_files";
          desc = "[G]it [F]iles (Telescope)";
        };
        "<leader>sf" = {
          action = "find_files";
          desc = "[S]earch [F]iles (Telescope)";
        };
        "<leader>sh" = {
          action = "help_tags";
          desc = "[S]earch [H]elp (Telescope)";
        };
        "<leader>sw" = {
          action = "grep_string";
          desc = "[S]earch [W]ord (Telescope)";
        };
        "<leader>sg" = {
          action = "live_grep";
          desc = "[S]earch [G]rep (Telescope)";
        };
        "<leader>sd" = {
          action = "diagnostics";
          desc = "[S]earch [D]iagnostics (Telescope)";
        };
        "<leader>sr" = {
          action = "resume";
          desc = "[S]earch [R]esume (Telescope)";
        };
      };
    };

    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
        {name = "luasnip";}
      ];

      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = [
            "i"
            "s"
          ];
        };
        "<Tab>" = {
          action = "cmp.mapping.select_next_item()";
          modes = [
            "i"
            "s"
          ];
        };
      };
    };

    lspsaga = {
      enable = true;
      hover.openCmd = "!brave";
    };

    lsp = {
      enable = true;

      servers = {
        tsserver.enable = true;
        java-language-server.enable = true;
        bashls.enable = true;
        lua-ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        nixd = {
          enable = true;
          settings.formatting.command = "alejandra -qq";
        };
      };

      keymaps = {
        lspBuf = {
          K = "hover";
        };
      };

      onAttach = ''
        local function desc(description)
          return { noremap = true, silent = true, buffer = bufnr, desc = description }
        end

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc('[G]oto [D]efinition (LSP)'))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('[G]oto [D]eclaration (LSP)'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('[G]oto [I]mplementation (LSP)'))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc('[G]oto [R]eferences (LSP)'))
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, desc('[G]oto [T]ype definition (LSP)'))

        vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, desc('[C]ode [L]ens run (LSP)'))
        vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.refresh, desc('[C]ode lens [R]efresh (LSP)'))

        vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, desc('[D]ocument [S]ymbol (LSP)'))
        vim.keymap.set('n', '<leader>ih', function() vim.lsp.inlay_hint(bufnr) end, desc('[I]nlay [H]ints (LSP)'))

        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature Help (LSP)'))

        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, desc('Rename (LSP)'))
        vim.keymap.set('n', '<F3>', vim.lsp.buf.format, desc('Format buffer (LSP)'))
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, desc('Code Action (LSP)'))

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
      '';
    };
  };
}
