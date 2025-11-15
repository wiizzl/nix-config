{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionals;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.docker = {
    enable = mkEnableOption "Docker";
    lazydocker.enable = mkEnableOption "lazydocker TUI";
    distrobox.enable = mkEnableOption "Distrobox";
  };

  config = mkIf system.virtualisation.docker.enable {
    virtualisation.docker = {
      enable = true;
    };

    environment.systemPackages =
      with pkgs;
      optionals system.virtualisation.docker.lazydocker.enable [
        lazydocker
      ]
      ++ optionals system.virtualisation.docker.distrobox.enable [
        distrobox
      ];

    users.users.${user.name}.extraGroups = [ "docker" ];

    wsl.docker-desktop = mkIf user.wsl.enable {
      enable = true;
    };
  };
}
