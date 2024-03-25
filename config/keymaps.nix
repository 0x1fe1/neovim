{
  config.keymaps = [
    {
      key = "<C-h>";
      action = "<C-w>h";
      mode = ["n" "i"];
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      mode = ["n" "i"];
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      mode = ["n" "i"];
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      mode = ["n" "i"];
    }

    {
      key = "<";
      action = "<gv";
      mode = ["x"];
      options.desc = "Tab Left";
    }
    {
      key = ">";
      action = ">gv";
      mode = ["x"];
      options.desc = "Tab Right";
    }

    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
      mode = ["n" "x" "i"];
      options.desc = "Save";
    }

    {
      key = "<C-u>";
      action = "<C-u>zz";
      mode = ["n" "x" "i"];
      options.desc = "Scroll Up & Center";
    }
    {
      key = "<C-d>";
      action = "<C-d>zz";
      mode = ["n" "x" "i"];
      options.desc = "Scroll Down & Center";
    }

    {
      key = "x";
      action = "\"_x";
      mode = ["n" "x"];
      options.desc = "[X] Void";
    }
    {
      key = "<leader>d";
      action = "\"_d";
      mode = ["n" "x"];
      options.desc = "[D] Void";
    }

    # {
    #   key = "Q";
    #   action = "<nop>";
    #   mode = ["n" "x"];
    # }
    # {
    #   key = "q:";
    #   action = "<nop>";
    #   mode = ["n" "x"];
    # }

    {
      key = "-";
      action = "<ESC><cmd>Oil<CR>";
      mode = ["n" "x"];
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
      mode = ["x"];
      options.desc = "Open Diagnostics List";
    }

    # harpoon2
    {
      key = "<leader>a";
      action = "function() require('harpoon'):list():append() end";
      options.desc = "[A]dd file to (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<leader>m";
      action = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options.desc = "[M]ap of files (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-1>";
      action = "function() require('harpoon'):list():select(1) end";
      options.desc = "Select file #1 (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-2>";
      action = "function() require('harpoon'):list():select(2) end";
      options.desc = "Select file #2 (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-3>";
      action = "function() require('harpoon'):list():select(3) end";
      options.desc = "Select file #3 (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-4>";
      action = "function() require('harpoon'):list():select(4) end";
      options.desc = "Select file #4 (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-5>";
      action = "function() require('harpoon'):list():select(5) end";
      options.desc = "Select file #5 (Harpoon)";
      mode = ["n"];
      lua = true;
    }
    {
      key = "<C-6>";
      action = "function() require('harpoon'):list():select(6) end";
      options.desc = "Select file #6 (Harpoon)";
      mode = ["n"];
      lua = true;
    }

    # FOR DESCRIPTION ONLY
    {
      key = "<leader>s";
      action = "<leader>s";
      options = {
        desc = "[S]earch (Telescope)";
        remap = true;
      };
    }
  ];
}
