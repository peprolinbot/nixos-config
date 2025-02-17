{pkgs, ...}: {
  home.packages = with pkgs; [swaynotificationcenter kooha];
  xdg.configFile."swaync/style.css".source = ./style.css;
  xdg.configFile."swaync/config.json".source = ./config.json;
}
