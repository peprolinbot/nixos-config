{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall = {
      enable = true;

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
