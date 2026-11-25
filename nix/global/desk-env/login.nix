{ pkgs, baseVars, ... }:

{
  services.getty = {
    helpLine = pkgs.lib.mkForce "";
    greetingLine = "haii haiii~!";
  };
  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = [
      "" "@${pkgs.util-linux}/sbin/agetty _ --skip-login --login-options ${baseVars.username} --noreset --nohostname - \${TERM}"
    ];
  };

  programs.uwsm.enable = true;
  hm.programs.fish.interactiveShellInit = ''
    if uwsm check may-start
      exec uwsm start hyprland.desktop
    end
  '';
}
