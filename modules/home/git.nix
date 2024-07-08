{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "peprolinbot";
    userEmail = "personal@peprolinbot.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
