{pkgs, ...}: {
  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Lavender";
  };
  xdg.configFile."Kvantum/Catppuccin-Mocha-Lavender".source = "${(pkgs.catppuccin-kvantum.override {
    accent = "Lavender";
    variant = "Mocha";
  })}/share/Kvantum/Catppuccin-Mocha-Lavender";
}
