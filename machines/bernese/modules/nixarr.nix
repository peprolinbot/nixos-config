{ inputs, config, ... }:
{
  imports = [ inputs.nixarr.nixosModules.default ];

  clan.core.vars.generators.nixarr = {
    prompts.wg-vpn-config = {
      description = "Wireguard configuration for Nixarr VPN";
      type = "multiline";
      persist = true;
    };
  };

  clan.core.vars.generators.transmission = {
    prompts.rpc-username = {
      description = "Transmission rpc-username";
      type = "line";
    };

    prompts.rpc-password = {
      description = "Transmission rpc-password";
      type = "hidden";
    };

    files.credentialsFile.secret = true;
    files.nginxProxySetHeader = {
      secret = true;
      owner = "nginx";
      group = "nginx";
    };
    script = ''
      cat <<EOL > $out/credentialsFile
      {
        "rpc-username": "$(<$prompts/rpc-username)",
        "rpc-password": "$(<$prompts/rpc-password)"
      }
      EOL

      cat <<EOL > $out/nginxProxySetHeader
      proxy_set_header Authorization "Basic $(echo -n "$(<$prompts/rpc-username):$(<$prompts/rpc-password)" | base64 -w 0)";
      EOL
    '';
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

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 23068; # Forwarded by VPN

      privateTrackers.cross-seed = {
        enable = true;
        indexIds = [ 8 ];
      };

      flood.enable = true;
      openFirewall = false;

      extraSettings = {
        rpc-authentication-required = true;
      };
      credentialsFile = config.clan.core.vars.generators.transmission.files.credentialsFile.path;
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
}
