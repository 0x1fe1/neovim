{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final.pkgs;

  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with inputs.nixpkgs.legacyPackages.x86_64-linux.vimPlugins;
    [
      # plugins from nixpkgs go in here.
      # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
      nvim-treesitter.withAllGrammars
      luasnip # snippets | https://github.com/l3mon4d3/luasnip

      # Autocompletion And Extensions
      nvim-cmp # https://github.com/hrsh7th/nvim-cmp
      cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip
      lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim
      cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp
      cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
      cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer
      cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path
      cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua

      # Git Integration Plugins | have not *yet* seen a need for them
      # neogit # https://github.com/TimUntersberger/neogit
      # gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim
      # vim-fugitive # https://github.com/tpope/vim-fugitive

      # Telescope And Extensions
      telescope-nvim # https://github.com/nvim-telescope/telescope.nvim
      telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
      # telescope-manix # https://github.com/MrcJkb/telescope-manix

      # UI
      lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim
      # nvim-treesitter-context # https://github.com/nvim-treesitter/nvim-treesitter-context
      which-key-nvim # https://github.com/folke/which-key.nvim
      indent-blankline-nvim # https://github.com/lukas-reineke/indent-blankline.nvim
      fidget-nvim # https://github.com/j-hui/fidget.nvim
      lsp_signature-nvim # https://github.com/ray-x/lsp_signature.nvim
      nvim-ufo # better folds | https://github.com/kevinhwang91/nvim-ufo

      # Language Support
      neodev-nvim # adds support for Neovim's Lua API to lua-language-server | https://github.com/folke/neodev.nvim
      nvim-lspconfig # https://github.com/neovim/nvim-lspconfig
      # go-nvim # https://github.com/ray-x/go.nvim
      # rust-tools-nvim # https://github.com/simrat39/rust-tools.nvim
      crates-nvim # https://github.com/saecki/crates.nvim

      # Navigation/Editing Enhancement Plugins
      nvim-surround # https://github.com/kylechui/nvim-surround
      nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring
      comment-nvim # comment utils | https://github.com/numtostr/comment.nvim
      playground # treesitter playground | https://github.com/nvim-treesitter/playground
      nvim-autopairs # https://github.com/windwp/nvim-autopairs
      # neoscroll-nvim # smooth scroll | https://github.com/karb94/neoscroll.nvim
      oil-nvim # netrw but in a buffer | https://github.com/stevearc/oil.nvim

      # Dependencies
      # sqlite-lua
      plenary-nvim
      nvim-web-devicons
      vim-repeat

      # Themes
      catppuccin-nvim # the one and only theme.
    ]
    ++ (with pkgs.nvimPlugins; [
      # Bleeding-edge plugins from flake inputs go in here
      transparent # makes the neovim background transparent | https://github.com/xiyaowong/transparent.nvim
      gomove # allows [Shift+]Alt+j/k to [duplicate]move lines | https://github.com/booperlv/nvim-gomove
      harpoon # Quick jumping between files | https://github.com/ThePrimeagen/harpoon
      lsp-zero # easy config for *most* lsps | https://github.com/VonHeikemen/lsp-zero.nvim
      rustaceanvim # rust-tools, does not require lspconfig / setup call | https://github.com/mrcjkb/rustaceanvim
    ]);

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil # nix LSP

    alejandra # nix formatter

    zls # zig LSP
    gopls # go LSP
    ols # odin LSP
    nimlsp # nim LSP

    # marksman

    # prettierd
    nodePackages_latest.prettier

    # nodePackages_latest.vscode-css-languageserver-bin
    nodePackages_latest.typescript-language-server

    nodePackages_latest.svelte-language-server
    nodePackages_latest.svelte-check
    vscode-langservers-extracted
    typescript
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
