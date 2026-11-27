{ hostVars, ... }:

{
  environment.sessionVariables = {
    HOSTNAME = hostVars.hostname;

    NIXOS_OZONE_WL="1";

    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
}
