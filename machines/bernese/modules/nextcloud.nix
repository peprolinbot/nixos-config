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

  services.nextcloud-whiteboard-server = {
    enable = true;
    settings.NEXTCLOUD_URL = "https://${config.services.nextcloud.hostName}";
    secrets = [ config.clan.core.vars.generators.nextcloud.files.whiteboardSecretFile.path ];
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
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
