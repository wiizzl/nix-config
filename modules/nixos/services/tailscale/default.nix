{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) services;
in
{
  options.my.services.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };

  config = mkIf services.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.age.secrets.tailscale.path;
    };

    # systemd.services.tailscale-autoconnect = {
    #   description = "Automatic connection to Tailscale";

    #   after = [
    #     "network-pre.target"
    #     "tailscale.service"
    #   ];
    #   wants = [
    #     "network-pre.target"
    #     "tailscale.service"
    #   ];
    #   wantedBy = [ "multi-user.target" ];

    #   serviceConfig.Type = "oneshot";

    #   script = with pkgs; ''
    #     sleep 2

    #     status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
    #     if [ $status = "Running" ]; then
    #       exit 0
    #     fi

    #     ${tailscale}/bin/tailscale up -authkey <my_key>
    #   '';
    # };
  };
}
