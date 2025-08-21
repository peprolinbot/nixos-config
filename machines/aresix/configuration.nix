{...}: {
  imports = [
    ./modules/reverse-proxy.nix
    ./modules/home-assistant
    ./modules/dyndns.nix
    ./modules/network.nix
  ];

  services.logind.lidSwitch = "ignore";
  boot.kernelParams = ["consoleblank=60"]; # Blanks console (screen off) after 60s

  system.stateVersion = "25.05";
}
