{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/home-assistant.nix
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.initrd.systemd.tpm2.enable = false; # https://github.com/NixOS/nixpkgs/issues/344963
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  hardware.enableRedistributableFirmware = true;
}
