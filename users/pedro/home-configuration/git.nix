{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Pedro Rey Anca";
        email = "personal@peprolinbot.com";

        init.defaultBranch = "main";
        credential.helper = "store";
      };
    };

    signing = {
      signByDefault = true;
      key = null; # Let GnuPG decide what signing key to use depending on commit’s author.
    };
  };
}
