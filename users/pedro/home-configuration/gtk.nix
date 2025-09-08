{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
  };
}
