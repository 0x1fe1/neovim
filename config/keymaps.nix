{ lib, ... }: {
  config.keymaps =
    [
      {
        key = "<";
        action = "<gv";
        mode = [ "x" ];
        options.desc = "Tab Left";
      }
      {
        key = ">";
        action = ">gv";
        mode = [ "x" ];
        options.desc = "Tab Right";
      }

      {
        key = "<A-s>";
        action = "<cmd>w<CR>";
        mode = [ "n" "x" "i" ];
        options.desc = "Save";
      }

      {
        key = "<C-u>";
        action = "<C-u>zz";
        mode = [ "n" "x" "i" ];
        options.desc = "Scroll Up & Center";
      }
      {
        key = "<C-d>";
        action = "<C-d>zz";
        mode = [ "n" "x" "i" ];
        options.desc = "Scroll Down & Center";
      }

      {
        key = "x";
        action = "\"_x";
        mode = [ "n" "x" ];
        options.desc = "[X] Void";
      }
      {
        key = "<leader>d";
        action = "\"_d";
        mode = [ "n" "x" ];
        options.desc = "[D] Void";
      }

      {
        key = "Q";
        action = "<nop>";
        mode = [ "n" "x" ];
      }
      # {
      #   key = "q:";
      #   action = "<nop>";
      #   mode = ["n" "x"];
      # }

      {
        key = "<C-h>";
        action = "<C-w><C-h>";
        mode = [ "n" ];
        options.desc = "Focus Left Split";
      }
      {
        key = "<C-j>";
        action = "<C-w><C-j>";
        mode = [ "n" ];
        options.desc = "Focus Down Split";
      }
      {
        key = "<C-k>";
        action = "<C-w><C-k>";
        mode = [ "n" ];
        options.desc = "Focus Up Split";
      }
      {
        key = "<C-l>";
        action = "<C-w><C-l>";
        mode = [ "n" ];
        options.desc = "Focus Right Split";
      }

      {
        key = "-";
        action = "<ESC><cmd>Oil<CR>";
        mode = [ "n" "x" ];
        options.desc = "Open FileSystem Navigation";
      }

      # {
      #   key = "y";
      #   action = "\"+y";
      #   mode = ["v"];
      #   options.desc = "Yank Hack";
      # }

      {
        key = "p";
        action = "P";
        mode = [ "x" ];
        options.desc = "Paste without yanking";
      }

      {
        key = "n";
        action = "nzzzv";
        mode = [ "n" ];
        options.desc = "Next, center + unfold";
      }
      {
        key = "N";
        action = "Nzzzv";
        mode = [ "n" ];
        options.desc = "Previous, center + unfold";
      }
      {
        key = "J";
        action = "mzJ`z";
        mode = [ "n" ];
        options.desc = "Combine Lines";
      }
      # {
      #   key = "<C-j>";
      #   action = "<cmd>cprev<CR>zz";
      #   mode = [ "n" ];
      #   options.desc = "Quickfix list Previous";
      # }
      # {
      #   key = "<C-k>";
      #   action = "<cmd>cnext<CR>zz";
      #   mode = [ "n" ];
      #   options.desc = "Quickfix list Next";
      # }

      # harpoon2
      {
        key = "<leader>a";
        action.__raw = "function() require('harpoon'):list():add() end";
        options.desc = "[A]dd file to (Harpoon)";
        mode = [ "n" ];
      }
      {
        key = "<leader>m";
        action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
        options.desc = "[M]ap of files (Harpoon)";
        mode = [ "n" ];
      }
      {
        key = "<leader>cm";
        action.__raw = "function() require('harpoon'):list():clear() end";
        options.desc = "[C]lear the [M]ap of files (Harpoon)";
        mode = [ "n" ];
      }
    ]
    ++ (builtins.map
      (num: {
        key = "<A-${num}>";
        action.__raw = "function() require('harpoon'):list():select(${num}) end";
        options.desc = "Select file #${num} (Harpoon)";
        mode = [ "n" ];
      })
      (map toString (lib.lists.range 1 9)))
    ++ [
      # FOR DESCRIPTION ONLY
      # {
      #   key = "<leader>s";
      #   action = "<leader>s";
      #   options = {
      #     desc = "[S]earch (Telescope)";
      #     remap = true;
      #   };
      # }
    ];
}
