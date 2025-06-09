{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = let
      colors = with config.lib.stylix.colors; {
        text = base05;
        accent = base0E;
        warning = base0A;
      };
    in {
      general = {
        hide_cursor = true;
      };

      background = {
        path = "~/.config/hypr/wallpaper.png";
        blur_passes = 2;
      };

      label = [
        # Time
        {
          text = "cmd[update:30000] echo \"<b><big> $(date +\"%R\") </big></b>\"";
          color = "rgb(${colors.text})";
          font_size = 110;
          shadow_passes = 3;
          shadow_size = 3;

          position = "0, -100";
          halign = "center";
          valign = "top";
        }

        # Date
        {
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "rgb(${colors.text})";
          font_size = 18;
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
      ];

      # User Avatar
      image = {
        path = "~/.face.png";
        size = 125;
        border_color = "rgb(${colors.accent})";

        position = "0, -450";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;
        fade_on_empty = false;
        placeholder_text = "<span foreground=\"##${colors.text}\"><i>󰌾  Logged in as </i><span foreground=\"##${colors.accent}\">$USER</span></span>";
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(${colors.warning})";
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };
}
