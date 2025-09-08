{...}: {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;

      "mode=do-not-disturb" = {
        invisible = 1;
      };

      # From https://github.com/emersion/mako/wiki/Volume-change-notification
      "app-name=wp-vol" = {
        layer = "overlay";
        history = 0;
        anchor = "top-center";
        # Group all volume notifications together
        group-by = "app-name";
        # Hide the group-index
        format = "<b>%s</b>\\n%b";
      };
      "app-name=volume group-index=0" = {
        # Only show last notification
        invisible = 0;
      };
      "app-name=volume grouped=false" = {
        # Force initial volume notification to be visible
        invisible = 0;
      };
    };
  };
}
