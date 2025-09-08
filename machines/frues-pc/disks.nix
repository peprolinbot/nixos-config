{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/120da0bc-6419-42f0-b47f-11aa2e1a7058";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."sda6_crypt".device = "/dev/disk/by-uuid/5fd8e7a0-88be-4779-a52b-01b8888219a6";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7cf15f3c-bf94-470e-96a4-ef537ea934cd";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."sdb2_crypt".device = "/dev/disk/by-uuid/0deeb53b-3885-4a4f-be6d-28a48b6af052";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9b01cae4-e5cd-4059-bf31-af746216fbef";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/A606-4C72";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/98cf8cbb-8d39-45af-8143-326d24b65960";}
  ];
}
