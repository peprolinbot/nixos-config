{pkgs, ...}: {
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
  hardware.opengl.extraPackages = with pkgs; [
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
}
