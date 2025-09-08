{
  pkgs,
  osConfig,
  ...
}: {
  programs.gpg = {
    enable = true;
    settings = {
      keyserver = "hkps://keys.openpgp.org";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry = {
      package =
        if osConfig.hm-pedro.de == "none"
        then pkgs.pinentry-curses
        else pkgs.pinentry-gnome3;
      program = "pinentry-gnome3";
    };
    sshKeys = ["D2A3680589B81F2B07DA6CFE21DF848F1AF4E9D3"];
  };
}
