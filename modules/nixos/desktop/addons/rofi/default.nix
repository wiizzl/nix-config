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
  options.my.desktop.addons.rofi = {
    enable = mkEnableOption "Rofi app launcher";
  };

  config = mkIf desktop.addons.rofi.enable {
    stylix = mkIf desktop.addons.stylix.enable {
      targets.rofi.enable = false;
    };

    environment.systemPackages = with pkgs; [
      rofi
    ];
  };
}
