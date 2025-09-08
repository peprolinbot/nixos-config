{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [./regreet.nix];

  options = {
    programs.hyprland.autoLogin.username = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "john";
      description = "User for Hyprland auto login with ReGreet. Disabled by default";
    };
  };

  config = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    services.greetd.settings.initial_session = let
      username = config.programs.hyprland.autoLogin.username;
    in
      lib.mkIf (!isNull username) {
        command = "uwsm start hyprland-uwsm.desktop";
        user = username;
      };

    environment.sessionVariables.XKB_DEFAULT_LAYOUT = "es";
  };
}
