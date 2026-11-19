{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    zoxide
    fzf
    croc
    micro
    btop
  ];

  environment.sessionVariables.EDITOR = "micro";
}
