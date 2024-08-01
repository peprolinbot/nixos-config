{inputs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Catpuccin Mocha";
    };
    themes = {
      catppuccin-mocha = {
        src = inputs.catppuccin-bat;
        file = "/themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
