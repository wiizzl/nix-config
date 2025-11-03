{
  lib,
  pkgs,
  android-nixpkgs,
  ...
}:

let
  getDir =
    dir:
    lib.mapAttrs (file: type: if type == "directory" then getDir "${dir}/${file}" else type) (
      builtins.readDir dir
    );

  files =
    dir:
    lib.collect lib.isString (
      lib.mapAttrsRecursive (path: type: lib.concatStringsSep "/" path) (getDir dir)
    );

  defaultNixFiles = builtins.filter (file: builtins.baseNameOf file == "default.nix") (files ./.);
  importedShells = builtins.map (
    file: import ./${file} { inherit pkgs android-nixpkgs lib; }
  ) defaultNixFiles;
in
lib.foldl' lib.recursiveUpdate { } importedShells
