{osConfig, ...}: {
  imports =
    [
      ./programs
      ./distrobox.nix
      ./git.nix
      ./gpg.nix
      ./packages.nix
      ./services.nix
      ./stylix.nix
      ./zsh.nix
    ]
    ++ (
      if osConfig.hm-pedro.de != "none"
      then [
        ./browsers
        ./gtk.nix
        ./kitty.nix
        ./libreoffice.nix
        ./nemo.nix
        ./qt.nix
        ./spotify.nix
        ./vscodium.nix
      ]
      else []
    )
    ++ (
      if osConfig.hm-pedro.de == "hyprland"
      then [
        ./hyprland
        ./scripts
        ./waybar
        ./mako.nix
      ]
      else []
    );
}
