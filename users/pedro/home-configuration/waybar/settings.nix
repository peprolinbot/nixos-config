{host, ...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    # height= 15;
    margin-top = 0;
    margin-bottom = 5;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "custom/playerctl#backward"
      "custom/playerctl#play"
      "custom/playerctl#forward"
    ];
    modules-center = [
      "hyprland/workspaces"
    ];
    modules-right = [
      "tray"
      "cpu"
      "memory"
      "disk"
      "pulseaudio"
      "battery"
      "idle_inhibitor"
      "network"
      "clock"
    ];

    clock = {
      format = " {:%H:%M}";
      tooltip = true;
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
    };

    "hyprland/workspaces" = {
      active-only = false;
      all-outputs = false;
      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{name}";
      on-click = "activate";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
        sort-by-number = true;
      };
    };

    "custom/playerctl#backward" = {
      format = "󰙣 ";
      on-click = "playerctl previous";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
      tooltip = false;
    };

    "custom/playerctl#play" = {
      format = "{icon}";
      return-type = "json";
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click = "playerctl play-pause";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
      format-icons = {
        Playing = "<span>󰏥 </span>";
        Paused = "<span> </span>";
        Stopped = "<span> </span>";
      };
    };

    "custom/playerctl#forward" = {
      format = "󰙡 ";
      on-click = "playerctl next";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
      tooltip = false;
    };

    memory = {
      format = "  {}%";
      format-alt = "  {used} GiB"; # 
      interval = 2;
    };

    cpu = {
      format = "  {usage}%";
      format-alt = "  {avg_frequency} GHz";
      interval = 2;
    };

    disk = {
      # path = "/";
      format = "󰋊 {percentage_used}%";
      interval = 60;
    };

    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰀂 ";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 ";
    };

    tray = {
      icon-size = 20;
      spacing = 8;
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = " ";
      format-icons = {
        default = [" "];
      };
      scroll-step = 5;
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };

    battery = {
      format = "{icon} {capacity}%";
      format-icons = [" " " " " " " " " "];
      format-charging = " {capacity}%";
      format-full = " {capacity}%";
      format-warning = " {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = " ";
        deactivated = " ";
      };
      timeout = 30;
    };

    "custom/launcher" = {
      format = "";
      on-click = "pkill fuzzel || fuzzel";
      on-click-right = "pkill fuzzel || wallpaper-picker";
      tooltip = false;
    };
  };
}
