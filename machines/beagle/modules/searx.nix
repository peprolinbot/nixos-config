{ config, ... }:
{
  clan.core.vars.generators.searx = {
    prompts.secret-key = {
      description = "SearX server.secret_key";
      type = "hidden";
    };

    files.environment-file.secret = true;
    script = ''
      cat <<EOL > $out/environment-file
      SEARX_SECRET_KEY=$(<$prompts/secret-key)
      EOL
    '';
  };

  services.searx = {
    enable = true;
    domain = "searx.peprolinbot.com";
    configureNginx = true;
    redisCreateLocally = true;
    environmentFile = config.clan.core.vars.generators.searx.files.environment-file.path;
    settings = {
      server.secret_key = "$SEARX_SECRET_KEY";
    };
  };
}
