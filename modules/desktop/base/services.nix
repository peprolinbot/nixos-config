{pkgs, ...}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;

    flatpak.enable = true;

    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;
  };

  environment.systemPackages = [pkgs.libsecret];
}
