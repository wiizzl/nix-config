{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.audio.pulseaudio = {
    enable = mkEnableOption "Pulseaudio audio system";
  };

  config = mkIf system.audio.pulseaudio.enable {
    services.pulseaudio = {
      enable = true;
    };
  };
}
