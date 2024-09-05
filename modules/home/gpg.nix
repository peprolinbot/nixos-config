{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    sshKeys = ["D2A3680589B81F2B07DA6CFE21DF848F1AF4E9D3"];
  };
}
