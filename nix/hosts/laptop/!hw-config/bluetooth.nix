{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  environment.systemPackages = with pkgs; [ bluetui ];

  # switching to tty by default
  services.pipewire.wireplumber.extraConfig."51-tty-maintain-bluetooth-connection"
    ."wireplumber.profiles".main."monitor.bluez.seat-monitoring" = "disabled";
}
