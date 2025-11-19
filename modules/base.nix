{ pkgs, ... }:
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
}
