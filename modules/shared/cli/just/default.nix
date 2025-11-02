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
  options.my.cli.just = {
    enable = mkEnableOption "just";
  };

  config = mkIf cli.just.enable {
    environment.systemPackages = with pkgs; [
      just
    ];
  };
}
