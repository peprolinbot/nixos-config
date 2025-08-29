{config, ...}: {
  clan.core.vars.generators.wg-access-server = {
    prompts.admin-password = {
      description = "Password for the wg-access-server admin user";
      type = "hidden";
    };

    prompts.wireguard-private-key = {
      description = "Wireguard private key wg-access-server will use";
      type = "hidden";
    };

    files.secrets-file.secret = true;
    script = ''
      cat <<EOL > $out/secrets-file
      adminPassword: $(<$prompts/admin-password)
      wireguard:
        privateKey: $(<$prompts/wireguard-private-key)
      EOL
    '';
  };

  services.wg-access-server = {
    enable = true;

    settings = {
      httpHost = "::1";
    };

    secretsFile = config.clan.core.vars.generators.wg-access-server.files.secrets-file.path;
  };
  networking.firewall.allowedUDPPorts = [51820 53];
}
