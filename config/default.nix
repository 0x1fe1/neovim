{
  inputs,
  pkgs,
  ...
}: let
  # from github.com/mrcjkb/kickstart-nix.nvim
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };
in {
  # Import all your configuration modules here
  imports = [
    ./plugins.nix
    ./keymaps.nix
    ./options.nix
  ];

  config = {
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    extraPlugins = [
      (mkNvimPlugin inputs.transparent-nvim "transparent.nvim") # gh:xiyaowong/transparent.nvim
    ];
    extraPackages = with pkgs; [
      alejandra
      xclip
    ];

    autoCmd = let
      def = toString 4;
      low = toString 2;
      langs = ["nix" "lua"];
    in [
      {
        event = ["BufWinLeave"];
        pattern = ["*"];
        command = ":set tabstop=${def} softtabstop=${def} shiftwidth=${def}";
      }
      {
        event = ["FileType" "BufWinEnter"];
        pattern = langs;
        command = ":set tabstop=${low} softtabstop=${low} shiftwidth=${low}";
      }

      # Highlight on Yank
      {
        event = ["TextYankPost"];
        pattern = ["*"];
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
    ];

    autoGroups = {
      YankHighlight.clear = true;
    };
  };
}
