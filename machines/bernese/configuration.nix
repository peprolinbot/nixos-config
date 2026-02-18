{ pkgs, ... }:
{
  imports = [
    modules/immich.nix
    modules/nextcloud.nix
    modules/reverse-proxy.nix
  ];

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/27145a2e-f940-412c-b337-c9c9efe02a80";
    fsType = "ext4";
  };

  virtualisation.docker.enable = true;
  users.users.pedro.extraGroups = [ "docker" ];
  environment.systemPackages = [ pkgs.docker-compose ];
}
