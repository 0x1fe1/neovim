{inputs}: final: prev: let
  mkNvimPlugin = src: pname:
    prev.pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };
in {
  nvimPlugins = {
    # Add bleeding edge plugins from the flake inputs here.
    # $ = mkNvimPlugin inputs.$ "$.nvim";
    transparent = mkNvimPlugin inputs.transparent "transparent.nvim";
    gomove = mkNvimPlugin inputs.gomove "gomove.nvim";
    harpoon = mkNvimPlugin inputs.harpoon "harpoon.nvim";
    lsp-zero = mkNvimPlugin inputs.lsp-zero "lsp-zero.nvim";
    rustaceanvim = mkNvimPlugin inputs.rustaceanvim "rustaceanvim.nvim";
  };
}
