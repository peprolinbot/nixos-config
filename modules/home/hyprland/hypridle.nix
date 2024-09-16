{
  pkgs,
  host,
  ...
}: {
  services.hypridle.enable = true;
  xdg.configFile."hypr/hypridle.conf".text =
    ''
      general {
        lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
        before_sleep_cmd = loginctl lock-session    # lock before suspend.
        after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
      }

      listener {
        timeout = 300                               # 5min
        on-timeout = loginctl lock-session          # lock screen when timeout has passed
      }
    ''
    + (
      if (host == "frues-pc")
      then ''
        listener {
          timeout = 150                               # 2.5min.
          on-timeout = ckb-next --profile "Off"       # turn off keyboard backlight.
          on-resume = ckb-next --profile "Personal"   # turn on keyboard backlight.
        }
      ''
      else null
    )
    + ''
      listener {
        timeout = 330                               # 5.5min
        on-timeout = hyprctl dispatch dpms off    # screen off when timeout has passed
        on-resume = hyprctl dispatch dpms on       # screen on when activity is detected after timeout has fired.
      }
    '';
}
