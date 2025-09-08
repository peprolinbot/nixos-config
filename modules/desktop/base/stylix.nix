{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    homeManagerIntegration.autoImport = false; # Handled in each user's HM config
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      console.enable = false;
      grub.enable = false;
    };
  };
}
