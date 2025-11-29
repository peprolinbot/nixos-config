{ pkgs, lib, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  environment.systemPackages = [ pkgs.gamescope ];

  programs.gamemode.enable = true;

  services.joycond.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = lib.mkDefault false;
    capSysAdmin = true;
    openFirewall = true;
  };
}
