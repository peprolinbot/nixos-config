{ config, ... }:
let
  arrAppsToProxy = [
    "radarr"
    "sonarr"
    "prowlarr"
    "bazarr"
  ]; # Will setup Nginx and Oauth2-proxy
  arrAppDomain = appName: "${appName}.media.peprolinbot.com";
in
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

      "seerr.media.peprolinbot.com" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://[::1]:${toString config.nixarr.jellyseerr.port}";
        };
      };

      "jellyfin.media.peprolinbot.com" = rec {
        # See https://jellyfin.org/docs/general/post-install/networking/reverse-proxy/nginx/
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          extraConfig = ''
            proxy_buffering off;
          '';
        };

        locations."/socket" = {
          proxyPass = locations."/".proxyPass;
          proxyWebsockets = true;
        };

        extraConfig = ''
          client_max_body_size 20M;
        '';
      };

      "${config.services.oauth2-proxy.nginx.domain}" = {
        enableACME = true;
        forceSSL = true;
      };

      "transmission.media.peprolinbot.com" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.nixarr.transmission.uiPort}";
          extraConfig = ''
            include ${config.clan.core.vars.generators.transmission.files.nginxProxySetHeader.path};
          '';
        };
      };

      "qui.media.peprolinbot.com" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://${config.services.qui.settings.host}:${toString config.services.qui.settings.port}";
        };
      };

    }
    // (
      let
        arrAppProxy = appName: {
          enableACME = true;
          forceSSL = true;

          locations."/" = {
            proxyPass = "http://127.0.0.1:${
              toString (
                let
                  appCfg = config.nixarr.${appName};
                in
                if builtins.hasAttr "port" appCfg then appCfg.port else appCfg.uiPort
              )
            }";
          };
        };
        arrAppProxyVhost = appName: {
          name = arrAppDomain appName;
          value = arrAppProxy appName;
        };
      in
      (builtins.listToAttrs (builtins.map arrAppProxyVhost arrAppsToProxy))
    );
  };

  clan.core.vars.generators.oauth2-proxy = {
    prompts.oidc_issuer_url = {
      description = "*Arr Oauth2 Proxy OIDC issuer URL";
      type = "line";
      persist = true;
    };
    files.oidc_issuer_url.secret = false;

    prompts.client_id = {
      description = "*Arr Oauth2 Proxy OIDC client id";
      type = "line";
      persist = true;
    };
    files.client_id.secret = false;

    prompts.client_secret = {
      description = "*Arr Oauth2 Proxy OIDC client secret";
      type = "hidden";
    };

    prompts.cookie_secret = {
      description = "*Arr Oauth2 Proxy cookie secret";
      type = "hidden";
    };

    files.keyFile.secret = true;
    script = ''
      cat <<EOL > $out/keyFile
      OAUTH2_PROXY_CLIENT_SECRET=$(<$prompts/client_secret)
      OAUTH2_PROXY_COOKIE_SECRET=$(<$prompts/cookie_secret)
      EOL
    '';
  };

  services.oauth2-proxy = {
    enable = true;

    provider = "oidc";
    scope = "openid email";
    oidcIssuerUrl = config.clan.core.vars.generators.oauth2-proxy.files.oidc_issuer_url.value;
    keyFile = config.clan.core.vars.generators.oauth2-proxy.files.keyFile.path;
    clientID = config.clan.core.vars.generators.oauth2-proxy.files.client_id.value;
    extraConfig = {
      whitelist-domain = [ "*.media.peprolinbot.com" ];
      code-challenge-method = "S256";
    };

    reverseProxy = true;
    nginx = {
      domain = "oauth2-proxy.media.peprolinbot.com";

      virtualHosts = builtins.listToAttrs (
        builtins.map (appName: {
          name = arrAppDomain appName;
          value = { };
        }) arrAppsToProxy
      );
    };

    email.domains = [ "*" ];
    cookie = {
      domain = ".media.peprolinbot.com";
    };
  };
}
