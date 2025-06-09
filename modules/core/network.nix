{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 59010 59011];
      allowedUDPPorts = [59010 59011];
      # allowedUDPPortRanges = [
      # { from = 4000; to = 4007; }
      # { from = 8000; to = 8010; }
      # ];

      ### https://nixos.wiki/wiki/WireGuard#Setting_up_WireGuard_with_NetworkManager
      checkReversePath = "loose";
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet

    wireguard-tools

    openconnect
    networkmanager-openconnect
  ];
}
