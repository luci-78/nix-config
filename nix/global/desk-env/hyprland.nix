{ baseVars, hostVars, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.HYPR_HOST = hostVars.hostname;

  hm = { config, ... }: {
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink (baseVars.flakeDir + "/hypr");

    programs.fish.interactiveShellInit = ''
      if uwsm check may-start
        exec uwsm start hyprland.desktop
      end
    '';
  };
}
