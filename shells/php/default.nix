{ pkgs, ... }:

{
  php = pkgs.mkShell {
    packages = with pkgs; [
      php82
      php82Packages.composer
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
