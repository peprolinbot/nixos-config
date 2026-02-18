{ pkgs, config, ... }:
{
  clan.core.postgresql = {
    enable = true;
    databases.nextcloud = {
      service = "nextcloud";
      restore.stopOnRestore = [ "nextcloud.service" ];
    };
  };

  clan.core.vars.generators.nextcloud = {
    prompts.instanceid = {
      type = "line";
    };
    prompts.passwordsalt = {
      type = "line";
    };
    prompts.secret = {
      type = "line";
    };

    files.secretFile.secret = true;
    script = ''
      cat <<EOL > $out/secretFile
      {
        "instanceid": "$(<$prompts/instanceid)",
        "passwordsalt": "$(<$prompts/passwordsalt)",
        "secret": "$(<$prompts/secret)"
      }
      EOL
    '';
  };

  environment.etc."default-nextcloud-admin-pass".text = "f1f73da0518e6709a295e95b5f1ca7b7"; # Only used in first install, can be here no problem
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    datadir = "/data/nextcloud";
    hostName = "nextcloud.peprolinbot.com";
    https = true;
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/etc/default-nextcloud-admin-pass";
    };
    secretFile = config.clan.core.vars.generators.nextcloud.files.secretFile.path;
  };
}
