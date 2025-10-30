{
  config,
  pkgs,
  ...
}:
{
  services.postgresql =
    let
      databases = [
        "matrix-synapse"
        "mautrix-signal"
        "mautrix-whatsapp"
        "mautrix-telegram"
      ];
    in
    {
      enable = true;

      ensureDatabases = databases;
      # Create a user for each database
      ensureUsers = map (id: {
        name = id;
        ensureDBOwnership = true;
      }) databases;

      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE "matrix-synapse" WITH LOGIN;
        CREATE DATABASE "matrix-synapse"
          WITH ENCODING = 'UTF8'
          TEMPLATE = template0
          OWNER = "matrix-synapse"
          LC_COLLATE = 'C'
          LC_CTYPE = 'C';
      '';

    };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "peprolinbot.com";
      public_baseurl = "https://synapse.peprolinbot.com/";
      listeners = [
        {
          bind_addresses = [ "::1" ];
          port = 8008;
          resources = [
            {
              compress = false;
              names = [
                "client"
                "federation"
              ];
            }
          ];
          tls = false;
          type = "http";
          x_forwarded = true;
        }
      ];
      database = {
        name = "psycopg2";
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
        };
      };
      report_stats = false;

      experimental_features = {
        # Enable history backfilling support
        msc2716_enabled = true;
      };
      max_upload_size = "1024M";

      oidc_providers = [
        {
          idp_id = "kanidm";
          idp_name = "FruesAuth";
          idp_icon = "mxc://peprolinbot.com/oKncNzBglyvNwvwsPMkxoPsK";
          issuer = "https://idm.peprolinbot.com/oauth2/openid/matrix/";
          client_id = "matrix";
          client_secret_path =
            config.clan.core.vars.generators.matrix-synapse.files.kanidm_oidc_client_secret.path;
          scopes = [
            "openid"
            "profile"
            "email"
          ];
          user_mapping_provider.config = {
            localpart_template = "{{ user.preferred_username }}";
            display_name_template = "{{ user.name }}";
            email_template = "{{ user.email }}";
          };
        }
      ];
    };
  };

  clan.core.vars.generators.matrix-synapse = {
    prompts = {
      kanidm_oidc_client_secret = {
        description = "Client secret to use Kanidm as OIDC provider in Matrix Synapse";
        type = "hidden";
        persist = true;
      };
    };

    files.kanidm_oidc_client_secret = {
      owner = config.systemd.services.matrix-synapse.serviceConfig.User;
      group = config.systemd.services.matrix-synapse.serviceConfig.Group;
    };
  };

  services.mautrix-whatsapp = {
    enable = true;
    registerToSynapse = true;

    environmentFile = config.clan.core.vars.generators.mautrix-whatsapp.files.environment-file.path;

    settings = {
      homeserver = {
        address = "http://[::1]:8008";
        domain = "peprolinbot.com";
      };

      appservice = {
        address = "http://localhost:29318"; # The address that the homeserver can use to connect to this appservice.
        hostname = "[::1]";
        port = 29318;
      };

      database = {
        type = "postgres";
        uri = "postgresql:///mautrix-whatsapp?host=/var/run/postgresql";
      };

      network = {
        os_name = "Mautrix-WhatsApp bridge";
        displayname_template = "{{if .FullName}}{{.FullName}}{{else if .BusinessName}}{{.BusinessName}}{{else if .PushName}}{{.PushName}}{{else}}{{.JID}}{{end}} (WA)";
      };

      bridge = {
        permissions = {
          "@peprolinbot:peprolinbot.com" = "admin";
          "peprolinbot.com" = "user";
          "*" = "relay";
        };
      };

      encryption = {
        allow = true;

      };

      # Secrets set using environment file
      encryption.pickle_key = "$ENCRYPTION_PICKLE_KEY";
    };
  };

  clan.core.vars.generators.mautrix-whatsapp = {
    prompts.encryption_pickle_key = {
      type = "hidden";
    };

    files.environment-file.secret = true;
    script = ''
      cat <<EOL > $out/environment-file
      ENCRYPTION_PICKLE_KEY = $(<$prompts/encryption_pickle_key)
      EOL
    '';
  };

  services.mautrix-signal = {
    enable = true;
    registerToSynapse = true;

    environmentFile = config.clan.core.vars.generators.mautrix-signal.files.environment-file.path;

    settings = {
      homeserver = {
        address = "http://[::1]:8008";
        domain = "peprolinbot.com";
      };

      appservice = {
        address = "http://localhost:29328"; # The address that the homeserver can use to connect to this appservice.
        hostname = "[::1]";
        port = 29328;
      };

      database = {
        type = "postgres";
        uri = "postgresql:///mautrix-signal?host=/run/postgresql";
      };

      bridge = {
        displayname_template = "{displayname} (TG)";

        permissions = {
          "@peprolinbot:peprolinbot.com" = "admin";
          "peprolinbot.com" = "user";
          "*" = "relay";
        };
      };

      encryption = {
        allow = true;
      };

      # Secrets set using environment file
      encryption.pickle_key = "$ENCRYPTION_PICKLE_KEY";
    };
  };

  clan.core.vars.generators.mautrix-signal = {
    prompts.encryption_pickle_key = {
      type = "hidden";
    };

    files.environment-file.secret = true;
    script = ''
      cat <<EOL > $out/environment-file
      ENCRYPTION_PICKLE_KEY = $(<$prompts/encryption_pickle_key)
      EOL
    '';
  };

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  services.mautrix-telegram = {
    enable = true;
    registerToSynapse = true;

    environmentFile = config.clan.core.vars.generators.mautrix-telegram.files.environment-file.path;

    settings = {
      homeserver = {
        address = "http://[::1]:8008";
        domain = "peprolinbot.com";
      };

      appservice = {
        address = "http://localhost:29317"; # The address that the homeserver can use to connect to this appservice.
        hostname = "localhost";
        port = 29317;

        database = "postgresql:///mautrix-telegram?host=/var/run/postgresql";
      };

      bridge = {
        permissions = {
          "@peprolinbot:peprolinbot.com" = "admin";
          "peprolinbot.com" = "full";
          "*" = "relaybot";
        };

        encryption = {
          allow = true;
        };

        logging.writers = [
          {
            type = "journald";
          }
        ];
      };
    };
  };

  systemd.services.mautrix-telegram.path = [ pkgs.lottieconverter ]; # for animated stickers conversion, unfree package

  clan.core.vars.generators.mautrix-telegram = {
    prompts.appservice_as_token = {
      type = "hidden";
    };

    prompts.appservice_hs_token = {
      type = "hidden";
    };

    prompts.telegram_api_id = {
      type = "hidden";
    };

    prompts.telegram_api_hash = {
      type = "hidden";
    };

    files.environment-file.secret = true;
    script = ''
      cat <<EOL > $out/environment-file
      MAUTRIX_TELEGRAM_TELEGRAM_API_ID = $(<$prompts/telegram_api_id)
      MAUTRIX_TELEGRAM_TELEGRAM_API_HASH = $(<$prompts/telegram_api_hash)
      EOL
    '';
  };
}
