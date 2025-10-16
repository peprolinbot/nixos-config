{pkgs, ...}: {
  # Must-have packages
  environment.systemPackages = with pkgs; [
    vim
    rsync
  ];
}
