{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.boot.grub = {
    enable = mkEnableOption "grub as the bootloader";
  };

  config = mkIf system.boot.grub.enable {
    boot.loader.grub = {
      enable = true;
      useOSProber = true; # NOTE: this only work with Windows, if you want other OS, go for systemd-boot
      efiSupport = true;
      device = "nodev";
      configurationLimit = 8;
    };
  };
}
