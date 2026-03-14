{
  pkgs,
  outputs,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-index-database.nixosModules.default ];

  programs.nix-index-database.comma.enable = true; # Stick a , in front of a command to run it without installing

  # Must-have packages
  environment.systemPackages = with pkgs; [
    vim
    rsync
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.overlays = [
    outputs.overlays.unstable-packages
  ];

  security.polkit.enable = true;
  security.sudo.enable = true;

}
