{pkgs, ...}: {
  home.packages = with pkgs; [
    (retroarch.withCores (cores:
      with cores; [
        fceumm
        gambatte
        mgba
        snes9x
      ]))
  ];
}
