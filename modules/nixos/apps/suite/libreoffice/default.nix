{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps;
in
{
  options.my.apps.suite.libreoffice = {
    enable = mkEnableOption "LibreOffice suite";
  };

  config = mkIf apps.suite.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.fr-any
      hunspellDicts.en_US
    ];
  };
}
