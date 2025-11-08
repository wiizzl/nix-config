{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (config.my) system;
in
{
  options.my.system.boot = {
    enable = mkEnableOption "Boot configuration";
    kernel = mkOption {
      # https://nixos.wiki/wiki/Linux_kernel
      default = pkgs.linuxPackages_rt_latest;
      description = "Kernel package to use for the system boot";
    };
  };

  config = mkIf system.boot.enable {
    boot = {
      kernelPackages = system.boot.kernel;
      tmp.cleanOnBoot = true;
    };
  };
}
