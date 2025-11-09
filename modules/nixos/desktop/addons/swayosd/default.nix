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
  options.my.desktop.swayosd.syshud = {
    enable = mkEnableOption "Sway OSD";
  };

  config = mkIf desktop.addons.swayosd.enable {
    environment.systemPackages = with pkgs; [
      swayosd
    ];
  };
}
