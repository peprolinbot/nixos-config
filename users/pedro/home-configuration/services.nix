{osConfig, ...}: let
  hasDE = osConfig.hm-pedro.de != "none";
in {
  services.nextcloud-client = {
    enable = hasDE;
    startInBackground = true;
  };

  services.kdeconnect = {
    enable = hasDE;
    indicator = true;
  };
}
