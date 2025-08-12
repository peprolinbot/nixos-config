{
  meta.name = "frues-clan";

  inventory.machines = {
    aresix = {
      deploy.targetHost = "root@[4a6:fed0:59ba:507d:baab:15f3:846d:ead4]";
    };
  };

  # Docs: See https://docs.clan.lol/reference/clanServices
  inventory.instances = {
    admin = {
      roles.default.tags.all = {};
      roles.default.settings.allowedKeys = {
        "pedro" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJji4h4bgzgmp7YoRX/8ePN0TcCYRfI2wlrEeZkBQ/y2 personal@peprolinbot.com";
      };
    };

    pedro-user = {
      module.name = "users";

      roles.default.tags.all = {};

      roles.default.settings = {
        user = "pedro";
        groups = [
          "wheel"
          "networkmanager"
          "video"
          "input"
          "libvirtd"
          "adbusers"
          "dialout"
        ];
      };

      roles.default.extraModules = [./users/pedro/home.nix];
    };

    # Docs: https://docs.clan.lol/reference/clanServices/mycelium/
    mycelium = {
      roles.peer.tags.all = {};
    };
  };
}
