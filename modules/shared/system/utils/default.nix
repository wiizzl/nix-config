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
        zip
        unrar
      ]
      ++ optionals system.utils.dev [
        fzf
        ripgrep
        jq
        nixfmt-rfc-style
        nil
        nixd
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
