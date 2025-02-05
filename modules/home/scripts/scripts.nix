{pkgs, ...}: {
  home.packages =
    [
      (pkgs.writeShellApplication {
        name = "ddcmonitorctl";
        runtimeInputs = with pkgs; [ddcutil];
        text = builtins.readFile ./scripts/ddcmonitorctl.sh;
      })
    ]
    ++ (let
      wall-change = pkgs.writeShellApplication {
        name = "wall-change";
        runtimeInputs = with pkgs; [swaybg imagemagick];
        text = builtins.readFile ./scripts/wall-change.sh;
      };
      setbg-apotd = pkgs.writeShellApplication {
        name = "setbg-apotd";
        runtimeInputs = [pkgs.curl pkgs.gnugrep pkgs.gnused wall-change];
        text = builtins.readFile ./scripts/setbg-apotd.sh;
      };
      setbg-bpotd = pkgs.writeShellApplication {
        name = "setbg-bpotd";
        runtimeInputs = with pkgs; [pkgs.curl pkgs.jq wall-change];
        text = builtins.readFile ./scripts/setbg-bpotd.sh;
      };
      wallpaper-picker = pkgs.writeShellApplication {
        name = "wallpaper-picker";
        runtimeInputs = [pkgs.fuzzel setbg-apotd setbg-bpotd wall-change];
        text = builtins.readFile ./scripts/wallpaper-picker.sh;
      };
    in [
      wall-change
      setbg-apotd
      setbg-bpotd
      wallpaper-picker
    ])
    ++ [
      (pkgs.writeShellApplication {
        name = "runbg";
        text = builtins.readFile ./scripts/runbg.sh;
      })

      (pkgs.writeShellApplication {
        name = "toggle_blur";
        text = builtins.readFile ./scripts/toggle_blur.sh;
      })
      (pkgs.writeShellApplication {
        name = "toggle_oppacity";
        text = builtins.readFile ./scripts/toggle_oppacity.sh;
      })

      (pkgs.writeShellApplication {
        name = "shutdown-script";
        runtimeInputs = with pkgs; [fuzzel];
        text = builtins.readFile ./scripts/shutdown-script.sh;
      })

      (pkgs.writeShellApplication {
        name = "show-keybinds";
        runtimeInputs = with pkgs; [fuzzel gnugrep];
        text = builtins.readFile ./scripts/show-keybinds.sh;
      })

      (pkgs.writeShellApplication {
        name = "screenshot-menu";
        runtimeInputs = with pkgs; [fuzzel grimblast swappy];
        text = builtins.readFile ./scripts/screenshot-menu.sh;
      })
    ];
}
