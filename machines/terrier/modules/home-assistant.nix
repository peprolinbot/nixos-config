{config, ...}: {
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
      "mobile_app"
      "nmap_tracker"
      "cast"
    ];
    config = {
      homeassistant = {
        name = "La Morada";
        external_url = "https://ha.morada.campares.duckdns.org";
      };

      http = {
        trusted_proxies = ["4a6:fed0:59ba:507d:baab:15f3:846d:ead4"];
        use_x_forwarded_for = true;
      };

      default_config = {};

      "automation ui" = "!include automations.yaml";
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";
    };
  };

  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scenes.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scripts.yaml 0755 hass hass"
  ];
}
