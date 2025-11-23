{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.editor.obsidian = {
    enable = mkEnableOption "Obsidian note-taking app";
  };

  config = mkIf apps.editor.obsidian.enable {
    home-manager.users.${user.name} = {
      programs.obsidian = {
        enable = true;

        defaultSettings = {
          # TODO: https://mynixos.com/home-manager/options/programs.obsidian.defaultSettings
          communityPlugins = [ ];
        };
      };
    };
  };
}
