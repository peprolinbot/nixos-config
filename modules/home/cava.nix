{
  inputs,
  pkgs,
  ...
}: {
  programs.cava = {
    enable = true;
  };

  stylix.targets.cava.rainbow.enable = true;
}
