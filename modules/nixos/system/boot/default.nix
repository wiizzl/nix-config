{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption;
  inherit (config.my) system;
in
{
  options.my.system.boot = {
    kernel = mkOption {
      # type = types.package;
      default = pkgs.linuxPackages_rt_latest;
      description = "Enable grub as the bootloader";
    };
  };

  config = {
    boot = {
      kernelPackages = system.boot.kernel;
      tmp.cleanOnBoot = true;
    };
  };
}
