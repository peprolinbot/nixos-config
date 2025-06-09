{
  inputs,
  username,
  host,
  ...
}: {
  imports =
    [(import ./bat.nix)] # better cat command
    ++ [(import ./browsers)] # browser configurations
    ++ [(import ./btop.nix)] # resouces monitor
    ++ [(import ./cava.nix)] # audio visualizer
    ++ [(import ./cliphist.nix)] # clipboard
    ++ [(import ./discord.nix)] # discord with catppuccin theme
    ++ [(import ./gpg.nix)] # GnuPG and its agent (gpg-agent)
    ++ [(import ./fuzzel.nix)] # launcher
    ++ [(import ./gaming.nix)] # packages related to gaming
    ++ [(import ./git.nix)] # version control
    ++ [(import ./gtk.nix)] # gtk theme
    ++ [(import ./hyprland)] # window manager
    ++ [(import ./kdeconnect.nix)]
    ++ [(import ./kitty.nix)] # terminal
    ++ [(import ./swaync)] # notification deamon
    ++ [(import ./nemo.nix)] # File manager
    ++ [(import ./nextcloud.nix)] # nextcloud client
    ++ [(import ./nvim.nix)] # neovim editor
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./retroarch.nix)]
    ++ [(import ./scripts)] # personal scripts
    ++ [(import ./spotify.nix)]
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./libreoffice.nix)]
    ++ [(import ./qt.nix)]
    ++ [(import ./stylix.nix)] # shell
    ++ [(import ./vscodium.nix)] # vscode forck
    ++ [(import ./waybar)] # status bar
    ++ [(import ./zsh.nix)]; # shell
}
