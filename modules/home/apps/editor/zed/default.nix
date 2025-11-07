{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) apps desktop user;
in
{
  config = mkIf apps.editor.zed.enable {
    home-manager.users.${user.name} =
      { config, ... }:
      mkIf desktop.addons.stylix.enable {
        stylix.targets.zed.enable = false;
      }
      // {
        xdg.configFile."zed" = {
          source = config.lib.file.mkOutOfStoreSymlink "${user.homeDir}/nix-config/modules/home/apps/editor/zed/config/";
          recursive = true;
        };

        programs.zed-editor = {
          enable = true;

          extraPackages = with pkgs; [
            nixd
          ];
        };
      };
  };
}
