{pkgs, ...}: {
  imports = [
    ../../modules/desktop/hyprland.nix
  ];

  hm-pedro.de = "hyprland";
  programs.hyprland.autoLogin.username = "pedro";
}
