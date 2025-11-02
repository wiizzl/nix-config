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
      # https://nixos.wiki/wiki/Linux_kernel
      default = pkgs.linuxPackages_rt_latest;
      description = "Kernel package to use for the system boot";
    };
  };

  config = {
    boot = {
      kernelPackages = system.boot.kernel;
      tmp.cleanOnBoot = true;
    };
  };
}
