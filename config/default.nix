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
    ./keymaps.nix
    ./options.nix
    ./plugins.nix
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

    # autoCmd = [
    #   {
    #     event = ["FileType"];
    #     pattern = ["nix"];
    #     command = ":echo 'Hello, Nix'<CR>";
    #   }
    # ];
  };
}
