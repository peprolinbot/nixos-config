{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];

  # Display manager
  programs.regreet = {
    enable = true;
    settings = {
      background.path = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
    };
  };
}
