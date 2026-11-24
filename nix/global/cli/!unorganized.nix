{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    fd
    zoxide
    fzf
    croc
    micro
  ];

  environment.sessionVariables.EDITOR = "micro";
}
