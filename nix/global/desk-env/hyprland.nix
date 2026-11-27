{ baseVars, hostVars, ... }:

{
  programs.hyprland.enable = true;

  hm = { config, ... }: {
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink (baseVars.flakeDir + "/hypr");
  };
}
