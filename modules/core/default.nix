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
    ++ [(import ./network.nix)]
    ++ [(import ./pipewire.nix)]
    ++ [(import ./programs.nix)]
    ++ [(import ./security.nix)]
    ++ [(import ./services.nix)]
    ++ [(import ./gaming.nix)]
    ++ [(import ./system.nix)]
    ++ [(import ./user.nix)]
    ++ [(import ./wayland.nix)]
    ++ [(import ./variables.nix)]
    ++ [(import ./virtualisation.nix)];
}
