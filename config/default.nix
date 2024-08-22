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
      hover-nvim
      vim-move
      harpoon2

      # github:ThePrimeagen/harpoon/tree/harpoon2
      # (mkNvimPlugin inputs.harpoon "harpoon")

      # github:xiyaowong/transparent.nvim
      (mkNvimPlugin inputs.transparent-nvim "transparent.nvim")

      # github:mikesmithgh/kitty-scrollback.nvim
      # (mkNvimPlugin inputs.kitty-scrollback "kitty-scrollback")
    ];

    extraPackages = with pkgs; [
      xclip
      # alejandra
      # elmPackages.elm-format
      # nodejs_18
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
    ];

    autoGroups = {
      YankHighlight.clear = true;
    };

    extraFiles =
      let
        text = ''
          vim.opt.tabstop = 2
          vim.opt.shiftwidth = 2
          vim.opt.expandtab = true
        '';
      in
      {
        "ftplugin/nix.lua".text = text;
        # "ftplugin/toml.lua".text = text;
        # "ftplugin/c.lua".text = text;
      };

    extraConfigLuaPost = /* lua */ ''
      -- NOTE indent-blankline multicolor
      -- local ibl_high = { 'ctpRed', 'ctpPeach', 'ctpYellow', 'ctpGreen', 'ctpSky', 'ctpBlue', 'ctpMauve' }
      -- require('ibl.hooks').register(require('ibl.hooks').type.HIGHLIGHT_SETUP, function()
      --   local ibl_high_colors = {'#F38BA8', '#FAB387', '#F9E2AF', '#A6E3A1', '#89DCEB', '#89B4FA', '#CBA6F7'}
      --   for i, name in ipairs(ibl_high) do
      --     vim.api.nvim_set_hl(0, name, { fg = ibl_high_colors[i] })
      --   end
      -- end)
      -- require('ibl').setup({
      --   indent = { highlight = ibl_high, char = '┆' },
      --   scope = { enabled = false },
      --   viewport_buffer = { min = 128, max = 512 },
      -- })

      -- NOTE hover.nvim
      require("hover").setup {
        init = function()
          require("hover.providers.lsp")
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'single'
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = false,
      }
      vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
      vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})



      -- NOTE harpoon2
      require("harpoon"):setup()
      -- HACK
      -- vim.g.loaded_matchparen = 1
      -- ^^^ fix some weird harpoon-related issue, when accessing a 4th buffer that starts with the same bracket

      -- NOTE kitty-scrollback
      -- require('kitty-scrollback').setup()
    '';
  };
}
