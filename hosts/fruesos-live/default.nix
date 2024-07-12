{
  pkgs,
  username,
  lib,
  ...
}: {
  imports = [
    ./../../modules/core
  ];

  networking.hostName = "fruesos-live";

  powerManagement.cpuFreqGovernor = "balanced";

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJji4h4bgzgmp7YoRX/8ePN0TcCYRfI2wlrEeZkBQ/y2 personal@peprolinbot.com"
  ];

  # Less compression, but faster build
  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # You can not use networking.networkmanager with networking.wireless.
  networking.wireless.enable = false;

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = lib.mkForce "pedro";

  # Allow the user to log in as pedro without a password.
  users.users.${username}.initialHashedPassword = "";

  # Autologin
  services.greetd.settings.initial_session = {
    command = "Hyprland";
    user = "pedro";
  };

  home-manager.users.${username}.services.nextcloud-client.enable = lib.mkForce false;
}
