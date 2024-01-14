{
  config.plugins = {
    lualine.enable = true;
    luasnip.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    # hardtime.enable = true;
    nvim-autopairs.enable = true;
    comment-nvim.enable = true;

    lsp-format.enable = true;
    lsp-lines.enable = true;

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
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
    };
  };
}
