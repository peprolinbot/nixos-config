{
  osConfig,
  pkgs,
  ...
}: let
  hasDE = osConfig.hm-pedro.de != "none";
in {
  programs.distrobox = {
    enable = true;
    enableSystemdUnit = true;
    containers = {
      debian13 = {
        image = "debian:13";
        entry = false;
        additional_packages = "git";
        init_hooks = [
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker"
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker-compose"
        ];
      };

      kali = {
        image = "docker.io/kalilinux/kali-rolling:latest";
        entry = false;
        init_hooks = [
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker"
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker-compose"
        ];
      };
    };
  };

  home.packages = with pkgs;
    if hasDE
    then [boxbuddy]
    else [];
}
