{
  description = "peprolinbot's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    nix-gaming.url = "github:fufexan/nix-gaming";

    fjordlauncher.url = "github:unmojang/FjordLauncher";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
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
    };
  };
}
