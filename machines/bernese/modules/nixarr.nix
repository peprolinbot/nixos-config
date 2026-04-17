{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixarr.nixosModules.default ];

  clan.core.vars.generators.nixarr = {
    prompts.wg-vpn-config = {
      description = "Wireguard configuration for Nixarr VPN";
      type = "multiline";
      persist = true;
    };
  };

  nixarr = {
    enable = true;
    mediaDir = "/data/media";
    stateDir = "/data/media/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = config.clan.core.vars.generators.nixarr.files.wg-vpn-config.path;
    };

    jellyfin = {
      enable = true;
      openFirewall = false;
    };

    bazarr = {
      enable = true;
      openFirewall = false;
    };
    prowlarr = {
      enable = true;
      openFirewall = false;
    };
    radarr = {
      enable = true;
      openFirewall = false;
    };
    sonarr = {
      enable = true;
      port = 8988; # 8989 used by mycelium
      openFirewall = false;
    };

    jellyseerr.enable = true;

    recyclarr = {
      enable = true;
      configuration = {
        sonarr = {
          series = {
            base_url = "http://localhost:8988";
            api_key = "!env_var SONARR_API_KEY";

            delete_old_custom_formats = true;
            replace_existing_custom_formats = true;

            include = [
              # Quality sizes (only needed once)
              { template = "sonarr-quality-definition-series"; }

              # HD Bluray + WEB (1080p)
              { template = "sonarr-v4-quality-profile-web-1080p"; }
              { template = "sonarr-v4-custom-formats-web-1080p"; }
            ];
          };
        };
        radarr = {
          movies = {
            base_url = "http://localhost:7878";
            api_key = "!env_var RADARR_API_KEY";

            delete_old_custom_formats = true;
            replace_existing_custom_formats = true;

            include = [
              # Quality sizes (only needed once)
              { template = "radarr-quality-definition-movie"; }

              # HD Bluray + WEB (1080p)
              { template = "radarr-quality-profile-hd-bluray-web"; }
              { template = "radarr-custom-formats-hd-bluray-web"; }
            ];
          };
        };
      };
    };
  };

  services.flaresolverr = {
    enable = true;
  };

  services.radarr.settings.auth.method = "External";
  services.sonarr.settings.auth.method = "External";
  services.prowlarr.settings.auth.method = "External";

  # Define VPN network namespace
  vpnNamespaces.wg.portMappings = [
    {
      from = config.services.qbittorrent.webuiPort;
      to = config.services.qbittorrent.webuiPort;
    }
  ];
  vpnNamespaces.wg.openVPNPorts = [
    {
      port = config.services.qbittorrent.torrentingPort;
      protocol = "both";
    }
  ];

  services.qbittorrent = {
    enable = true;
    group = "media";
    torrentingPort = 7864;
  };

  clan.core.vars.generators.qui-oidc = {
    prompts.issuer = {
      description = "OpenID Connect Discovery endpoint for qui. The URL must not include the /.well-known/openid-configuration";
      type = "line";
      persist = true;
    };
    files.issuer.secret = false;
    files.issuer.deploy = false;

    prompts.client_id = {
      type = "line";
      persist = true;
    };
    files.client_id.secret = false;
    files.client_id.deploy = false;

    prompts.client_secret = {
      type = "hidden";
      persist = true;
    };
    files.client_secret = {
      owner = config.services.qui.user;
      group = config.services.qui.group;
    };
  };
  clan.core.vars.generators.qui-sessionSecret = {
    files.secretFile.secret = true;
    script = ''
      export PATH=${
        lib.makeBinPath [
          pkgs.openssl
        ]
      }

      openssl rand -hex 32 > $out/secretFile
    '';
  };

  services.qui = {
    enable = true;
    group = "media";
    secretFile = config.clan.core.vars.generators.qui-sessionSecret.files.secretFile.path;
    settings = {
      oidcEnabled = true;
      oidcIssuer = config.clan.core.vars.generators.qui-oidc.files.issuer.value;
      oidcClientId = config.clan.core.vars.generators.qui-oidc.files.client_id.value;
      # oidcClientSecretFile = config.clan.core.vars.generators.qui-oidc.files.client_secret.path; # Not supported
      oidcRedirectUrl = "https://qui.media.peprolinbot.com/api/auth/oidc/callback";
      oidcDisableBuiltInLogin = true;
    };
  };
  systemd.services.qui.serviceConfig.Environment = [
    "QUI__OIDC_CLIENT_SECRET_FILE=${config.clan.core.vars.generators.qui-oidc.files.client_secret.path}"
  ];

  # Add systemd service to VPN network namespace
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "wg";
  };
}
