{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) services system;
in
{
  options.my.services.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };

  config = mkIf services.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      # authKeyFile = config.age.secrets.tailscale.path;
    };
  };
}
