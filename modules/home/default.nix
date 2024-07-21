{
  inputs,
  username,
  host,
  ...
}: {
  imports =
    [(import ./bat.nix)] # better cat command
    ++ [(import ./btop.nix)] # resouces monitor
    ++ [(import ./cava.nix)] # audio visualizer
    ++ [(import ./discord.nix)] # discord with catppuccin theme
    ++ [(import ./floorp/floorp.nix)] # firefox based browser
    ++ [(import ./fuzzel.nix)] # launcher
    ++ [(import ./gaming.nix)] # packages related to gaming
    ++ [(import ./git.nix)] # version control
    ++ [(import ./gtk.nix)] # gtk theme
    ++ [(import ./hyprland)] # window manager
    ++ [(import ./kdeconnect.nix)]
    ++ [(import ./kitty.nix)] # terminal
    ++ [(import ./swaync/swaync.nix)] # notification deamon
    ++ [(import ./nextcloud.nix)] # nextcloud client
    ++ [(import ./nvim.nix)] # neovim editor
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./retroarch.nix)]
    ++ [(import ./scripts/scripts.nix)] # personal scripts
    ++ [(import ./spotify.nix)]
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./qt.nix)]
    ++ [(import ./vscodium.nix)] # vscode forck
    ++ [(import ./waybar)] # status bar
    ++ [(import ./zsh.nix)]; # shell
}
