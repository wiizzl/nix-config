{ pkgs, ... }:

{
  py = pkgs.mkShell {
    packages = with pkgs; [
      python313
      python313Packages.uv
      python313Packages.pip
    ];

    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.libz
    ];

    shellHook = ''
      echo "Python dev shell is ready !"
    '';
  };
}
