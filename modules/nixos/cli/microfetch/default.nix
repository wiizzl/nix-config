{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli;
in
{
  options.my.cli.microfetch = {
    enable = mkEnableOption "Microscopic fetch tool";
  };

  config = mkIf cli.microfetch.enable {
    environment.systemPackages = with pkgs; [
      microfetch
    ];
  };
}
