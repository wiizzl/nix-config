{ lib, ... }:

let
  # Fonction pour lire les dossiers dans un répertoire donné
  getDir =
    dir:
    lib.mapAttrs (file: type: if type == "directory" then getDir "${dir}/${file}" else type) (
      builtins.readDir dir
    );

  # Fonction pour collecter les chemins des fichiers
  files =
    dir:
    lib.collect lib.isString (
      lib.mapAttrsRecursive (path: type: lib.concatStringsSep "/" path) (getDir dir)
    );

  # Fonction pour récupérer les dossiers contenant un fichier flake.nix
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
