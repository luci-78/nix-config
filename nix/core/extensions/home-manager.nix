{ lib, inputs, baseVars, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" baseVars.username ])
  ];

  home-manager.useGlobalPkgs = true;
  hm.home.stateVersion = baseVars.stateVersion;
}
