{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    hunspell
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise
    hunspellDicts.es_ES
  ];
}
