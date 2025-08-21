{config, ...}: {
  clan.core.vars.generators.duckdns = {
    prompts.token = {
      description = "Duck DNS token used to update the Dynamic DNS";
      type = "hidden";
      persist = true;
    };
  };

  services.duckdns = {
    enable = true;
    domains = ["campares.duckdns.org"];
    tokenFile = config.clan.core.vars.generators.duckdns.files.token.path;
  };
}
