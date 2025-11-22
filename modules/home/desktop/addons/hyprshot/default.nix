{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.hyprshot = {
    enable = mkEnableOption "hyprshot";
  };

  config = mkIf desktop.addons.hyprshot.enable {
    home-manager.users.${user.name} = {
      programs.hyprshot = {
        enable = true;
        saveLocation = "$HOME/Pictures/Screenshots";
      };
    };
  };
}
