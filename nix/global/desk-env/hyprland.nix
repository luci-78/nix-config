{ baseVars, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  hm = { config, ... }: {
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink (baseVars.flakeDir + "/hypr");
  };
}
