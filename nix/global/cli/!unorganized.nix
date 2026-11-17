{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zoxide
    fzf
    croc
    micro
    btop
  ];
}
