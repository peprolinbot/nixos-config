{pkgs, ...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    package = pkgs.sudo.override {withInsults = true;}; # I'm spanish and I love cursing
  };

  security.pam.services.hyprlock = {};
}
