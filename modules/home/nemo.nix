{pkgs, ...}: {
  home.packages = with pkgs; [nemo-with-extensions];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["nemo.desktop"];
    "application/x-gnome-saved-search" = ["nemo.desktop"];
  };
  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty";
    };
  };
}
