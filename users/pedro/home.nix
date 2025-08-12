{self, ...}: {
  imports = [self.inputs.home-manager.nixosModules.default ./configuration.nix];

  home-manager.users.pedro = {
    imports = [
      ./home-configuration
    ];

    home.stateVersion = "25.05";
  };
}
