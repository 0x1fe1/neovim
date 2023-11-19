{inputs}: final: prev: let
  mkNvimPlugin = src: pname:
    prev.pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };
in {
  nvimPlugins = {
    # Add bleeding edge plugins from the flake inputs here.
    # $ = mkNvimPlugin inputs.$ "$"; :s/$/AAA/g
    transparent = mkNvimPlugin inputs.transparent "transparent";
    gomove = mkNvimPlugin inputs.gomove "gomove";
    harpoon = mkNvimPlugin inputs.harpoon "harpoon";
    lsp-zero = mkNvimPlugin inputs.lsp-zero "lsp-zero";
    rustaceanvim = mkNvimPlugin inputs.rustaceanvim "rustaceanvim";
  };
}
