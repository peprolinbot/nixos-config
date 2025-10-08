{pkgs, ...}: {
  hm-pedro.de = "gnome";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  boot.kernelPatches = [
    {
      name = "surface3-spi";
      patch = ./0002-surface3-spi.patch;
    }
  ];
}
