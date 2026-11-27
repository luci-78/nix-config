{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (nur.repos.Ev357.helium.override { enableWideVine = true; })
    zed-editor
    obs-studio
    (godsvg.override { enableWayland = true; })
  ];
}
