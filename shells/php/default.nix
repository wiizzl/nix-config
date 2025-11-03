{ pkgs, ... }:

{
  php = pkgs.mkShell {
    packages = with pkgs; [
      php82
      php82Packages.composer
      symfony-cli
    ];

    shellHook = ''
      echo "PHP dev shell is ready !"
    '';
  };
}
