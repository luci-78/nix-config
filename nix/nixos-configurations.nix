{ inputs }:

let
  lib = inputs.nixpkgs.lib;

  recursiveNixFiles = list:
    builtins.concatMap
      (e: if (builtins.readFileType e) == "directory"
        then lib.filesystem.listFilesRecursive e
        else [ e ])
      list
    |> builtins.filter (e: (toString e) |> lib.hasSuffix ".nix");

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
    modules = recursiveNixFiles (globalModules ++ [ ./hosts/laptop ]);
  };
}
