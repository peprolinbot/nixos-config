{
  config,
  lib,
  pkgs,
  ...
}:
{
  clan.core.vars.generators.immich = {
    prompts.openid_secret = {
      description = "OpenID secret for OAuth";
      type = "hidden";
      persist = true;
    };
  };
  services.immich = {
    enable = true;
    package = pkgs.unstable.immich;

    database.enable = true;

    mediaLocation = "/data/immich";

    machine-learning.enable = true;

    settings = {
      server = {
        externalDomain = "https://immich.peprolinbot.com";
      };

      backup = {
        database = {
          cronExpression = "0 02 * * *";
          enabled = true;
          keepLastAmount = 14;
        };
      };

      oauth = {
        autoLaunch = false;
        autoRegister = true;
        buttonText = "Login with FruesAuth";
        clientId = "immich";
        clientSecret._secret = config.clan.core.vars.generators.immich.files.openid_secret.path;
        defaultStorageQuota = 50;
        enabled = true;
        issuerUrl = "https://idm.peprolinbot.com/oauth2/openid/immich";
        mobileOverrideEnabled = false;
        mobileRedirectUri = "";
        profileSigningAlgorithm = "none";
        roleClaim = "immich_role";
        scope = "openid email profile";
        signingAlgorithm = "ES256";
        storageLabelClaim = "uid";
        storageQuotaClaim = "immich_quota";
        timeout = 30000;
        tokenEndpointAuthMethod = "client_secret_basic";
      };
      passwordLogin = {
        enabled = false;
      };
    };
  };

  clan.core.state.immich = {
    folders = [ config.services.immich.mediaLocation ];

    preRestoreScript = ''
      export PATH=${
        lib.makeBinPath [
          config.systemd.package
        ]
      }

      systemctl stop immich
    '';

    postRestoreScript = ''
      export PATH=${
        lib.makeBinPath [
          config.systemd.package
        ]
      }

      systemctl start immich
    '';
  };
}
