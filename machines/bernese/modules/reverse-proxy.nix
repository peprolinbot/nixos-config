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

      "whiteboard.nextcloud.peprolinbot.com" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://localhost:3002";

          proxyWebsockets = true;
        };
      };

      ${config.virtualisation.oci-containers.containers.collabora.environment.server_name} = {
        enableACME = true;
        forceSSL = true;

        extraConfig = ''
           # static files
           location ^~ /browser {
             proxy_pass http://127.0.0.1:9980;
             proxy_set_header Host $host;
           }

           # WOPI discovery URL
           location ^~ /hosting/discovery {
             proxy_pass http://127.0.0.1:9980;
             proxy_set_header Host $host;
           }

           # Capabilities
           location ^~ /hosting/capabilities {
             proxy_pass http://127.0.0.1:9980;
             proxy_set_header Host $host;
          }

          # main websocket
          location ~ ^/cool/(.*)/ws$ {
            proxy_pass http://127.0.0.1:9980;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";
            proxy_set_header Host $host;
            proxy_read_timeout 36000s;
          }

          # download, presentation and image upload
          location ~ ^/(c|l)ool {
            proxy_pass http://127.0.0.1:9980;
            proxy_set_header Host $host;
          }

          # Admin Console websocket
          location ^~ /cool/adminws {
            proxy_pass http://127.0.0.1:9980;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";
            proxy_set_header Host $host;
            proxy_read_timeout 36000s;
          }
        '';
      };
    };
  };
}
