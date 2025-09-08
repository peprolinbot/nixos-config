{osConfig, ...}: {
  imports =
    [./cli.nix]
    ++ (
      if osConfig.hm-pedro.de != "none"
      then [./gui.nix]
      else []
    );
}
