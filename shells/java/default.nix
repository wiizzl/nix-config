{ pkgs, ... }:

{
  java = pkgs.mkShell {
    packages = with pkgs; [
      jdk21
    ];

    shellHook = ''
      echo "JavaScript dev shell is ready !"
    '';
  };
}
