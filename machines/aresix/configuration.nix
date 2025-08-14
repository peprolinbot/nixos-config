{...}: {
  imports = [
    ./modules/reverse-proxy.nix
    ./modules/home-assistant.nix
    ./modules/dyndns.nix
  ];

  services.logind.lidSwitch = "ignore";
  boot.kernelParams = ["consoleblank=60"]; # Blanks console (screen off) after 60s

  networking = {
    interfaces = {
      enp1s0.ipv4.addresses = [
        {
          address = "192.168.1.30";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp1s0";
    };
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  system.stateVersion = "25.05";
}
