# This are some NixOS options this user requires
{pkgs, ...}: {
  users.users.pedro = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJji4h4bgzgmp7YoRX/8ePN0TcCYRfI2wlrEeZkBQ/y2 personal@peprolinbot.com"
    ];
  };

  programs.zsh.enable = true;
}
