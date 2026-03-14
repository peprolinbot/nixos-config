{
  pkgs,
  config,
  ...
}:
{
  clan.core.postgresql = {
    enable = true;
    databases.nextcloud = {
      service = "nextcloud";
      restore.stopOnRestore = [ "nextcloud.service" ];
    };
  };

  clan.core.vars.generators.nextcloud = {
    prompts.admin-pass = {
      type = "hidden";
      description = "Default nextcloud admin password (only used first install)";
      persist = true;
    };

    prompts.instanceid = {
      type = "line";
    };
    prompts.passwordsalt = {
      type = "line";
    };
    prompts.secret = {
      type = "line";
    };

    prompts.whiteboard-jwt_secret_key = {
      type = "line";
    };

    files.secretFile.secret = true;
    files.whiteboardSecretFile.secret = true;
    script = ''
      cat <<EOL > $out/secretFile
      {
        "instanceid": "$(<$prompts/instanceid)",
        "passwordsalt": "$(<$prompts/passwordsalt)",
        "secret": "$(<$prompts/secret)"
      }
      EOL

      cat <<EOL > $out/whiteboardSecretFile
      JWT_SECRET_KEY=$(<$prompts/whiteboard-jwt_secret_key)
      EOL
    '';
  };

  clan.core.vars.generators.collabora = {
    prompts.username = {
      type = "line";
      description = "Username for the Collabora Online admin console";
    };
    prompts.password = {
      type = "hidden";
      description = "Password for the Collabora Online admin console";
    };

    files.envFile.secret = true;
    script = ''
      cat <<EOL > $out/envFile
      username=$(<$prompts/username)
      password=$(<$prompts/password)
      EOL
    '';
  };

  services.nextcloud-whiteboard-server = {
    enable = true;
    settings.NEXTCLOUD_URL = "https://${config.services.nextcloud.hostName}";
    secrets = [ config.clan.core.vars.generators.nextcloud.files.whiteboardSecretFile.path ];
  };

  virtualisation.oci-containers.containers.collabora = {
    image = "docker.io/collabora/code:latest";
    ports = [ "127.0.0.1:9980:9980/tcp" ];
    environment = {
      server_name = "collabora.peprolinbot.com";
      aliasgroup1 = "https://${config.services.nextcloud.hostName}:443";
      dictionaries = "en_GB en_US es_ES fr_FR gl_ES";
      extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
    };
    # environmentFiles = [ config.clan.core.vars.generators.collabora.files.envFile.path ];
    extraOptions = [
      "--pull=newer"
    ];
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    datadir = "/data/nextcloud";
    hostName = "nextcloud.peprolinbot.com";
    https = true;
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = config.clan.core.vars.generators.nextcloud.files.admin-pass.path;
    };
    secretFile = config.clan.core.vars.generators.nextcloud.files.secretFile.path;
  };

  clan.core.state.nextcloud = {
    folders = [ config.services.nextcloud.datadir ];

    preRestoreScript = ''
      nextcloud-occ maintenance:mode --on
    '';

    postRestoreScript = ''
      nextcloud-occ maintenance:mode --off
    '';
  };
}
