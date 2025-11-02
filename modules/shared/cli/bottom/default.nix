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
  options.my.cli.bottom = {
    enable = mkEnableOption "bottom";
  };

  config = mkIf cli.bottom.enable {
    environment.systemPackages = with pkgs; [
      bottom
    ];
  };
}
