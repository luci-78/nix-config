{ lib }:

let
  expandIfFolder = elem:
    if !builtins.isPath elem || builtins.readFileType elem != "directory"
      then [ elem ]
    else lib.filesystem.listFilesRecursive elem;
in
  list:
    # expand folders to all their contents
    builtins.concatMap expandIfFolder list
    # filter out non-nix files
    |> builtins.filter (e: !builtins.isPath e || lib.hasSuffix ".nix" (toString e))
