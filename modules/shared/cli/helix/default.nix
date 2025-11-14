{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli;
in
{
  options.my.cli.helix = {
    enable = mkEnableOption "Helix editor";
  };

  config = mkIf cli.helix.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];
  };
}
