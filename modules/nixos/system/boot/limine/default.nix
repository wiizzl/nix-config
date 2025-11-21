{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.boot.limine = {
    enable = mkEnableOption "limine as the bootloader";
  };

  config = mkIf system.boot.limine.enable {
    boot.loader.limine = {
      enable = true;
      efiSupport = true;
    };
  };
}
