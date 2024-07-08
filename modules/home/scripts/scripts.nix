{pkgs, ...}: let
  ddcmonitorctl = pkgs.writeShellScriptBin "ddcmonitorctl" (builtins.readFile ./scripts/ddcmonitorctl.sh);

  setbg-apotd = pkgs.writeShellScriptBin "setbg-apotd" (builtins.readFile ./scripts/setbg-apotd.sh);
  setbg-bpotd = pkgs.writeShellScriptBin "setbg-bpotd" (builtins.readFile ./scripts/setbg-bpotd.sh);
  wall-change = pkgs.writeShellScriptBin "wall-change" (builtins.readFile ./scripts/wall-change.sh);
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" (builtins.readFile ./scripts/wallpaper-picker.sh);

  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);

  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (builtins.readFile ./scripts/toggle_oppacity.sh);

  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);

  shutdown-script = pkgs.writeScriptBin "shutdown-script" (builtins.readFile ./scripts/shutdown-script.sh);

  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);

  screenshot-menu = pkgs.writeScriptBin "screenshot-menu" (builtins.readFile ./scripts/screenshot-menu.sh);
in {
  home.packages = with pkgs; [
    ddcmonitorctl

    setbg-apotd
    setbg-bpotd
    wall-change
    wallpaper-picker

    runbg

    toggle_blur
    toggle_oppacity

    compress
    extract

    shutdown-script

    show-keybinds

    screenshot-menu
  ];
}
