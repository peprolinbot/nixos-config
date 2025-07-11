{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  networking.hostName = "frues-pc";

  powerManagement.cpuFreqGovernor = "performance";

  hardware.ckb-next.enable = true;

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

# https://nixos.wiki/wiki/AMD_GPU
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
driversi686Linux.amdvlk
  ];
hardware.graphics.enable32Bit = true; # For 32 bit applications

  # It is an open-source implementation of Nvidia’s Moonlight game streaming application
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  home-manager.users.${username}.wayland.windowManager.hyprland.settings.monitor = [
    "DP-2, 1920x1080@60, 0x0, 1"
    "DP-1, 2560x1440@165, 1920x0, 1.333333"
"HDMI-A-1, 1920x1080@75, 3840x0, 1"
  ];

  services.sshd.enable = true;
}
