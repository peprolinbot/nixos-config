{
  pkgs,
  config,
  ...
}: let
  qtctConf = ''
    [Appearance]
    style=kvantum
    icon_theme=${config.stylix.iconTheme.${config.stylix.polarity}}

    [Fonts]
    general="${config.stylix.fonts.sansSerif.name},${builtins.toString config.stylix.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
    fixed="${config.stylix.fonts.monospace.name},${builtins.toString config.stylix.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
  '';
in {
  qt = {
    enable = true;
  };

  xdg.configFile."qt5ct/qt5ct.conf".text = qtctConf;
  xdg.configFile."qt6ct/qt6ct.conf".text = qtctConf;
}
