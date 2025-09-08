{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    targets = {
      librewolf.profileNames = ["pedro"];
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };

    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin Mocha Dark";
      size = 22;
    };

    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    opacity = {
      applications = 0.65;
      desktop = 1.0;
      popups = 0.8;
      terminal = 0.55;
    };
  };
}
