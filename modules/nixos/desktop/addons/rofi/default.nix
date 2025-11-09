{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.rofi = {
    enable = mkEnableOption "Rofi app runner";
  };

  config = mkIf desktop.addons.rofi.enable {
    environment.systemPackages = with pkgs; [
      rofi
      cliphist
      rofimoji
    ];
  };
}
