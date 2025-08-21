{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.tg-ha-door.nixosModules.tg-ha-door];

  clan.core.vars.generators.tg-ha-door = {
    prompts.telegram-bot-token = {
      description = "Telegram token for the tg-ha-door bot";
      type = "hidden";
    };

    prompts.home-assistant-auth-token = {
      description = "Home Assistant token tg-ha-door will use to connect to the instance";
      type = "hidden";
    };

    files.credentials-file.secret = true;
    script = ''
      {
        echo "TG_BOT_TOKEN=$(<$prompts/telegram-bot-token)"
        echo "HA_AUTH_TOKEN=$(<$prompts/home-assistant-auth-token)"
      } > $out/credentials-file
    '';
  };

  services.tg-ha-door = {
    enable = true;
    credentialsFile = config.clan.core.vars.generators.tg-ha-door.files.credentials-file.path;
    settings = {
      TG_KEY_CHAT_ID = "-1001455284010";
      TG_LOG_CHAT_ID = "-1001359679497";
      HA_URL = "http://[::1]:8123";
      HA_DOOR_ENTITY_ID = "cover.puerta_verde";
      DOOR_OPEN_CLOSE_TIME = 60;
    };
  };

  services.esphome = {
    enable = true;
    address = "::1"; # Proxied trough home assistant
  };

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
    customComponents = [(pkgs.callPackage ./custom_components/panel_proxy.nix {})];
    config = {
      panel_proxy = {
        esphome = {
          title = "ESPHome Dashboard";
          icon = "mdi:chip";
          url = "http://[::1]:6052/";
          require_admin = true;
        };
      };

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
