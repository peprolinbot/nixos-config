{pkgs, ...}: {
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      update_ms = 500;
    };
  };
}
