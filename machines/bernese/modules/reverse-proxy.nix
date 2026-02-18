{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "personal+letsencrypt@peprolinbot.com";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "_" = {
        default = true;
        rejectSSL = true; # Avoid serving a certificate

        locations."/" = {
          return = "404";
        };
      };

      "immich.peprolinbot.com" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://${config.services.immich.host}:${toString config.services.immich.port}";

          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_read_timeout   600s;
            proxy_send_timeout   600s;
            send_timeout         600s;
          '';
        };
      };

      ${config.services.nextcloud.hostName} = {
        forceSSL = true;
        enableACME = true;

        # Rest in nextcloud module
      };
    };
  };
}
