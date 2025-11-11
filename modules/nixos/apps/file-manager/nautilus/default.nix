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
  options.my.apps.file-manager.nautilus = {
    enable = mkEnableOption "Nautilus file manager";
  };

  config = mkIf apps.file-manager.nautilus.enable {
    environment.systemPackages = with pkgs; [
      nautilus
    ];
  };
}
