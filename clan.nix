{
  meta.name = "frues-clan";

  inventory.machines = {
    aresix = {
      tags = ["server" "headless" "spain"];
    };
    frues-pc = {
      tags = ["desktop" "spain" "gaming"];
    };
    frues-port = {
      tags = ["desktop" "spain"];
    };
    frues-surface3 = {
      tags = ["desktop" "spain"];
    };
    terrier = {
      tags = ["server" "headless" "raspberry"];
    };
    beagle = {
      tags = ["server" "headless" "vm"];
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

    base-all = {
      module.name = "importer";
      roles.default.tags.all = {};
      roles.default.extraModules = ["modules/base.nix"];
    };

    vm-base = {
      module.name = "importer";
      roles.default.tags.vm = {};
      roles.default.extraModules = ["modules/vm.nix"];
    };

    podman = {
      module.name = "importer";
      roles.default.tags.desktop = {};
      roles.default.extraModules = ["modules/podman.nix"];
    };

    virtualisation = {
      module.name = "importer";
      roles.default.tags.desktop = {};
      roles.default.extraModules = ["modules/virtualisation.nix"];
    };

    spain-located = {
      module.name = "importer";
      roles.default.tags.all = {};
      roles.default.extraModules = ["modules/spain.nix"];
    };

    desktop-base = {
      module.name = "importer";
      roles.default.tags.desktop = {};
      roles.default.extraModules = ["modules/desktop/base"];
    };

    desktop-gaming = {
      module.name = "importer";
      roles.default.tags.gaming = {};
      roles.default.extraModules = ["modules/desktop/gaming.nix"];
    };

    # Docs: https://docs.clan.lol/reference/clanServices/mycelium/
    mycelium = {
      roles.peer.tags.server = {};
    };

    # Fallback: Secure connections via Tor
    tor = {
      roles.server.tags.server = {};
    };
  };
}
