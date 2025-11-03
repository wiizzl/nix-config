{ pkgs, ... }:

{
  php = pkgs.mkShell {
    packages = with pkgs; [
      php84
      php84Packages.composer
      symfony-cli
      laravel
      nodejs
      bun
    ];

    shellHook = ''
      echo "PHP dev shell is ready !"
    '';
  };
}
