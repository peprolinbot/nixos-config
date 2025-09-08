{pkgs, ...}: {
  users.users.juan = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpkZoYCFS6jQyaLgRkG8WlOj8ybpwsJkCWTuKkGB5oA Juan Rey"
    ];
  };

  # Requested by juan
  environment.systemPackages = [pkgs.ecryptfs];
  programs.ecryptfs.enable = true;
  boot.kernelModules = ["ecryptfs"];
}
