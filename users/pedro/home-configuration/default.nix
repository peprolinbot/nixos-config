{
  osConfig,
  lib,
  ...
}: {
  imports =
    [
      ./programs
      ./distrobox.nix
      ./helix.nix
      ./git.nix
      ./gpg.nix
      ./packages.nix
      ./services.nix
      ./stylix.nix
      ./zsh.nix
    ]
    ++ (
      lib.lists.optionals (osConfig.hm-pedro.de != "none")
      [
        ./browsers
        ./gtk.nix
        ./kitty.nix
        ./libreoffice.nix
        ./nemo.nix
        ./qt.nix
        ./spotify.nix
        ./vscodium.nix
      ]
    )
    ++ (
      lib.lists.optionals (osConfig.hm-pedro.de == "hyprland")
      [
        ./hyprland
        ./scripts
        ./waybar
        ./mako.nix
      ]
    );
}
