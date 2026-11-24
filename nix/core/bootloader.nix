{ pkgs, lib, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        memtest86.enable = true;
        # TODO: fix text being very small
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
