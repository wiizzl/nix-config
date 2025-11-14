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
  options.my.cli.impala = {
    enable = mkEnableOption "Impala wifi manager TUI";
  };

  config = mkIf cli.impala.enable {
    environment.systemPackages = with pkgs; [
      impala
    ];
  };
}
