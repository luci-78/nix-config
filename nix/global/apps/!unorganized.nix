{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nur.repos.Ev357.helium
    zed-editor
  ];
}
