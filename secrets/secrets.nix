let
  publicKey = builtins.readFile /etc/age/pq.pub;
  mkSecrets = files: builtins.listToAttrs(map (name: {
    name = "${name}.age";
    value.publicKeys = [ publicKey ];
  }) files);
in mkSecrets [
  "test-secret"
  "wireguard-lapluci"
  "wireguard-deskluci" # yea I don't use this yet but I WILL!
]
