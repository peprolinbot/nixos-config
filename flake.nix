{
  description = "peprolinbot's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib.url = "github:hyprwm/contrib";

    fjordlauncher = {
      url = "github:unmojang/FjordLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    username = "pedro";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      frues-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(import ./hosts/frues-pc)];
        specialArgs = {
          host = "frues-pc";
          inherit self inputs username;
        };
      };
      frues-port = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(import ./hosts/frues-port)];
        specialArgs = {
          host = "frues-port";
          inherit self inputs username;
        };
      };
      frues-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(import ./hosts/frues-vm)];
        specialArgs = {
          host = "frues-vm";
          inherit self inputs username;
        };
      };
      fruesos-live = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          (import ./hosts/fruesos-live)
        ];
        specialArgs = {
          host = "fruesos-live";
          inherit self inputs username;
        };
      };
    };
  };
}
