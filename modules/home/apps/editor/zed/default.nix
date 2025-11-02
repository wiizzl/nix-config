{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) apps desktop user;
in
{
  config = mkIf apps.editor.zed.enable {
    home-manager.users.${user.name} = {
      stylix = mkIf desktop.addons.stylix.enable {
        targets.zed.enable = false;
      };

      programs.zed-editor = {
        enable = true;

        extensions = [ ];
        userSettings = { };
      };
    };
  };
}
