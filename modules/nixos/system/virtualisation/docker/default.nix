{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.docker = {
    enable = mkEnableOption "Docker";
  };

  config = mkIf system.virtualisation.docker.enable {
    virtualisation.docker = mkIf (user.wsl.enable != true) {
      enable = true;

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    users.users.${user.name}.extraGroups = [ "docker" ];

    wsl.docker-desktop = mkIf user.wsl.enable {
      enable = true;
    };
  };
}
