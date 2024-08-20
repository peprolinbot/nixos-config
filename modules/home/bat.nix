{inputs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "catppuccin-mocha";
    };
    themes = {
      catppuccin-mocha = {
        src = inputs.catppuccin-bat;
        file = "/themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
