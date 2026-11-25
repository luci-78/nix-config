{ baseVars, hostVars, ... }:

{
  programs.hyprland.enable = true;

  environment.sessionVariables.HYPR_HOST = hostVars.hostname;

  hm = { config, ... }: {
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink (baseVars.flakeDir + "/hypr");
  };
}
