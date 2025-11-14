{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.editor.android-studio = {
    enable = mkEnableOption "Android Studio IDE";
  };

  config = mkIf apps.editor.android-studio.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        android-studio
      ];
    };
  };
}
