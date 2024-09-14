{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      # autostart
      exec-once = [
        "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &"
        "nm-applet &"
        "wl-clip-persist --clipboard both &"
        "bash -c 'if [ ! -f ~/.config/hypr/wallpaper.png ]; then wall-change ~/.config/hypr/default_wallpaper.png; fi'"
        "swaybg -m fill -i ~/.config/hypr/wallpaper.png &"
        "poweralertd &"
        "waybar &"
        "swaync &"
        "wl-paste --type text --watch cliphist store &" #Stores only text data
        "wl-paste --type image --watch cliphist store &" #Stores only image data
        "ckb-next -b &"
        "element-desktop --hidden &"
      ];

      input = {
        kb_layout = "es,us";
        kb_options = "grp:alt_caps_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgb(cba6f7) rgb(94e2d5) 45deg";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = false;
        no_border_on_floating = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
      };

      dwindle = {
        no_gaps_when_only = true;
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
        special_scale_factor = 1;
        no_gaps_when_only = false;
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 1;
          passes = 1;
          # size = 4;
          # passes = 2;
          brightness = 1;
          contrast = 1.400;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = false;
        };

        drop_shadow = true;

        shadow_ignore_window = true;
        shadow_offset = "0 2";
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      bind =
        [
          # show keybinds list
          "$mainMod, F1, exec, show-keybinds"

          # keybindings
          "$mainMod, Return, exec, kitty"
          "ALT, Return, exec, kitty --title float_kitty"
          "$mainMod SHIFT, Return, exec, kitty --start-as=fullscreen -o 'font_size=16'"
          "$mainMod, B, exec, floorp"
          "$mainMod, N, exec, swaync-client -t"
          "$mainMod SHIFT, N, exec, swaync-client -d"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, F, fullscreen, 1"
          "$mainMod, Space, togglefloating,"
          "$mainMod, D, exec, fuzzel"
          "$mainMod SHIFT, E, exec, bemoji -t"
          "$mainMod, M, exec, element-desktop"
          "$mainMod, Escape, exec, loginctl lock-session"
          "$mainMod SHIFT, Escape, exec, shutdown-script"
          "$mainMod, P, pseudo,"
          "$mainMod SHIFT, P, togglesplit,"
          "$mainMod, E, exec, nemo"
          "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
          "$mainMod, C ,exec, hyprpicker -a"
          "$mainMod, W,exec, wallpaper-picker"

          # screenshot
          "$mainMod, Print, exec, screenshot-menu"
          ",Print, exec, grimblast --notify --cursor --freeze copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            )
            10
          )
        )
        ++ [
          "$mainMod CTRL, c, workspace, empty"
          "$mainMod SHIFT, c, movetoworkspace, empty"
        ]
        ++ (
          # Window focus, movement and control
          builtins.concatLists (
            let
              keys = ["H" "L" "K" "J"];
              directions = ["l" "r" "u" "d"];
              resize = toString 80; # Change this to change how much a window resizes each keypress
              resize_list = ["-${resize} 0" "${resize} 0" "0 -${resize}" "0 ${resize}"];
            in
              builtins.genList (
                x: let
                  k = builtins.elemAt keys x;
                  d = builtins.elemAt directions x;
                  r = builtins.elemAt resize_list x;
                in [
                  "$mainMod, ${k}, movefocus, ${d}"
                  "$mainMod SHIFT, ${k}, movewindow, ${d}"
                  "$mainMod CTRL, ${k}, resizeactive, ${r}"
                  "$mainMod ALT, ${k}, moveactive, ${r}"
                ]
              )
              4
          )
        )
        ++ [
          "$mainMod, mouse_down, workspace, e-1"
          "$mainMod, mouse_up, workspace, e+1"

          # laptop brigthness
          ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
          "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"

          # clipboard manager
          "$mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        ];

      # Bindings that work when locked
      bindl = [
        # media and volume controls
        ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        ",XF86AudioLowerVolume,exec, pamixer -d 2"
        ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # windowrule
      windowrule = [
        "float,imv"
        "center,imv"
        "size 1200 725,imv"
        "float,mpv"
        "center,mpv"
        "tile,Aseprite"
        "size 1200 725,mpv"
        "float,title:^(float_kitty)$"
        "center,title:^(float_kitty)$"
        "size 950 600,title:^(float_kitty)$"
        # "pin,wofi"
        # "float,wofi"
        # "noborder,wofi"
        "tile, neovide"
        "idleinhibit focus,mpv"
        "float,udiskie"
        "float,title:^(Volume Control)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"
      ];

      # windowrulev2
      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,class:^(zenity)$"
        "center,class:^(zenity)$"
        "size 850 500,class:^(zenity)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(.sameboy-wrapped)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"

        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];

      monitor = [
        ",preferred,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
