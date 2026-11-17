{ ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7d77bb18-2aae-4d0c-bde0-c7ead2e0c08e";
      fsType = "btrfs";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/7d77bb18-2aae-4d0c-bde0-c7ead2e0c08e";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/7d77bb18-2aae-4d0c-bde0-c7ead2e0c08e";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/74BA-59F4";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/1dfa34f2-ce46-47fb-8119-315f7e16b374"; } ];
}
