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
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        iptables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip6tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        iptables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
        ip6tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        iptables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip6tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        iptables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
        ip6tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
