{
  config,
  pkgs,
  username,
  ...
}: {
  # Add user to libvirtd group
  users.users.${username}.extraGroups = ["libvirtd"];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    podman-compose
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
  ];

  # Manage the virtualisation services
  virtualisation = {
    waydroid.enable = true;

    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };

    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
