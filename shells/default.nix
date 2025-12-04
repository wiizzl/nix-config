{ lib, ... }:

let
  getShells =
    dir:
    builtins.map
      (folder: {
        path = ./. + "/${folder}";
        description = "${folder} development environment";
      })
      (
        builtins.filter (folder: lib.hasFile "flake.nix" (dir + "/${folder}")) (
          builtins.attrNames (builtins.readDir dir)
        )
      );
in
{
  imports = getShells ./.;
}
