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
    ./options.nix
    ./keymaps.nix
    ./plugins.nix
  ];

  config = {
    colorschemes.catppuccin = {
      enable = true;
      # transparentBackground = true;
    };

    globals.mapleader = " ";

    extraPlugins =
      # with pkgs.vimPlugins;
      [
        # transparent background | https://github.com/xiyaowong/transparent.nvim
        (mkNvimPlugin inputs.transparent-nvim "transparent.nvim")
      ];
    extraPackages = with pkgs; [
      alejandra
      xclip
    ];
  };
}
