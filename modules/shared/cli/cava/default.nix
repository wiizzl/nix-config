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
  options.my.cli.cava = {
    enable = mkEnableOption "cava";
  };

  config = mkIf cli.cava.enable {
    environment.systemPackages = with pkgs; [
      cava
    ];
  };
}
