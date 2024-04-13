let
  # replaces all `foo = {};` with `foo.enable = true;` in the given set.
  mkEn = builtins.mapAttrs (name: value: {enable = true;});
in {
  config.plugins =
    mkEn {
      cmp-buffer = {};
      cmp-nvim-lsp = {};
      cmp-nvim-lsp-signature-help = {};
      cmp-path = {};
      cmp_luasnip = {};
      comment-nvim = {};
      copilot-vim = {};
      # emmet = {};
      fidget = {};
      indent-blankline = {};
      lsp-format = {};
      lsp-lines = {};
      lualine = {};
      luasnip = {};
      nvim-autopairs = {};
      rainbow-delimiters = {};
      todo-comments = {};
      treesitter = {};
      ts-autotag = {};
      ts-context-commentstring = {};
      undotree = {};
    }
    // {
      trouble = {
        enable = true;
        settings.signs = {
          error = "E";
          warning = "W";
          information = "I";
          hint = "H";
          other = "O";
        };
      };

      oil = {
        enable = true;
        deleteToTrash = true;
        skipConfirmForSimpleEdits = true;
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

      lspkind = {
        enable = true;
        cmp.enable = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];

          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      lspsaga = {
        enable = true;
        hover.openCmd = "!brave";
        lightbulb.virtualText = false;
      };

      lsp = {
        enable = true;
        servers =
          mkEn {
            bashls = {};
            biome = {};
            cssls = {};
            gopls = {};
            html = {};
            tsserver = {};
            clangd = {};
            # java-language-server = {};
          }
          // {
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
            pylsp = {
              enable = true;
              settings.plugins.autopep8.enabled = true;
            };
          };

        keymaps = {
          lspBuf = {
            K = "hover";
            gd = "definition";
            gD = "declaration";
            gi = "implementation";
            gr = "references";
            gt = "type_definition";
            "<F2>" = "rename";
            "<F3>" = "format";
            "<F4>" = "code_action";
          };
          diagnostic = {
            "<leader>e" = "open_float";
          };
        };

        onAttach =
          /*
          lua
          */
          ''
            local function desc(description)
              return { noremap = true, silent = true, buffer = bufnr, desc = description }
            end

            -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc('[G]oto [D]efinition (LSP)'))
            -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('[G]oto [D]eclaration (LSP)'))
            -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('[G]oto [I]mplementation (LSP)'))
            -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc('[G]oto [R]eferences (LSP)'))
            -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, desc('[G]oto [T]ype definition (LSP)'))

            -- vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, desc('Rename (LSP)'))
            -- vim.keymap.set('n', '<F3>', vim.lsp.buf.format, desc('Format buffer (LSP)'))
            -- vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, desc('Code Action (LSP)'))

            vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, desc('[C]ode [L]ens run (LSP)'))
            vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.refresh, desc('[C]ode lens [R]efresh (LSP)'))

            -- vim.keymap.set('n', '<leader>e', vim.diagnostics.open_float, desc('Open Diagnostics (LSP)'))
            vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, desc('[D]ocument [S]ymbol (LSP)'))
            vim.keymap.set('n', '<leader>ih', function() vim.lsp.inlay_hint(bufnr) end, desc('[I]nlay [H]ints (LSP)'))

            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature Help (LSP)'))


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
