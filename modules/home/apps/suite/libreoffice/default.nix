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
  options.my.apps.suite.libreoffice = {
    enable = mkEnableOption "LibreOffice suite";
  };

  config = mkIf apps.suite.libreoffice.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.fr-any
        hunspellDicts.en_US
      ];
    };
  };
}
