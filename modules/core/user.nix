{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    backupFileExtension = "hmbkp";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = {
      imports = [./../home];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel" "i2c" "libvirtd" "adbusers" "dialout"];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = ["${username}"];
}
