{ pkgs, ... }:
{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;

    fwupd.enable = true;

    flatpak.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;
  };

  environment.systemPackages = [ pkgs.libsecret ];
}
