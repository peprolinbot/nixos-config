{
  lib,
  config,
  ...
}: {
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

    virtualHosts = let
      base = locations: {
        inherit locations;

        forceSSL = true;
        enableACME = true;
      };

      proxy = {
        port,
        websockets ? false,
      }:
        (base {
          "/" = {
            proxyPass = "http://[::1]:" + toString port + "/";
            proxyWebsockets = websockets;
          };
        })
        // {
          extraConfig = lib.mkIf websockets ''
            proxy_buffering off;
          '';
        };

      proxySimple = port: proxy {inherit port;};

      proxyWebsockets = port:
        proxy {
          inherit port;
          websockets = true;
        };
    in {
      "ha.campares.duckdns.org" = proxyWebsockets config.services.home-assistant.config.http.server_port;

      "wg.campares.duckdns.org" = proxySimple config.services.wg-access-server.settings.port;

      "ha.morada.campares.duckdns.org" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://[544:5d19:c117:8cc2:85c6:6a16:e78a:9737]:8123";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };
    };
  };
}
