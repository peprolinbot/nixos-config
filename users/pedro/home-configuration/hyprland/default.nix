{...}: {
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./variables.nix
    ./utils.nix
  ];

  xdg.configFile."hypr/default_wallpaper.png".source = ./default_wallpaper.png;
}
