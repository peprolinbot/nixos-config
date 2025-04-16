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

  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
  ];

  # It is an open-source implementation of Nvidia’s Moonlight game streaming application
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  home-manager.users.${username}.wayland.windowManager.hyprland.settings.monitor = [
    "HDMI-A-1, 1920x1080@75, 0x0, 1"
    "DP-1, 2560x1440@165, 1920x0, 1.333333"
  ];

  services.sshd.enable = true;
}
