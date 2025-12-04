{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) services;

  authKey = config.age.secrets.tailscale.path;
in
{

  options.my.services.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };

  config = mkIf services.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = authKey;
    };
  };
}
