{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto

    twemoji-color-font
    noto-fonts-emoji
    roboto
  ];

  gtk = {
    enable = true;
  };
}
