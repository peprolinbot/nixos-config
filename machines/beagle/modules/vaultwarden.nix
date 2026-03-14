{
  config,
  lib,
  pkgs,
  ...
}:
{
  clan.core.vars.generators = {
    vaultwarden-smtp = {
      prompts.smtp_host = {
        type = "line";
        persist = true;
      };
      files.smtp_host.secret = false;
      files.smtp_host.deploy = false;

      prompts.smtp_username = {
        type = "line";
        persist = true;
      };
      files.smtp_username.deploy = false;

      prompts.smtp_password = {
        type = "hidden";
        persist = true;
      };
      files.smtp_password.deploy = false;
    };

    vaultwarden-oidc = {
      prompts.issuer = {
        description = "OpenID Connect Discovery endpoint for Vaultwarden SSO. The URL must not include the /.well-known/openid-configuration";
        type = "line";
        persist = true;
      };
      files.issuer.secret = false;
      files.issuer.deploy = false;

      prompts.client_id = {
        type = "line";
        persist = true;
      };
      files.client_id.deploy = false;

      prompts.client_secret = {
        type = "hidden";
        persist = true;
      };
      files.client_secret.deploy = false;
    };

    vaultwarden = {
      dependencies = [
        "vaultwarden-smtp"
        "vaultwarden-oidc"
      ];

      prompts.admin_token = {
        type = "hidden";
      };

      files.environmentFile.secret = true;
      script = ''
        export PATH=${
          lib.makeBinPath [
            pkgs.coreutils
            pkgs.libargon2
            pkgs.openssl
          ]
        }
        cat <<EOL > $out/environmentFile
        SMTP_USERNAME=$(<$in/vaultwarden-smtp/smtp_username)
        SMTP_PASSWORD=$(<$in/vaultwarden-smtp/smtp_password)
        SSO_CLIENT_ID=$(<$in/vaultwarden-oidc/client_id)
        SSO_CLIENT_SECRET=$(<$in/vaultwarden-oidc/client_secret)
        ADMIN_TOKEN=$(echo -n "$(<$prompts/admin_token)" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4)
        EOL
      '';
    };
  };

  services.vaultwarden = {
    enable = true;
    domain = "bitwarden.peprolinbot.com";
    environmentFile = config.clan.core.vars.generators.vaultwarden.files.environmentFile.path;
    backupDir = "/var/backup/vaultwarden";
    configureNginx = true;
    config = {
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";

      SMTP_HOST = config.clan.core.vars.generators.vaultwarden-smtp.files.smtp_host.value;
      SMTP_FROM = "vaultwarden@peprolinbot.com";
      SMTP_FROM_NAME = "Frues Vaultwarden";

      SSO_ENABLED = true;
      SSO_ONLY = true;
      SSO_AUTHORITY = config.clan.core.vars.generators.vaultwarden-oidc.files.issuer.value;
    };
  };
}
