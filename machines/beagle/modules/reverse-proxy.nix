{config, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "personal+letsencrypt@peprolinbot.com";
  };

  networking.firewall.allowedTCPPorts = [80 443];

  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "idm.peprolinbot.com" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "https://${config.services.kanidm.serverSettings.bindaddress}";
        };
      };
    };
  };
}
