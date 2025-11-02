{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.docker = {
    enable = mkEnableOption "Docker engine";
  };

  config = mkIf system.virtualisation.docker.enable {
    virtualisation.docker = {
      enable = true;

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    users.users.${user.name}.extraGroups = [ "docker" ];
  };
}
