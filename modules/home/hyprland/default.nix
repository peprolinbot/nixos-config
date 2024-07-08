{inputs, ...}: {
  imports =
    [(import ./hyprland.nix)]
    ++ [(import ./config.nix)]
    ++ [(import ./hyprlock.nix)]
    ++ [(import ./hypridle.nix)]
    ++ [(import ./variables.nix)]
    ++ [inputs.hyprland.homeManagerModules.default];

  xdg.configFile."hypr/default_wallpaper.png".source = ./default_wallpaper.png;
}
