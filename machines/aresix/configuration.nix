{ ... }:
{
  imports = [
    ./modules/reverse-proxy.nix
    ./modules/home-assistant
    ./modules/dyndns.nix
    ./modules/network.nix
    ./modules/wireguard.nix
    ./modules/users.nix
  ];

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  boot.kernelParams = [ "consoleblank=60" ]; # Blanks console (screen off) after 60s
}
