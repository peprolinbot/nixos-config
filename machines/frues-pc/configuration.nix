{ ... }:
{
  imports = [
    ./disks.nix
    ../../modules/desktop/hyprland.nix
  ];

  hm-pedro.de = "hyprland";
  programs.hyprland.autoLogin.username = "pedro";

  boot.loader = {
    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  services.sunshine.autoStart = true;

  programs.steam.gamescopeSession = {
    enable = true;
    args = [
      "--prefer-output"
      "DP-1,*"
      "--rt"
      "--adaptive-sync"
      "--steam"
    ];
  };

  services.hardware.openrgb.enable = true;
  home-manager.users.pedro.wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2, 1920x1080@60, 0x0, 1"
      "DP-1, 2560x1440@165, 1920x0, 1.333333"
      "HDMI-A-1, 1920x1080@75, 3840x0, 1"
    ];
    exec-once = [
      "uwsm app -- openrgb --startminimized"
    ];
  };
  home-manager.users.pedro.services.hypridle.settings.listener = [
    {
      timeout = 270; # 4.5 min
      on-timeout = "openrgb -b 0";
      on-resume = "openrgb -b 100";
    }
  ];

}
