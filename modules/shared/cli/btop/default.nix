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
  options.my.cli.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cli.btop.enable {
    environment.systemPackages = with pkgs; [
      btop
    ];
  };
}
