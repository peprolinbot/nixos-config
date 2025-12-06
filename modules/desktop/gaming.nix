{ lib, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  services.joycond.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = lib.mkDefault false;
    capSysAdmin = true;
    openFirewall = true;
  };
}
