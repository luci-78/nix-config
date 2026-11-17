{ ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel = {
      npu.enable = true;
      updateMicrocode = true;
    };
  };

  services.fwupd.enable = true;
}
