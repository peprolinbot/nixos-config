{
  lib,
  config,
  ...
}: {
  stylix.targets.waybar.addCss = false;

  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        min-height: 0;
    }


    window#waybar {
        background: none;
    }

    .module {
        background: @base00;
        color: @base05;
        margin: 5px 0px;
        min-height: 0;
        font-weight: bold;
    }

    tooltip {
        background: @base02;
        color: @base05;
        border-radius: 4px;
    }

    tooltip label {
        color: @base05;
    }

    #workspaces {
        margin: 5px 5px;
        padding: 8px 12px;
        border-radius: 12px 12px 24px 24px;
    }

    #workspaces button {
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 15px;
        color: @base00;
        background-color: @base0D;
        min-width: 15px;
        transition: all 0.2s ease-in-out;
    }

    #workspaces button.visible {
        background-color: @base0F;
    }

    #workspaces button.active {
        background-color: @base0E;
        min-width: 35px;
    }

    #workspaces button:hover {
        background-color: @base07;
        min-width: 35px;
    }

    #cpu {
        border-radius: 10px 0px 0px 24px;
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #memory {
        border-radius: 0;
        padding-left: 9px;
        padding-right: 9px;
    }
    #disk {
        border-radius: 0px 24px 10px 0px;
        padding-left: 9px;
        padding-right: 15px;
    }

    #tray {
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
    }

    #pulseaudio {
        border-radius: 10px 0px 0px 24px;
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }

    #battery {
        border-radius: 0;
        padding-left: 9px;
        padding-right: 9px;
    }

    #idle_inhibitor {
        border-radius: 0;
        padding-left: 9px;
        padding-right: 9px;
    }

    #network {
        border-radius: 0px 24px 10px 0px;
        padding-left: 9px;
        padding-right: 15px;
    }

    #clock {
        border-radius: 0px 0px 0px 40px;
        padding: 10px 10px 15px 25px;
        margin: 0px;
        margin-left: 7px;
        font-size: 16px;
    }

    #custom-launcher {
        color: @base0D;
        border-radius: 0px 0px 40px 0px;
        margin: 0px;
        padding: 0px 30px 0px 10px;
        font-size: 28px;
    }

    #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.forward {
        font-size: 22px;
    }
    #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.forward:hover{
        color: @base05;
    }
    #custom-playerctl.backward {
        color: @base0E;
        border-radius: 24px 0px 0px 10px;
        padding-left: 16px;
        margin-left: 7px;
    }
    #custom-playerctl.play {
        color: @base0D;
        padding: 0 5px;
    }
    #custom-playerctl.forward {
        color: @base0E;
        border-radius: 0px 10px 24px 0px;
        padding-right: 12px;
        margin-right: 7px
    }
  '';
}
