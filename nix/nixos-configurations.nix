{ inputs }:

let
  lib = inputs.nixpkgs.lib;
  recursivelyImport = import ./utils/recursively-import.nix { inherit lib; };

  specialArgs = {
    inherit inputs;
    baseVars = lib.fix (finalAttrs: {
      username = "luci";
      stateVersion = "26.05";
      flakeDir = "/home/" + finalAttrs.username + "/nix-config";
    });
  };
  globalModules = [ ./core ./global ];
in
{
  lapluci = lib.nixosSystem {
    specialArgs = specialArgs // {
      hostVars.hostname = "lapluci";
    };
    modules = recursivelyImport (globalModules ++ [ ./hosts/laptop ]);
  };
}
