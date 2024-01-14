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
    }
    {
      key = ">";
      action = ">gv";
      mode = ["x"];
    }

    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
      mode = ["n" "x" "i"];
    }

    {
      key = "<C-u>";
      action = "<C-u>zz";
      mode = ["n" "x" "i"];
    }
    {
      key = "<C-d>";
      action = "<C-d>zz";
      mode = ["n" "x" "i"];
    }

    {
      key = "<leader>x";
      action = "\"_x";
      mode = ["n" "x"];
    }
    {
      key = "<leader>d";
      action = "\"_d";
      mode = ["n" "x"];
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
    }

    {
      key = "y";
      action = "\"+y";
      mode = ["v"];
    }

    # FOR DESCRIPTION ONLY
    # {
    #   key = "<leader>a";
    #   action = "<leader>a";
    #   options.desc = "[A]dd file (harpoon)";
    # }
  ];
}
