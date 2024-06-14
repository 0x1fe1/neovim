let
  # replaces all `foo = {};` with `foo.enable = true;` in the given set.
  mkEn = builtins.mapAttrs (name: value: { enable = true; });
in
{
  config.plugins =
    mkEn
      {
        cmp-buffer = { };
        cmp-nvim-lsp = { };
        cmp-nvim-lsp-signature-help = { };
        cmp-path = { };
        cmp_luasnip = { };
        comment = { };
        # emmet = {};
        fidget = { };
        indent-blankline = { };
        lsp-format = { };
        # lsp-lines = { };
        lualine = { };
        nvim-autopairs = { };
        nvim-colorizer = { };
        rainbow-delimiters = { };
        todo-comments = { };
        treesitter = { };
        ts-autotag = { };
        ts-context-commentstring = { };
        undotree = { };
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
        settings = {
          skip_confirm_for_simple_edits = true;
          delete_to_trash = true;
        };
      };

      which-key = {
        enable = true;
        window.winblend = 10;
      };

      # illuminate = {
      #   enable = true;
      #   delay = 1000;
      # };

      nvim-ufo = {
        enable = true;
        preview.winConfig.winblend = 10;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>?" = {
            action = "oldfiles";
            options.desc = "Recent Files (Telescope)";
          };
          "<leader><space>" = {
            action = "buffers";
            options.desc = "Buffers (Telescope)";
          };
          "<leader>gf" = {
            action = "git_files";
            options.desc = "[G]it [F]iles (Telescope)";
          };
          "<leader>sf" = {
            action = "find_files";
            options.desc = "[S]earch [F]iles (Telescope)";
          };
          "<leader>sh" = {
            action = "help_tags";
            options.desc = "[S]earch [H]elp (Telescope)";
          };
          "<leader>sw" = {
            action = "grep_string";
            options.desc = "[S]earch [W]ord (Telescope)";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "[S]earch [G]rep (Telescope)";
          };
          "<leader>sd" = {
            action = "diagnostics";
            options.desc = "[S]earch [D]iagnostics (Telescope)";
          };
          "<leader>sr" = {
            action = "resume";
            options.desc = "[S]earch [R]esume (Telescope)";
          };
        };
      };

      lspkind = {
        enable = true;
        cmp.enable = true;
      };

      # adds a preset of snippets
      friendly-snippets.enable = true;
      luasnip = {
        enable = true;
        extraConfig = {
          enable_autosnippets = true;
        };
        fromVscode = [
          {
            include = [ "html" ];
            lazyLoad = true;
          }
        ];
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];

          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = /* lua */ ''
              cmp.mapping(function(fallback)
                  if cmp.visible() then
                      if require("luasnip").expandable() then
                          require("luasnip").expand()
                      else
                          cmp.confirm({select = true})
                      end
                  else
                      fallback()
                  end
              end)
            '';
            "<C-n>" = /* lua */ ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").locally_jumpable(1) then
                  require("luasnip").jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<C-p>" = /* lua */ ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").locally_jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };
        };
      };

      lspsaga = {
        enable = true;
        hover.openCmd = "!brave";
        lightbulb.virtualText = false;
      };

      clangd-extensions = {
        enable = true;
        enableOffsetEncodingWorkaround = true;
      };

      # copilot-lua = {
      #   enable = true;
      #   suggestion.keymap = {
      #     accept = "<A-y>";
      #     next = "<A-n>";
      #     prev = "<A-p>";
      #   };
      # };

      # none-ls = {
      #   enable = true;
      #   enableLspFormat = true;
      #   sources.formatting = {
      #     # google_java_format.enable = true;
      #     elm_format.enable = true;
      #   };
      # };

      lsp = {
        enable = true;
        servers =
          mkEn
            {
              bashls = { };
              # biome = {};
              clangd = { };
              cssls = { };
              elmls = { };
              jsonls = { };
              gopls = { };
              html = { };
              htmx = { };
              # java-language-server = {};
              tsserver = { };
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
              settings = {
                formatting.command = [ "nixpkgs-fmt" ];
                diagnostic.suppress = [ "sema-escaping-with" ];
                options = {
                  nixos.expr = ''(builtins.getFlake "/home/pango/system").nixosConfigurations.desktop.options'';
                  home_manager.expr = ''(builtins.getFlake "/home/pango/system").homeConfigurations.desktop.options'';
                };
              };
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
      };
    };
}
