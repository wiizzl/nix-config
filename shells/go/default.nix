{ pkgs, ... }:

{
  go = pkgs.mkShell {
    packages = with pkgs; [
      go
    ];

    shellHook = ''
      echo "Go dev shell is ready !"
    '';
  };
}
