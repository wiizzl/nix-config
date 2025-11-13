{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.docker = {
    enable = mkEnableOption "Docker";
    lazydocker.enable = mkEnableOption "lazydocker TUI";
  };

  config = mkIf system.virtualisation.docker.enable {
    virtualisation.docker = {
      enable = true;
    };

    environment.systemPackages = mkIf system.virtualisation.docker.lazydocker.enable [
      pkgs.lazydocker
    ];

    users.users.${user.name}.extraGroups = [ "docker" ];

    wsl.docker-desktop = mkIf user.wsl.enable {
      enable = true;
    };
  };
}
