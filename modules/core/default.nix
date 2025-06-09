{
  inputs,
  nixpkgs,
  self,
  username,
  host,
  ...
}: {
  imports =
    [(import ./bootloader.nix)]
    ++ [(import ./hardware.nix)]
    ++ [(import ./xserver.nix)]
    ++ [(import ./nix.nix)]
    ++ [(import ./network.nix)]
    ++ [(import ./pipewire.nix)]
    ++ [(import ./programs.nix)]
    ++ [(import ./security.nix)]
    ++ [(import ./services.nix)]
    ++ [(import ./gaming.nix)]
    ++ [(import ./system.nix)]
    ++ [(import ./stylix.nix)]
    ++ [(import ./user.nix)]
    ++ [(import ./wayland.nix)]
    ++ [(import ./virtualisation.nix)];
}
