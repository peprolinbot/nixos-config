{ ... }:
{
  hm-pedro.de = "gnome";

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  boot.kernelPatches = [
    {
      name = "surface3-spi";
      patch = ./0002-surface3-spi.patch;
    }
  ];
}
