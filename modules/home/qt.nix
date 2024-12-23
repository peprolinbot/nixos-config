{
  pkgs,
  config,
  ...
}: {
  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Lavender";
  };
  xdg.configFile."Kvantum/Catppuccin-Mocha-Lavender".source = "${(pkgs.catppuccin-kvantum.override {
    accent = "lavender";
    variant = "mocha";
  })}/share/Kvantum/Catppuccin-Mocha-Lavender";

  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    Appearance = {
      style = "kvantum-dark";
      icon_theme = "Papirus-Dark";
    };

    Fonts = {
      general = "\"JetBrainsMono Nerd Font,12,-1,5,50,0,0,0,0,0,Regular\"";
      fixed = "\"JetBrainsMono Nerd Font,12,-1,5,50,0,0,0,0,0,Regular\"";
    };
  };

  xdg.configFile."qt6ct/qt6ct.conf".source = config.xdg.configFile."qt5ct/qt5ct.conf".source;
}
