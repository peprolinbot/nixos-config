{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  options = {
    hm-pedro.de = lib.mkOption {
      default = "none";
      type = lib.types.enum ["none" "hyprland" "gnome"];
    };
  };
  config = {
    home-manager = {
      backupFileExtension = "hmbkp";
      extraSpecialArgs = {inherit inputs;};
      users.pedro = {
        imports = [./home-configuration];

        home.stateVersion = "25.05";
      };
    };

    programs.zsh.enable = true; # To use as user's default shell below
    users.users.pedro = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJji4h4bgzgmp7YoRX/8ePN0TcCYRfI2wlrEeZkBQ/y2 personal@peprolinbot.com"
      ];
    };

    programs.dconf.enable = true; # Doesn't work on headless installs without dconf (?)
  };
}
