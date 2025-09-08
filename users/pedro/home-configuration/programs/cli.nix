{...}: {
  programs.bat.enable = true;

  programs.btop.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
