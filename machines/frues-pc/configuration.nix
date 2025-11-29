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

  home-manager.users.pedro.wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2, 1920x1080@60, 0x0, 1"
      "DP-1, 2560x1440@165, 1920x0, 1.333333"
      "HDMI-A-1, 1920x1080@75, 3840x0, 1"
    ];
    exec-once = [
      "uwsm app -- ckb-next -b"
    ];
  };

  hardware.ckb-next.enable = true;
}
