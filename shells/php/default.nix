{ pkgs, ... }:

{
  php = pkgs.mkShell {
    packages = with pkgs; [
      php
      symfony-cli
    ];

    shellHook = ''
      echo "JavaScript dev shell is ready !"
    '';
  };
}
