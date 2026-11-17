{ pkgs, ... }:

{
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    swaybg
    hyprlauncher
    hyprshot
    # brightness/media in binds.lua
    brightnessctl
    playerctl
  ];
}
