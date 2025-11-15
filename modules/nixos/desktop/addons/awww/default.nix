{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;

  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
in
{
  options.my.desktop.addons.awww = {
    enable = mkEnableOption "awww wallpaper manager";
  };

  config = mkIf desktop.addons.awww.enable {
    environment.systemPackages = [
      awww
    ];

    systemd.services.awww-daemon = {
      description = "Automatic start of awww-daemon";

      serviceConfig = {
        Type = "forking";
        ExecStart = "${awww}/bin/awww-daemon";
        ExecStop = "pkill awww-daemon";
        Restart = "on-failure";
      };
    };
  };
}
