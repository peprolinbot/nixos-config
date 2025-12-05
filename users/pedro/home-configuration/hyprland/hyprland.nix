{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    systemd.enable = false;

    plugins = [
      pkgs.hyprlandPlugins.hyprgrass
    ];

    settings =
      let
        app_menu = "${pkgs.fuzzel}/bin/fuzzel";
      in
      {
        # Autostart
        exec-once = [
          "uwsm app -- nm-applet"
          "uwsm app -- ${pkgs.wl-clip-persist}/bin/persist --clipboard regular"
          "uwsm app -- bash -c 'if [ ! -f ~/.config/hypr/wallpaper.png ]; then wall-change ~/.config/hypr/default_wallpaper.png; fi'"
          "uwsm app -- ${pkgs.swaybg}/bin/swaybg -m fill -i ~/.config/hypr/wallpaper.png &"
          "uwsm app -- ${pkgs.poweralertd}/bin/poweralertd"
          "uwsm app -- waybar"
          "uwsm app -- element-desktop --hidden"
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
          force_split = 0;
          special_scale_factor = 1.0;
          split_width_multiplier = 1.0;
          use_active_for_splits = true;
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
          special_scale_factor = 1;
        };

        decoration = {
          rounding = 0;

          blur = {
            enabled = true;
            size = 1;
            passes = 1;
            brightness = 1;
            contrast = 1.400;
            ignore_opacity = true;
            noise = 0;
            new_optimizations = true;
            xray = false;
          };

          shadow = {
            enabled = true;

            ignore_window = true;
            offset = "0 2";
            range = 20;
            render_power = 3;
          };
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

        bind = [
          # show keybinds list
          "$mainMod, F1, exec, show-keybinds"

          # keybindings
          "$mainMod, Return, exec, uwsm app -- kitty"
          "ALT, Return, exec, uwsm app -- kitty --title float_kitty"
          "$mainMod SHIFT, Return, exec, uwsm app -- kitty --start-as=fullscreen -o 'font_size=16'"
          "$mainMod, B, exec, uwsm app -- librewolf"
          "$mainMod, N, exec, uwsm app -- makoctl mode -t do-not-disturb"
          "$mainMod SHIFT, N, exec, uwsm app -- swaync-client -d"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, F, fullscreen, 1"
          "$mainMod, Space, togglefloating,"
          "$mainMod, D, exec, uwsm app -- ${app_menu}"
          "$mainMod SHIFT, E, exec, uwsm app -- ${pkgs.bemoji}/bin/bemoji -n"
          "$mainMod, M, exec, uwsm app -- element-desktop"
          "$mainMod, Y, exec, uwsm app -- kitty spotify_player"
          "$mainMod, X, exec, uwsm app -- rofi-rbw"
          "$mainMod, Escape, exec, uwsm app -- loginctl lock-session"
          "$mainMod SHIFT, Escape, exec, uwsm app -- shutdown-script"
          "$mainMod, P, pseudo,"
          "$mainMod SHIFT, P, togglesplit,"
          "$mainMod, E, exec, uwsm app -- nemo"
          "$mainMod SHIFT, B, exec, uwsm app -- pkill -SIGUSR1 .waybar-wrapped"
          "$mainMod, C ,exec, uwsm app -- ${pkgs.hyprpicker}/bin/hyprpicker -a"
          "$mainMod, W,exec, uwsm app -- wallpaper-picker"

          # screenshot
          "$mainMod, Print, exec, uwsm app -- screenshot-menu"
          ",Print, exec, uwsm app -- ${pkgs.grimblast}/bin/grimblast --notify --freeze copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            ) 10
          )
        )
        ++ [
          "$mainMod CTRL, c, workspace, emptym"
          "$mainMod SHIFT, c, movetoworkspace, emptym"

          "$mainMod, S, togglespecialworkspace,"
          "$mainMod SHIFT, S, movetoworkspacesilent, special"
        ]
        ++ (
          # Window focus, movement and control
          builtins.concatLists (
            let
              keys = [
                "H"
                "L"
                "K"
                "J"
              ];
              directions = [
                "l"
                "r"
                "u"
                "d"
              ];
              resize = toString 80; # Change this to change how much a window resizes each keypress
              resize_list = [
                "-${resize} 0"
                "${resize} 0"
                "0 -${resize}"
                "0 ${resize}"
              ];
            in
            builtins.genList (
              x:
              let
                k = builtins.elemAt keys x;
                d = builtins.elemAt directions x;
                r = builtins.elemAt resize_list x;
              in
              [
                "$mainMod, ${k}, movefocus, ${d}"
                "$mainMod SHIFT, ${k}, movewindow, ${d}"
                "$mainMod CTRL, ${k}, resizeactive, ${r}"
                "$mainMod ALT, ${k}, moveactive, ${r}"
              ]
            ) 4
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
          "$mainMod, V, exec, cliphist list | fuzzel --dmenu --prompt '📋 ' | cliphist decode | wl-copy"
        ];

        # Bindings that work when locked
        bindl = [
          # media and volume controls
          ",XF86AudioRaiseVolume,exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && wp-vol"
          ",XF86AudioLowerVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wp-vol"
          ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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

        gesture = [
          "3, horizontal, workspace"
        ];

        # windowrule
        windowrule = [
          "float,class:vimiv"
          "center,class:vimiv"
          "float,class:mpv"
          "center,class:mpv"
          "size 1200 725,class:mpv"
          "float,title:^(float_kitty)$"
          "center,title:^(float_kitty)$"
          "size 950 600,title:^(float_kitty)$"
          "tile, class:neovide"
          "idleinhibit focus,class:mpv"
          "float,class:udiskie"
          "float,title:^(Volume Control)$"
          "float,title:^(Firefox — Sharing Indicator)$"
          "move 0 0,title:^(Firefox — Sharing Indicator)$"
          "size 700 450,title:^(Volume Control)$"
          "move 40 55%,title:^(Volume Control)$"
          "float, title:^(Picture-in-Picture)$"
          "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
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

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        plugin = {
          touch_gestures = {
            # The default sensitivity is probably too low on tablet screens,
            # I recommend turning it up to 4.0
            sensitivity = 5.0;

            # must be >= 3
            workspace_swipe_fingers = 3;

            # switching workspaces by swiping from an edge, this is separate from workspace_swipe_fingers
            # and can be used at the same time
            # possible values: l, r, u, or d
            # to disable it set it to anything else
            workspace_swipe_edge = "no";

            # in milliseconds
            long_press_delay = 400;

            # resize windows by long-pressing on window borders and gaps.
            # If general:resize_on_border is enabled, general:extend_border_grab_area is used for floating
            # windows
            resize_on_border_long_press = true;

            # in pixels, the distance from the edge that is considered an edge
            edge_margin = 20;

            # emulates touchpad swipes when swiping in a direction that does not trigger workspace swipe.
            # ONLY triggers when finger count is equal to workspace_swipe_fingers
            #
            # might be removed in the future in favor of event hooks
            emulate_touchpad_swipe = false;

            hyprgrass-bind = [
              # swipe left from right edge
              ", edge:r:l, exec, playerctl next"

              # swipe right from left edge
              ", edge:l:r, exec, playerctl previous"

              # swipe up from bottom edge
              ", edge:d:u, exec, pkill -SIGUSR2 wvkbd" # Show wvkbd

              # swipe down to bottom edge
              ", edge:u:d, exec, pkill -SIGUSR1 wvkbd" # Hide wvkbd

              # tap with 3 fingers
              ", tap:4, exec, pkill -SIGRTMIN wvkbd" # Toggles wvkbd

              # swipe up from left edge
              ", edge:l:u, exec, pamixer -i 4"

              # swipe down from left edge
              ", edge:l:d, exec, pamixer -d 4"

              # swipe up with 3 fingers
              ", swipe:3:u, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"

              # swipe down with 3 fingers
              ", swipe:3:d, killactive"

              # swipe diagonally left and down with 3 fingers
              ", swipe:3:ld, exec, uwsm app -- librewolf"

              # swipe diagonally right and down with 3 fingers
              ", swipe:3:rd, exec, uwsm app -- xournalpp"

              # tap with 3 fingers
              ", tap:3, exec, playerctl play-pause"
            ];

            # longpress can trigger mouse binds:
            hyprgrass-bindm = [
              ", longpress:2, movewindow"
              ", longpress:3, resizewindow"
            ];
          };
        };
      };
  };
}
