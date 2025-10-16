{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  hasDE = osConfig.hm-pedro.de != "none";
in {
  xdg.mimeApps = lib.mkif (osConfig.hm-pedro.de != "none") {
    enable = true;
    xdg.mimeApps.defaultApplications =
      {
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
  };

  home.packages = with pkgs; ([
      # CLI utils
      bitwarden-cli
      file # Show file information
      gtrash # rm replacement, put deleted files in system trash
      imagemagick
      lazygit # Simple terminal UI for git commands
      jq # command-line JSON processor
      nitch # neofetch-like util
      tdf # cli pdf viewer
      todo # cli todo list
      yazi # terminal file manager
      yt-dlp
      caligula # TUI for disk imaging
      ffmpeg
      killall
      man-pages # extra man pages
      openssl
      unzip
      wget
      usbutils
      gotify-cli
    ]
    ++ (
      lib.lists.optionals (osConfig.hm-pedro.de != "none") [
        # CLI but only makes sense in DE
        pamixer # pulseaudio command line mixer
        playerctl # controller for media players

        # GUI Utils
        zenity # Create GTK dialog boxes from CLI
        file-roller # Archive manager
        wdisplays # Configuring displays in Wayland compositors
        pavucontrol # pulseaudio volume controle (GUI)

        # GUI Apps
        evince # gnome pdf viewer
        freetube # YouTube client
        thunderbird
        vlc
        mpv # video player
        xournalpp # For notes and pdf editing
        rnote # Modern alternative to Xournal++
        qbittorrent # torrent client
        speedcrunch # Fast power user calculator
        simple-scan
        orca-slicer
        kdePackages.okular # KDE's pdf viewer/editor (supports digital signing)
        inkscape
        kdePackages.kleopatra # GPG GUI
        gimp
        gnome-text-editor
        gparted # partition manager
        vimiv-qt # Image viewer, vim-like
        webcord

        # Wine stuff
        winetricks
        wineWowPackages.wayland
        bottles

        # VPN
        wireguard-tools
        openconnect
        networkmanager-openconnect
      ]
    )
    ++ (
      lib.lists.optionals (osConfig.hm-pedro.de == "hyprland") [
        wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
        wtype # xdotool type for wayland
      ]
    ));
}
