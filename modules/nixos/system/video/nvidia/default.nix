{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.video.nvidia = {
    enable = mkEnableOption "NVIDIA graphics support";
  };

  config = mkIf system.video.nvidia.enable {
    # TODO: Add NVIDIA graphics configuration here
  };
}
