{ lib, ... }:

{
  hm.dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
