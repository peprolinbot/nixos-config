{inputs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Catpuccin Mocha";
    };
    themes = {
      file = "${inputs.catppuccin-bat}/themes/Catppuccin Mocha.tmTheme";
    };
  };
}
