{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) apps desktop user;
in
{
  options.my.apps.editor.zed = {
    enable = mkEnableOption "Zed editor";
  };

  config = mkIf apps.editor.zed.enable {
    home-manager.users.${user.name} =
      { config, ... }:
      {
        xdg.configFile."zed/settings.json" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/apps/editor/zed/config/settings.json";
        };

        programs.zed-editor = {
          enable = true;
        };
      }
      // optionalAttrs desktop.addons.stylix.enable {
        stylix.targets.zed.enable = false;
      };
  };
}
