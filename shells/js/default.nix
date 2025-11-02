{ pkgs, ... }:

{
  js = pkgs.mkShell {
    packages = with pkgs; [
      nodejs
      bun
      yarn
      pnpm
      openssl
    ];

    shellHook = ''
      echo "JavaScript dev shell is ready !"
    '';
  };
}
