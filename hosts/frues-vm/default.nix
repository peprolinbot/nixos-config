{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  networking.hostName = "frues-vm";

  # allow local remote access to make it easier to toy around with the system
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      PermitRootLogin = false;
    };
  };
}
