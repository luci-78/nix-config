{ pkgs, baseVars, ... }:

{
  environment.systemPackages = [ pkgs.quickshell ];

  hm = { config, ... }: {
    xdg.configFile.quickshell.source = config.lib.file.mkOutOfStoreSymlink (baseVars.flakeDir + "/quickshell");
  };
}
