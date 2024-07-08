{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
  hardware.enableRedistributableFirmware = true;

  hardware.flipperzero.enable = true; # Installs and setups everything Flipper Zero

  hardware.bluetooth.enable = true;
}
