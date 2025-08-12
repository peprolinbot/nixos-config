{...}: {
  imports = [

  ];

  services.logind.lidSwitch = "ignore";
  boot.kernelParams = ["consoleblank=60"]; # Blanks console (screen off) after 60s

  system.stateVersion = "25.05";
}
