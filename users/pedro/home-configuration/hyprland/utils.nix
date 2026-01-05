{ pkgs, config, ... }:
{
  services.hyprpolkitagent.enable = true;

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        use-bold = true;
        line-height = 25;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "kitty";
        prompt = "'🔍 '";
        layer = "top";
        lines = 10;
        width = 35;
        horizontal-pad = 25;
        inner-pad = 5;
        dpi-aware = false;
      };
      border = {
        radius = 15;
        width = 3;
      };
    };
  };

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      theme.iconTheme = "Default"; # Normal app icons in launcher
    };
  };

  home.packages = [
    (pkgs.writeShellApplication {
      # From https://github.com/emersion/mako/wiki/Volume-change-notification#1-create-the-notifier-script
      name = "wp-vol";
      runtimeInputs = with pkgs; [
        wireplumber
        gawk
        bc
      ];
      text = ''
        # Get the volume level and convert it to a percentage
        volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
        volume=$(echo "$volume" | awk '{print $2}')
        volume=$(echo "( $volume * 100 ) / 1" | bc)

        notify-send -t 1000 -a 'wp-vol' -h "int:value:$volume" "Volume: ''${volume}%"
      '';
    })
  ];
}
