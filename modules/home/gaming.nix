{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [(import ./retroarch.nix)];

  home.packages = with pkgs; [
    ## Utils
    # gamemode
    gamescope
    # winetricks
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    # Launchers (Steam isn't here)
    lutris
    heroic

    ## Minecraft
    inputs.fjordlauncher.packages.${pkgs.system}.fjordlauncher

    ## Cli games
    vitetris
    nethack

    ## Celeste
    celeste-classic
    celeste-classic-pm

    ## Doom
    # gzdoom
    crispy-doom

    ## Emulation
    sameboy
    snes9x
    cemu
    dolphin-emu
    ryujinx

    ## Others
    moonlight-qt
    ukmm # BOTW mod manager
  ];
}
