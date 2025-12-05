{ lib, ... }:
let
  variables = {
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland,x11,*";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_USE_XINPUT2 = 1;
    WLR_BACKEND = "vulkan";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
in
{
  home.sessionVariables = variables;

  xdg.configFile."uwsm/env".text = builtins.concatStringsSep "\n" (
    lib.attrsets.mapAttrsToList (name: value: "export ${name}=\"${builtins.toString value}\"") variables
  );
}
