{
  pkgs,
  lib,
  ...
}: {
  boot.loader = {
    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    efi.canTouchEfiVariables = lib.mkDefault true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
