{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwise # cli tool for bit / hex manipulation
    bitwarden-cli
    evince # gnome pdf viewer
    element-desktop # Matrix client
    fd # find replacement
    file # Show file information
    flameshot # Screenshot tool
    fzf # fuzzy finder
    gimp
    gtrash # rm replacement, put deleted files in system trash
    imagemagick
    inkscape
    lazygit
    libreoffice
    cinnamon.nemo-with-extensions # file manager
    jq
    nitch # systhem fetch util
    nix-prefetch-github
    ripgrep # grep replacement
    simple-scan
    swappy
    tdf # cli pdf viewer
    todo # cli todo list
    toipe # typing test in the terminal
    vlc
    yazi # terminal file manager
    yt-dlp
    zenity
    winetricks
    wineWowPackages.wayland

    # C / C++
    gcc
    gnumake

    # Python
    python3

    cmatrix
    gparted # partition manager
    ffmpeg
    imv # image viewer
    killall
    libnotify
    man-pages # extra man pages
    mpv # video player
    openssl
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume controle (GUI)
    playerctl # controller for media players
    wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
    cliphist # clipboard manager
    poweralertd
    qalculate-gtk # calculator
    unzip
    wget
    xdg-utils
    xxd
    alejandra
  ];
}
