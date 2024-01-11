{
  config.options = {
    number = true;
    relativenumber = true;
    cursorline = true;
    lazyredraw = true;
    showmatch = false; # Highlight matching parentheses, etc
    incsearch = true;
    hlsearch = false;

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    expandtab = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;

    signcolumn = "yes";
    encoding = "utf-8";
    fileencoding = "utf-8";
    mouse = "a";
    scrolloff = 4;
  };
}
