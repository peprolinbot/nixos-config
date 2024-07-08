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
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
  ];
}
