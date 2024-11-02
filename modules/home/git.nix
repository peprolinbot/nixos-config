{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "Pedro Rey Anca";
    userEmail = "personal@peprolinbot.com";

    signing = {
      signByDefault = true;
      key = null; # Let GnuPG decide what signing key to use depending on commit’s author.
    };

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
