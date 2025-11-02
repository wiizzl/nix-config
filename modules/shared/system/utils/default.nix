{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    types
    optionals
    ;
  inherit (config.my) system;
in
{
  options.my.system.utils = {
    enable = mkEnableOption "utils packages";
    dev = mkEnableOption "dev utils packages";
    fun = mkEnableOption "fun utils packages";
  };

  config = mkIf system.utils.enable {
    environment.systemPackages =
      with pkgs;
      [
        curl
        wget
        eza
        bat
        tldr
        unzip
        unrar
      ]
      ++ optionals system.utils.dev [
        fzf
        ripgrep
        jq
        nixfmt-rfc-style
      ]
      ++ optionals system.utils.fun [
        peaclock
        cbonsai
        pipes
        cmatrix
        nitch
      ];
  };
}
