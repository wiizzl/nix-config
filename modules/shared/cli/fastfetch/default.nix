{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli;
in
{
  options.my.cli.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cli.fastfetch.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}
