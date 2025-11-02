{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.app-runner.walker = {
    enable = mkEnableOption "Walker app runner";
  };

  config = mkIf desktop.addons.app-runner.walker.enable {
    environment.systemPackages = with pkgs; [
      walker
    ];
  };
}
