{pkgs, ...}: {
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications =
    {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
      "application/pdf" = ["okularApplication_pdf.desktop" "org.gnome.Evince.desktop"];
      "text/plain" = ["org.gnome.TextEditor.desktop"];
    }
    // builtins.listToAttrs (map (key: {
      name = "image/${key}";
      value = ["vimiv.desktop"];
    }) ["png" "jpeg" "webp" "bmp" "gif"])
    // builtins.listToAttrs (map (key: {
      name = "video/${key}";
      value = ["mpv.desktop"];
    }) ["mp4" "x-matroska" "webm"]);

  home.packages = with pkgs; [
    bemoji # emoji picker
    bitwise # cli tool for bit / hex manipulation
    bitwarden-cli
    distrobox
    boxbuddy
    evince # gnome pdf viewer
    eza # cool ls
    element-desktop # Matrix client
    fd # find replacement
    file # Show file information
    file-roller # Archive manager
    freetube # YouTube client
    fzf # fuzzy finder
    gimp
    gnome-text-editor
    gtrash # rm replacement, put deleted files in system trash
    imagemagick
    inkscape
    kleopatra # Gpg GUI
    lazygit
    nemo-with-extensions # file manager
    jq
    nitch # systhem fetch util
    nix-prefetch-github
    kdePackages.okular # KDE's pdf viewer/editor (supports digital signing)
    simple-scan
    orca-slicer
    tdf # cli pdf viewer
    speedcrunch
    thunderbird
    todo # cli todo list
    toipe # typing test in the terminal
    transmission_4-gtk # torrent client
    vlc
    xournalpp # For notes and pdf editing
    yazi # terminal file manager
    yt-dlp
    zenity
    wdisplays
    wireguard-tools
    wtype

    # Wine stuff
    winetricks
    wineWowPackages.wayland
    bottles

    # C / C++
    gcc
    gnumake

    # Python
    python3

    cmatrix
    caligula
    gparted # partition manager
    ffmpeg
    vimiv-qt # Image viewer, vim-like
    killall
    libnotify
    man-pages # extra man pages
    mpv # video player
    openssl
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume controle (GUI)
    playerctl # controller for media players
    wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
    poweralertd
    qalculate-gtk # calculator
    unzip
    wget
    xdg-utils
    xxd
    alejandra

    # VPN
    wireguard-tools
    openconnect
    networkmanager-openconnect
  ];
}
