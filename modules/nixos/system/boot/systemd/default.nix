{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.boot.systemd = {
    enable = mkEnableOption "systemd-boot as the bootloader";
  };

  config = mkIf system.boot.systemd.enable {
    boot.loader.systemd-boot = {
      enable = true;
      consoleMode = "auto";
      configurationLimit = 8;
    };
  };
}
