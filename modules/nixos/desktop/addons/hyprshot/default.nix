{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.hyprshot = {
    enable = mkEnableOption "hyprshot";
  };

  config = mkIf desktop.addons.hyprshot.enable {
    environment.systemPackages = with pkgs; [
      hyprshot
    ];
  };
}
