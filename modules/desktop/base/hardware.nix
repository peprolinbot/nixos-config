{pkgs, ...}: {
  hardware.flipperzero.enable = true; # Installs and setups everything Flipper Zero

  hardware.bluetooth.enable = true;

  hardware.sane.enable = true;
}
