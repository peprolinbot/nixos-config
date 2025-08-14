{config, ...}: {
  services.duckdns = {
    enable = true;
    domains = ["campares.duckdns.org"];
    tokenFile = config.sops.secrets.duckdns-token.path;
  };
}
