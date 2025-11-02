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
  options.my.apps.editor.zed = {
    enable = mkEnableOption "Zed editor";
  };

  config = mkIf apps.editor.zed.enable {
    environment.systemPackages = with pkgs; [
      zed-editor
    ];
  };
}
