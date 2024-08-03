{
  pkgs,
  pkgs-unstable,
  ...
}: {
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["nemo.desktop"];
    "application/pdf" = ["okularApplication_pdf.desktop" "org.gnome.Evince.desktop"];
    "text/plain" = ["org.gnome.TextEditor.desktop"];
  };

  home.packages =
    (with pkgs; [
      bemoji # emoji picker
      bitwise # cli tool for bit / hex manipulation
      bitwarden-cli
      evince # gnome pdf viewer
      element-desktop # Matrix client
      fd # find replacement
      file # Show file information
      gnome.file-roller # Archive manager
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
      kdePackages.okular # KDE's pdf viewer/editor (supports digital signing)
      ripgrep # grep replacement
      simple-scan
      swappy
      # tdf # cli pdf viewer
      thunderbird
      todo # cli todo list
      toipe # typing test in the terminal
      transmission_4-gtk # torrent client
      vlc
      xournalpp # For notes and pdf editing
      yazi # terminal file manager
      yt-dlp
      gnome.zenity
      wdisplays
      wireguard-tools
      winetricks
      wineWowPackages.wayland
      wtype

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
    ])
    ++ (with pkgs-unstable; [
      tdf # cli pdf viewer
    ]);
}
