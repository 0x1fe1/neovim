{ inputs
, pkgs
, lib
, ...
}:
let
  # from github.com/mrcjkb/kickstart-nix.nvim
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  keymaps = import ./keymaps.nix { inherit lib; };
  plugins = import ./plugins.nix { inherit pkgs; };
in
{
  # Import all your configuration modules here
  imports = [
    plugins
    ./options.nix
    keymaps
  ];

  config = {
    # colorschemes.tokyonight.enable = true;
    colorschemes.catppuccin.enable = true;
    # colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      # hover-nvim
      vim-move
      harpoon2
      # guard-nvim
      # guard-collection

      # (mkNvimPlugin inputs.kitty-scrollback "kitty-scrollback")
      # (mkNvimPlugin inputs.indentmini "indentmini")
    ];

    extraPackages = with pkgs; [
      xclip
      alejandra
    ];

    autoCmd = [
      # Highlight on Yank
      {
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        group = "YankHighlight";
        callback = {
          __raw = ''
            function()
              vim.highlight.on_yank({
                higroup = 'IncSearch',
                timeout = 40,
              })
            end
          '';
        };
      }

      # Open help window in a vertical split to the right.
      # {
      #   event = [ "BufWinEnter" ];
      #   pattern = [ "*.txt" ];
      #   group = "vim.api.nvim_create_augroup(\"help_window_right\", {})";
      #   callback.__raw = ''function()
      #     if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
      #   end'';
      # }
    ];

    autoGroups = {
      YankHighlight.clear = true;
    };

    highlight = {
      foo = {
        fg = "#808080";
      };
    };

    # extraFiles =
    #   let
    #     text = ''
    #       vim.opt.tabstop = 2
    #       vim.opt.shiftwidth = 2
    #       vim.opt.expandtab = true
    #     '';
    #   in
    #   {
    #     "ftplugin/nix.lua".text = text;
    #     # "ftplugin/toml.lua".text = text;
    #     # "ftplugin/c.lua".text = text;
    #   };

    extraConfigLuaPost = /* lua */ ''
      -- '#F38BA8', '#FAB387', '#F9E2AF', '#A6E3A1', '#89DCEB', '#89B4FA', '#CBA6F7'

      require("harpoon"):setup()
      -- HACK vim.g.loaded_matchparen = 1
      -- ^^^ fix some weird harpoon-related issue, when accessing a 4th buffer that starts with the same bracket

      -- require('kitty-scrollback').setup()

      -- require("indentmini").setup({ char = "┆", only_current = false, })
      -- vim.cmd.highlight('IndentLine guifg=#808080')
      -- vim.cmd.highlight('IndentLineCurrent guifg=#808080')

      -- Open help window in a vertical split to the right.
      vim.api.nvim_create_autocmd("BufWinEnter", {
          group = vim.api.nvim_create_augroup("help_window_right", {}),
          pattern = { "*.txt" },
          callback = function()
              if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
          end
      })

      -- NOTE: GUARD
      -- local ft = require('guard.filetype')
      --
      -- ft('c,cpp'):fmt('clang-format')
      --        :lint('clang-tidy')
      --
      -- -- Call setup() LAST!
      -- require('guard').setup({
      --     fmt_on_save = false,
      --     lsp_as_default_formatter = false,
      --     -- By default, Guard writes the buffer on every format
      --     -- You can disable this by setting:
      --     -- save_on_fmt = false,
      -- })
    '';
  };
}
