{ inputs, lib, pkgs, baseVars, config, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];
  environment.systemPackages = [ pkgs.age inputs.agenix.packages.x86_64-linux.default ];
  environment.sessionVariables.AGENIX_RULES = baseVars.flakeDir + "/secrets/secrets.nix";
  age = {
    identityPaths = [ "/etc/age/pq" ];
    secrets = builtins.readDir (inputs.self + "/secrets")
      |> lib.filterAttrs (filename: type: (lib.hasSuffix ".age" filename) && (type == "regular"))
      |> lib.mapAttrs' (filename: _: {
        name = lib.removeSuffix ".age" filename;
        value = {
          file = baseVars.flakeDir + "/secrets/" + filename;
          mode = "0444";
        };
      });
  };

  environment.sessionVariables.TEST_SECRET = config.age.secrets.test-secret.path;
}
