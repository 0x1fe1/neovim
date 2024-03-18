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
      key = "d";
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
