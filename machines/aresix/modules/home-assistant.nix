{
  inputs,
  config,
  ...
}: {
  imports = [inputs.tg-ha-door.nixosModules.tg-ha-door];

  services.tg-ha-door = {
    enable = true;
    credentialsFile = config.sops.secrets.tg-ha-door-creds.path;
    settings = {
      TG_KEY_CHAT_ID = "-1001455284010";
      TG_LOG_CHAT_ID = "-1001359679497";
      HA_URL = "http://[::1]:8123";
      HA_DOOR_ENTITY_ID = "cover.puerta_verde";
      DOOR_OPEN_CLOSE_TIME = 60;
    };
  };

  services.esphome.enable = true;

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      # Additional components
      "esphome"
      "mobile_app"
    ];
    config = {
      http = {
        trusted_proxies = ["::1"];
        use_x_forwarded_for = true;
      };

      default_config = {};

      "automation ui" = "!include automations.yaml";
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";
    };
  };
}
