{ pkgs, baseVars, hostVars, ... }:

{
  users.users.${baseVars.username}.shell = pkgs.fish;
  programs.fish.enable = true;
  hm.home.shell.enableFishIntegration = true;
  hm.programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      zoxide init fish --cmd cd | source
      fzf --fish | source
    '';
    shellAliases = {
      rebuild-switch = "sudo nixos-rebuild switch --flake path:${baseVars.flakeDir}#${hostVars.hostname}";
      rebuild-boot = "sudo nixos-rebuild switch --flake path:${baseVars.flakeDir}#${hostVars.hostname}";
    };
    plugins = with pkgs.fishPlugins; [
      { name = "autopair"; src = autopair.src; }
      { name = "bobthefish"; src = bobthefish.src; }
    ];
  };
}
