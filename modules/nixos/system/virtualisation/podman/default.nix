{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system user;
in
{
  options.my.system.virtualisation.podman = {
    enable = mkEnableOption "Podman";
    docker-compat.enable = mkEnableOption "Docker compatibility mode";
    podman-desktop.enable = mkEnableOption "Podman Desktop GUI";
  };

  config = mkIf system.virtualisation.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = system.virtualisation.podman.docker-compat.enable;
      defaultNetwork.settings.dns_enabled = true;
    };

    users.users.${user.name}.extraGroups = [ "podman" ];

    environment.systemPackages = mkIf system.virtualisation.podman.podman-desktop.enable [
      pkgs.podman-desktop
    ];
  };
}
