{ pkgs, outputs, ... }:
{
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
