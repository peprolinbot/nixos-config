{lib, ...}: {
  nix.settings = {
    trusted-users = ["pedro"];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
}
