{ pkgs ? import <nixpkgs> {} }:
let
  # replaces all `foo = {};` with `foo.enable = true;` in the given set.
  mkEn = builtins.mapAttrs (name: value: { enable = true; });
in
{
  config.plugins =
    mkEn
      {
        cmp-buffer = {};
        cmp-path = {};
        comment = {};
        # fidget = {};
        lualine = {};
        rainbow-delimiters = {};
        trim = {};
        ts-autotag = {};
        ts-context-commentstring = {};
        undotree = {};
        transparent = {};
      }
    // {
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          RGB = true;
          RRGGBB = true;
          RRGGBBAA = true;
          css_fn = true;
          names = false;
          mode = "virtualtext";
	  virtualtext = "██";
        };
      };

      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

      # trouble = {
      #   enable = true;
      #   settings.signs = {
      #     error = "E";
      #     warning = "W";
      #     information = "I";
      #     hint = "H";
      #     other = "O";
      #   };
      # };

      oil = {
        enable = true;
        settings = {
          skip_confirm_for_simple_edits = true;
          delete_to_trash = true;
        };
      };

      which-key = {
        enable = true;
        settings.win.wo.winblend = 10;
      };

      fzf-lua = {
        enable = true;
        settings = {
          winopts.preview.default = "bat";
        };
        keymaps = {
          "<leader>sb" = {
            action = "buffers";
            options.desc = "[S]earch [B]uffers (Fzf-Lua)";
          };
          "<leader>sf" = {
            action = "files";
            options.desc = "[S]earch [F]iles (Fzf-Lua)";
          };
          "<leader>st" = {
            action = "tags_live_grep";
            options.desc = "[S]earch [T]ags (Fzf-Lua)";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "[S]earch [G]rep (Fzf-Lua)";
          };
          "<leader>sr" = {
            action = "resume";
            options.desc = "[S]earch [R]esume (Fzf-Lua)";
          };
          "<leader>sh" = {
            action = "helptags";
            options.desc = "[S]earch [H]elp (Fzf-Lua)";
          };
          "<leader>sm" = {
            action = "manpages";
            options.desc = "[S]earch [M]anpages (Fzf-Lua)";
          };
          "<leader>sd" = {
            action = "diagnostics_document";
            options.desc = "[S]earch [D]iagnostics (Fzf-Lua)";
          };
          "<leader>sl" = {
            action = "lsp_finder";
            options.desc = "[S]earch [L]sp (Fzf-Lua)";
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "path"; }
            { name = "buffer"; }
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<C-N>" = "cmp.mapping.scroll_docs(4)";
            "<C-P>" = "cmp.mapping.scroll_docs(-4)";
            "<C-y>" = /* lua */ ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.confirm({select = true}) else fallback() end
              end)
            '';
            "<C-n>" = /* lua */ ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item() else fallback() end
              end, { "i", "s" })
            '';
            "<C-p>" = /* lua */ ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_prev_item() else fallback() end
              end, { "i", "s" })
            '';
          };
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = false;
        sources = {
          hover.dictionary.enable = true;
          completion.tags.enable = true;
        };
      };
    };
}
