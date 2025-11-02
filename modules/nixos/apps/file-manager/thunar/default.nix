{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps;
in
{
  options.my.apps.file-manager.thunar = {
    enable = mkEnableOption "Thunar file manager";
  };

  config = mkIf apps.file-manager.thunar.enable {
    environment.systemPackages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler
    ];
  };
}
